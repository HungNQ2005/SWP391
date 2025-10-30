package servlets;

import dao.PerformersDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Performers;

@WebServlet("/performers")
public class PerformerListServlet extends HttpServlet {

    private final PerformersDAO performerDAO = new PerformersDAO();
    private static final int PAGE_SIZE = 30;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pageParam = request.getParameter("page");
        int currentPage = 1;
        try {
            if (pageParam != null) {
                currentPage = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            currentPage = 1;
        }
        int totalPerformers = performerDAO.countPerformers();
        int totalPages = (int) Math.ceil((double) totalPerformers / PAGE_SIZE);
        if (currentPage < 1) {
            currentPage = 1;
        }
        if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages;
        }
        List<Performers> list = performerDAO.getPerformersByPage(currentPage, PAGE_SIZE);
        request.setAttribute("performers", list);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/UI/PerformerList.jsp").forward(request, response);
    }
}
