package servlets;

import dao.PerformersDAO;
import model.Performers;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author: Vo Thi Phi Yen - CE190428
 */
@WebServlet("/performersadmin")
public class PerformersAdmin extends HttpServlet {

    private int PAGE_SIZE = 10;
    private String VIEW_PATH = "UI/PerformersDashboard.jsp";
    private PerformersDAO dao = new PerformersDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String keyword = safe(req.getParameter("keyword"));
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

        String action = safe(req.getParameter("action"));
        String keyword = safe(req.getParameter("keyword"));
        String currentPage = safe(req.getParameter("currentPage"));
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

        resp.sendRedirect(buildRedirectUrl(currentPage, keyword));
    }

    private void handleAdd(HttpServletRequest req) throws Exception {
        Performers p = extractPerformer(req, 0);
        List<String> errors = validatePerformer(p, false);

        if (dao.existsPhoto(p.getPhoto_url())) {
            errors.add("This photo is already used by another performer");
        }
        if (dao.existsPerformer(p.getName(), p.getDate_of_birth(),
                p.getNationality(), p.getGender(), p.getPhoto_url(), p.getDescription())) {
            errors.add("A performer with identical details already exists");
        }

        if (!errors.isEmpty()) {
            throw new IllegalArgumentException(String.join("; ", errors));
        }
        dao.addPerformers(p);
    }

    private void handleEdit(HttpServletRequest req) throws Exception {
        int id = safeInt(req.getParameter("id"), "Invalid performer ID for editing");
        Performers p = extractPerformer(req, id);
        List<String> errors = validatePerformer(p, true);

        if (dao.existsPhotoForOtherId(p.getPhoto_url(), id)) {
            errors.add("This photo is already used by another performer");
        }
        if (dao.existsPerformerForOtherId(p.getName(), p.getDate_of_birth(),
                p.getNationality(), p.getGender(), id)) {
            errors.add("Another performer with the same details already exists");
        }

        if (!errors.isEmpty()) {
            throw new IllegalArgumentException(String.join("; ", errors));
        }
        dao.updatePerformers(p);
    }

    private void handleDelete(HttpServletRequest req) {
        int id = safeInt(req.getParameter("id"), "Invalid performer ID for deletion.");
        HttpSession session = req.getSession();

        try {
            boolean success = dao.deletePerformers(id);
            if (success) {
                session.setAttribute("success", "Performer and their links deleted successfully.");
            } else {
                session.setAttribute("error", "Performer not found or already deleted.");
            }
        } catch (Exception e) {
            log("Error deleting performer", e);
            session.setAttribute("error", "An unexpected error occurred while deleting performer.");
        }
    }

    private Performers extractPerformer(HttpServletRequest req, int id) {
        return new Performers(
                id,
                safe(req.getParameter("name")),
                safe(req.getParameter("photo_url")),
                safe(req.getParameter("gender")),
                safe(req.getParameter("description")),
                safe(req.getParameter("date_of_birth")),
                safe(req.getParameter("nationality"))
        );
    }

    private List<String> validatePerformer(Performers performer, boolean isEdit) {
        List<String> errors = new ArrayList<>();

        if (performer.getName().isEmpty()) {
            errors.add("Name is required");
        } else if (!performer.getName().matches("^[\\p{L} .'-]+$")) {
            errors.add("Name must contain only letters, spaces, dots, apostrophes or hyphens");
        }

        if (performer.getPhoto_url().isEmpty()) {
            errors.add("Photo URL is required");
        }

        if (performer.getGender().isEmpty() || !performer.getGender().matches("Male|Female")) {
            errors.add("Gender must be 'Male' or 'Female'");
        }

        if (performer.getDate_of_birth().isEmpty()) {
            errors.add("Date of birth is required");
        } else {
            try {
                var date = java.time.LocalDate.parse(performer.getDate_of_birth());
                if (date.isAfter(java.time.LocalDate.now())) {
                    errors.add("Date of birth cannot be in the future");
                } else if (date.isBefore(java.time.LocalDate.now().minusYears(120))) {
                    errors.add("Date of birth cannot be more than 120 years ago");
                }
            } catch (Exception e) {
                errors.add("Invalid date format, must be yyyy-MM-dd");
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

    private int safeInt(String s, String errorMsg) {
        if (s == null || !s.matches("\\d+")) {
            throw new IllegalArgumentException(errorMsg);
        }
        return Integer.parseInt(s);
    }

    private String buildRedirectUrl(String currentPage, String keyword) throws IOException {
        StringBuilder url = new StringBuilder("performersadmin?page=")
                .append(currentPage.isEmpty() ? "1" : currentPage);
        if (!keyword.isEmpty()) {
            url.append("&keyword=").append(URLEncoder.encode(keyword, StandardCharsets.UTF_8));
        }
        return url.toString();
    }

    private String safe(String s) {
        return s == null ? "" : s.trim();
    }
}
