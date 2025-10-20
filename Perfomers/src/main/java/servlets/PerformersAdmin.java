package servlets;

import dao.PerformersDAO;
import model.Performers;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

/**
 *
 * @author Vo Thi Phi Yen - CE190428
 */
@WebServlet("/PerformersAdmin")
public class PerformersAdmin extends HttpServlet {

    private static final int PAGE_SIZE = 10;
    private final PerformersDAO dao = new PerformersDAO();

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

            req.getRequestDispatcher("UI/PerformersDashboard.jsp").forward(req, resp);

        } catch (Exception e) {
            log("Error in doGet: ", e);
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

            session.setAttribute("success", switch (action) {
                case "add" ->
                    "Performer added successfully!";
                case "edit" ->
                    "Performer updated successfully!";
                case "delete" ->
                    "Performer deleted successfully!";
                default ->
                    null;
            });

        } catch (IllegalArgumentException | IllegalStateException ex) {
            session.setAttribute("error", ex.getMessage());
        } catch (Exception e) {
            log("Error in doPost: ", e);
            session.setAttribute("error", "An unexpected error occurred!");
        }

        resp.sendRedirect(buildRedirectUrl(req, keyword));
    }

    private void handleAdd(HttpServletRequest req) throws Exception {
        String name = safe(req.getParameter("name"));
        String photo = safe(req.getParameter("photo_url"));
        String gender = safe(req.getParameter("gender"));
        String desc = safe(req.getParameter("description"));
        String dob = safe(req.getParameter("date_of_birth"));
        String nation = safe(req.getParameter("nationality"));

        if (name.isEmpty() || photo.isEmpty() || gender.isEmpty() || dob.isEmpty() || nation.isEmpty()) {
            throw new IllegalArgumentException("All required performer fields must be filled!");
        }

        if (dao.existsPerformer(name, dob, nation, gender, photo, desc)) {
            throw new IllegalStateException("A performer with identical details already exists!");
        }

        dao.addPerformers(new Performers(0, name, photo, gender, desc, dob, nation));
    }

    private void handleEdit(HttpServletRequest req) throws Exception {
        int id = parseId(req.getParameter("id"), "Invalid performer ID for editing.");
        dao.updatePerformers(new Performers(
                id,
                safe(req.getParameter("name")),
                safe(req.getParameter("photo_url")),
                safe(req.getParameter("gender")),
                safe(req.getParameter("description")),
                safe(req.getParameter("date_of_birth")),
                safe(req.getParameter("nationality"))
        ));
    }

    private void handleDelete(HttpServletRequest req) throws Exception {
        int id = parseId(req.getParameter("id"), "Invalid performer ID for deletion.");
        dao.deletePerformers(id);
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

    private int parseId(String idParam, String errorMsg) {
        if (idParam == null || !idParam.matches("\\d+")) {
            throw new IllegalArgumentException(errorMsg);
        }
        return Integer.parseInt(idParam);
    }

    private String buildRedirectUrl(HttpServletRequest req, String keyword) throws IOException {
        int page = getValidPage(req.getParameter("currentPage"), keyword);
        StringBuilder url = new StringBuilder("PerformersAdmin?page=").append(page);
        if (!keyword.isEmpty()) {
            url.append("&keyword=").append(URLEncoder.encode(keyword, StandardCharsets.UTF_8));
        }
        return url.toString();
    }

    private String safe(String s) {
        return s == null ? "" : s.trim();
    }
}
