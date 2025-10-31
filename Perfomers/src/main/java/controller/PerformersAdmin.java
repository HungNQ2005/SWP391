package controller;

import dao.PerformersDAO;
import model.Performers;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/performer/admin")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)

public class PerformersAdmin extends HttpServlet {

    private static final int PAGE_SIZE = 10;
    private static final String VIEW_PATH = "/admin/PerformersDashboard.jsp";
    private final PerformersDAO dao = new PerformersDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String keyword = req.getParameter("keyword");
        if (keyword == null) {
            keyword = "";
        }
        keyword = keyword.trim();

        int page = getValidPage(req.getParameter("page"), keyword);

        try {
            List<Performers> performers = keyword.isEmpty()
                    ? dao.getPerformersByPage(page, PAGE_SIZE)
                    : dao.getPerformersByPageAndKeyword(page, PAGE_SIZE, keyword);

            int total = keyword.isEmpty()
                    ? dao.countPerformers()
                    : dao.countPerformersByKeyword(keyword);

            if (total == 0 && !keyword.isEmpty()) {
                req.setAttribute("message", "No performers found matching \"" + keyword + "\"");
            }

            req.setAttribute("performers", performers);
            req.setAttribute("totalPages", (int) Math.ceil((double) total / PAGE_SIZE));
            req.setAttribute("currentPage", page);
            req.setAttribute("keyword", keyword);

            req.getRequestDispatcher(VIEW_PATH).forward(req, resp);

        } catch (Exception e) {
            log("Error in doGet", e);
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Failed to load performer list.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        String keyword = req.getParameter("keyword");
        if (keyword == null) {
            keyword = "";
        }

        String currentPage = req.getParameter("currentPage");
        if (currentPage == null) {
            currentPage = "1";
        }

        HttpSession session = req.getSession();

        try {
            switch (action) {
                case "add" ->
                    handleAdd(req);
                case "edit" ->
                    handleEdit(req);
                case "delete" ->
                    handleDelete(req);
                default ->
                    throw new IllegalArgumentException("Unknown action: " + action);
            }

            String successMsg = switch (action) {
                case "add" ->
                    "Performer added successfully!";
                case "edit" ->
                    "Performer updated successfully!";
                case "delete" ->
                    "Performer deleted successfully!";
                default ->
                    null;
            };
            if (successMsg != null) {
                session.setAttribute("success", successMsg);
            }

        } catch (Exception e) {
            log("Error in doPost", e);
            session.setAttribute("error",
                    (e instanceof IllegalArgumentException || e instanceof IllegalStateException)
                            ? e.getMessage()
                            : "An unexpected error occurred!");
        }

        resp.sendRedirect(buildRedirectUrl(req, currentPage, keyword));

    }

    private void handleAdd(HttpServletRequest req) throws Exception {
        Performers p = extractPerformer(req, 0);
        List<String> errors = validatePerformer(p);

        if (dao.existsPhoto(p.getPhotoUrl())) {
            errors.add("This photo is already used by another performer");
        }
        if (dao.existsPerformer(p.getName(), p.getDateOfBirth(),
                p.getNationality(), p.getGender(), p.getPhotoUrl(), p.getDescription())) {
            errors.add("A performer with identical details already exists");
        }

        if (!errors.isEmpty()) {
            throw new IllegalArgumentException(String.join("; ", errors));
        }
        dao.addPerformers(p);
    }

    private void handleEdit(HttpServletRequest req) throws Exception {
        String idStr = req.getParameter("id");
        if (idStr == null || !idStr.matches("\\d+")) {
            throw new IllegalArgumentException("Invalid performer ID for editing");
        }
        int id = Integer.parseInt(idStr);

        Performers p = extractPerformer(req, id);
        List<String> errors = validatePerformer(p);

        if (dao.existsPhotoForOtherId(p.getPhotoUrl(), id)) {
            errors.add("This photo is already used by another performer");
        }
        if (dao.existsPerformerForOtherId(p.getName(), p.getDateOfBirth(),
                p.getNationality(), p.getGender(), id)) {
            errors.add("Another performer with the same details already exists");
        }

        if (!errors.isEmpty()) {
            throw new IllegalArgumentException(String.join("; ", errors));
        }
        dao.updatePerformers(p);
    }

    private void handleDelete(HttpServletRequest req) {
        String idStr = req.getParameter("id");
        HttpSession session = req.getSession();

        if (idStr == null || !idStr.matches("\\d+")) {
            session.setAttribute("error", "Invalid performer ID for deletion.");
            return;
        }

        int id = Integer.parseInt(idStr);

        try {
            boolean success = dao.deletePerformers(id);
            if (success) {
                session.setAttribute("success", "Performer deleted successfully.");
            } else {
                session.setAttribute("error", "Performer not found or already deleted.");
            }
        } catch (Exception e) {
            log("Error deleting performer", e);
            session.setAttribute("error", "An unexpected error occurred while deleting performer.");
        }
    }

    private Performers extractPerformer(HttpServletRequest req, int id) throws IOException, ServletException {
        String name = req.getParameter("name") != null ? req.getParameter("name").trim() : "";
        Part filePart = req.getPart("photo");
        String fileName = extractFileName(filePart);
        String photo = null;
        if (fileName != null && !fileName.isEmpty() && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("/images");
            java.io.File uploadDir = new java.io.File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            filePart.write(uploadPath + java.io.File.separator + fileName);
            photo = "images/" + fileName;
        } else {

            String existingPhoto = req.getParameter("existingPhoto");
            photo = (existingPhoto != null && !existingPhoto.isEmpty())
                    ? existingPhoto.trim()
                    : "";
        }
        String gender = req.getParameter("gender") != null ? req.getParameter("gender").trim() : "";
        String desc = req.getParameter("description") != null ? req.getParameter("description").trim() : "";
        String dob = req.getParameter("date_of_birth") != null ? req.getParameter("date_of_birth").trim() : "";
        String nation = req.getParameter("nationality") != null ? req.getParameter("nationality").trim() : "";

        return new Performers(id, name, photo, gender, desc, dob, nation);
    }

    private List<String> validatePerformer(Performers performer) {
        List<String> errors = new ArrayList<>();

        if (performer.getName().isEmpty()) {
            errors.add("Name is required");
        } else if (!performer.getName().matches("^[\\p{L} .'-]+$")) {
            errors.add("Name must contain only letters and symbols like .'-");
        }

        if (performer.getPhotoUrl().isEmpty()) {
            errors.add("Photo URL is required");
        }

        if (performer.getGender().isEmpty() || !performer.getGender().matches("Male|Female")) {
            errors.add("Gender must be Male or Female");
        }

        if (performer.getDateOfBirth().isEmpty()) {
            errors.add("Date of birth is required");
        } else {
            try {
                var date = java.time.LocalDate.parse(performer.getDateOfBirth());
                if (date.isAfter(java.time.LocalDate.now())) {
                    errors.add("Date of birth cannot be in the future");
                } else if (date.isBefore(java.time.LocalDate.now().minusYears(120))) {
                    errors.add("Date of birth cannot be more than 120 years ago");
                }
            } catch (Exception e) {
                errors.add("Invalid date format (yyyy-MM-dd)");
            }
        }

        if (performer.getNationality().isEmpty()) {
            errors.add("Nationality is required");
        }

        return errors;
    }

    private int getValidPage(String pageParam, String keyword) {
        int page = 1;
        try {
            if (pageParam != null && pageParam.matches("\\d+")) {
                page = Integer.parseInt(pageParam);
                int total = keyword.isEmpty()
                        ? dao.countPerformers()
                        : dao.countPerformersByKeyword(keyword);
                int totalPages = Math.max(1, (int) Math.ceil((double) total / PAGE_SIZE));
                page = Math.min(Math.max(1, page), totalPages);
            }
        } catch (Exception e) {
            log("Invalid page number: " + e.getMessage());
        }
        return page;
    }

    private String buildRedirectUrl(HttpServletRequest req, String currentPage, String keyword) throws IOException {
        StringBuilder url = new StringBuilder(req.getContextPath())
                .append("/performer/admin?page=")
                .append(currentPage.isEmpty() ? "1" : currentPage);

        if (!keyword.isEmpty()) {
            url.append("&keyword=").append(URLEncoder.encode(keyword, StandardCharsets.UTF_8));
        }
        return url.toString();
    }

    private String extractFileName(Part part) {
        if (part == null) {
            return null;
        }
        String contentDisp = part.getHeader("content-disposition");
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 2, token.length() - 1);
            }
        }
        return null;
    }

}
