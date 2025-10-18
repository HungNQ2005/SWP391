package servlets;

import dao.PerformersDAO;
import model.Performers;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

class Constants {

    static final int PAGE_SIZE = 10;
    static final String ACTION_ADD = "add";
    static final String ACTION_EDIT = "edit";
    static final String ACTION_DELETE = "delete";
    static final String PARAM_PAGE = "page";
    static final String PARAM_KEYWORD = "keyword";
    static final String PARAM_ACTION = "action";
    static final String PARAM_ID = "id";
}

@WebServlet("/PerformersAdmin")
public class PerformersAdmin extends HttpServlet {

    private final PerformersDAO dao = new PerformersDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String keyword = getKeyword(req);

        int page = 1;
        try {
            page = getValidPage(req.getParameter(Constants.PARAM_PAGE), keyword);

            List<Performers> performers = keyword.trim().isEmpty()
                    ? dao.getPerformersByPage(page, Constants.PAGE_SIZE)
                    : dao.getPerformersByPageAndKeyword(page, Constants.PAGE_SIZE, keyword);

            int total = keyword.trim().isEmpty()
                    ? dao.countPerformers()
                    : dao.countPerformersByKeyword(keyword);

            if (total == 0) {
                req.setAttribute("message", "No performers found matching keyword \"" + keyword + "\"");
            }

            int totalPages = (int) Math.ceil((double) total / Constants.PAGE_SIZE);

            req.setAttribute("performers", performers);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("currentPage", page);
            req.setAttribute("keyword", keyword);

            req.getRequestDispatcher("UI/PerformersDashboard.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            log("Error in doGet (PerformersAdmin): " + e.getMessage(), e);
            if (!resp.isCommitted()) {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to load performer list.");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter(Constants.PARAM_ACTION);
        String keyword = getKeyword(req);
        String redirectUrl = "PerformersAdmin";

        try {
            if (action == null || action.trim().isEmpty()) {
                log("No valid action received.");
                resp.sendRedirect("PerformersAdmin");
                return;
            }

            switch (action) {
                case Constants.ACTION_ADD ->
                    handleAdd(req, keyword);
                case Constants.ACTION_EDIT ->
                    handleEdit(req);
                case Constants.ACTION_DELETE ->
                    handleDelete(req);
                default ->
                    log("Unknown action: " + action);
            }

        } catch (Exception e) {
            e.printStackTrace();
            log("Error in doPost (PerformersAdmin): " + e.getMessage(), e);
            req.getSession().setAttribute("error", "An error occurred while processing the request!");
        }

        try {
            redirectUrl = buildRedirectUrl(req, keyword);
        } catch (Exception e) {
            log("Error while building redirect URL: " + e.getMessage(), e);
        }

        if (!resp.isCommitted()) {
            resp.sendRedirect(redirectUrl);
        }
    }

    private void handleAdd(HttpServletRequest req, String keyword) throws Exception {
        String name = safe(req.getParameter("name"));
        String photo = safe(req.getParameter("photo_url"));
        String gender = safe(req.getParameter("gender"));
        String desc = safe(req.getParameter("description"));
        String dob = safe(req.getParameter("date_of_birth"));
        String nation = safe(req.getParameter("nationality"));

        if (name.isEmpty() || photo.isEmpty() || gender.isEmpty() || dob.isEmpty() || nation.isEmpty()) {
            throw new IllegalArgumentException("Missing required performer information.");
        }

        if (dao.existsPerformer(name, dob, nation)) {
            throw new IllegalStateException("This performer already exists in the system!");
        }

        dao.addPerformers(new Performers(0, name, photo, gender, desc, dob, nation));
    }

    private void handleEdit(HttpServletRequest req) throws Exception {
        String idStr = req.getParameter(Constants.PARAM_ID);
        if (idStr == null || !idStr.matches("\\d+")) {
            throw new IllegalArgumentException("Invalid performer ID for editing.");
        }

        int id = Integer.parseInt(idStr);
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
        String idStr = req.getParameter(Constants.PARAM_ID);
        if (idStr == null || !idStr.matches("\\d+")) {
            throw new IllegalArgumentException("Invalid performer ID for deletion.");
        }

        int id = Integer.parseInt(idStr);
        dao.deletePerformers(id);
    }

    private String getKeyword(HttpServletRequest req) {
        String kw = req.getParameter(Constants.PARAM_KEYWORD);
        return kw != null ? kw.trim() : "";
    }

    private int getValidPage(String pageParam, String keyword) {
        int page = 1;
        try {
            if (pageParam != null && pageParam.matches("\\d+")) {
                page = Integer.parseInt(pageParam);
                int total = keyword.trim().isEmpty()
                        ? dao.countPerformers()
                        : dao.countPerformersByKeyword(keyword);
                int totalPages = (int) Math.ceil((double) total / Constants.PAGE_SIZE);
                if (page < 1) {
                    page = 1;
                }
                if (page > totalPages && totalPages > 0) {
                    page = totalPages;
                }
            }
        } catch (Exception e) {
            log("Error validating page number: " + e.getMessage(), e);
            page = 1;
        }
        return page;
    }

    private String buildRedirectUrl(HttpServletRequest req, String keyword) throws IOException {
        int page = getValidPage(req.getParameter("currentPage"), keyword);
        String url = "PerformersAdmin?page=" + page;
        if (!keyword.trim().isEmpty()) {
            url += "&keyword=" + URLEncoder.encode(keyword, StandardCharsets.UTF_8);
        }
        return url;
    }

    private String safe(String param) {
        return param == null ? "" : param.trim();
    }
}
