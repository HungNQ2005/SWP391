package servlets;

import dao.PerformersDAO;
import model.Performers;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
public class PerformersCRUD extends HttpServlet {
    private final PerformersDAO dao = new PerformersDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int page = getValidPage(req.getParameter(Constants.PARAM_PAGE), getKeyword(req));
        String keyword = getKeyword(req);
        
        List<Performers> performers = keyword.trim().isEmpty() 
            ? dao.getPerformersByPage(page, Constants.PAGE_SIZE)
            : dao.getPerformersByPageAndKeyword(page, Constants.PAGE_SIZE, keyword);
            
        int total = keyword.trim().isEmpty() 
            ? dao.countPerformers() 
            : dao.countPerformersByKeyword(keyword);
        int totalPages = (int) Math.ceil((double) total / Constants.PAGE_SIZE);
        
        req.setAttribute("performers", performers);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("currentPage", page);
        req.setAttribute("keyword", keyword);
        
        try {
            req.getRequestDispatcher("UI/PerformersDashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter(Constants.PARAM_ACTION);
        String keyword = getKeyword(req);
        String redirectUrl = buildRedirectUrl(req, keyword);
        
        try {
            switch (action) {
                case Constants.ACTION_ADD -> {
                    dao.addPerformers(new Performers(0,
                        req.getParameter("name"), req.getParameter("photo_url"),
                        req.getParameter("gender"), req.getParameter("description"),
                        req.getParameter("date_of_birth"), req.getParameter("nationality")
                    ));
                    resp.sendRedirect("PerformersAdmin?page=1");
                    return;
                }
                case Constants.ACTION_EDIT -> {
                    int id = Integer.parseInt(req.getParameter(Constants.PARAM_ID));
                    dao.updatePerformers(new Performers(id,
                        req.getParameter("name"), req.getParameter("photo_url"),
                        req.getParameter("gender"), req.getParameter("description"),
                        req.getParameter("date_of_birth"), req.getParameter("nationality")
                    ));
                }
                case Constants.ACTION_DELETE -> {
                    dao.deletePerformers(Integer.parseInt(req.getParameter(Constants.PARAM_ID)));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(redirectUrl);
    }
    
    private String getKeyword(HttpServletRequest req) {
        return req.getParameter(Constants.PARAM_KEYWORD) != null 
            ? req.getParameter(Constants.PARAM_KEYWORD) : "";
    }
    
    private int getValidPage(String pageParam, String keyword) {
        int page = 1;
        if (pageParam != null && pageParam.matches("\\d+")) {
            page = Integer.parseInt(pageParam);
            int total = keyword.trim().isEmpty() ? dao.countPerformers() : dao.countPerformersByKeyword(keyword);
            int totalPages = (int) Math.ceil((double) total / Constants.PAGE_SIZE);
            if (page < 1) page = 1;
            if (page > totalPages && totalPages > 0) page = totalPages;
        }
        return page;
    }
    
    private String buildRedirectUrl(HttpServletRequest req, String keyword) throws IOException {
        int page = getValidPage(req.getParameter("currentPage"), keyword);
        String url = "PerformersAdmin?page=" + page;
        if (!keyword.trim().isEmpty()) 
            url += "&keyword=" + URLEncoder.encode(keyword, StandardCharsets.UTF_8);
        return url;
    }
}