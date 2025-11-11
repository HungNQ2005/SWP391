package controller;

import dao.PerformersDAO;
import entity.Series;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Performers;


@WebServlet("/performer/*")
public class PerformersController extends HttpServlet {

    private final PerformersDAO dao = new PerformersDAO();
    private static final int PAGE_SIZE = 30;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null) {
            path = "/list";
        }
        switch (path) {
            case "/list":
                listPerformers(request, response);
                break;
            case "/detail":
                detailPerformer(request, response);
                break;
            case "/info":
                performerInformation(request, response);
                break;
            default:
                response.sendError(404, "Page Not Found!");
        }
    }

    private void listPerformers(HttpServletRequest request, HttpServletResponse response)
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
        int totalPerformers = dao.countPerformers();
        int totalPages = (int) Math.ceil((double) totalPerformers / PAGE_SIZE);
        if (currentPage < 1) {
            currentPage = 1;
        }
        if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages;
        }             
        List<Performers> list = dao.getPerformersByPage(currentPage, PAGE_SIZE);
        request.setAttribute("performers", list);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/PerformerList.jsp").forward(request, response);
    }

    private void detailPerformer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int performerId = Integer.parseInt(request.getParameter("id"));
        Performers performer = dao.getPerformerById(performerId);
        request.setAttribute("performer", performer);
        request.getRequestDispatcher("/Admin/PerformerDetail.jsp").forward(request, response);
    }

    private void performerInformation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idRaw = request.getParameter("id");
        int performerId = 1;
        try {
            if (idRaw != null) {
                performerId = Integer.parseInt(idRaw);
            }
        } catch (NumberFormatException e) {
            performerId = 1;
        }
        Performers performer = dao.getPerformerById(performerId);
        List<Series> seriesList = dao.getSeriesByPerformer(performerId);
        request.setAttribute("performer", performer);
        request.setAttribute("seriesList", seriesList);
        request.getRequestDispatcher("/PerformersInfomation.jsp").forward(request, response);

    }
}
