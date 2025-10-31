package controller;

import dao.PerformersDAO;
import model.Series;
import model.Performers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "PerformerSeries", urlPatterns = {"/performer/series"})
public class PerformerSeries extends HttpServlet {

    PerformersDAO dao = new PerformersDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Series> seriesList = dao.getAllSeries();
        List<Performers> performerList = dao.getAllPerformers();

        request.setAttribute("seriesList", seriesList);
        request.setAttribute("performerList", performerList);

        String seriesIdStr = request.getParameter("seriesId");
        int page = 1;
        int pageSize = 10;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        if (seriesIdStr != null) {
            int seriesId = Integer.parseInt(seriesIdStr);
            List<Performers> allAssigned = dao.getPerformersBySeries(seriesId);
            int total = allAssigned.size();
            int totalPages = (int) Math.ceil((double) total / pageSize);
            int fromIndex = (page - 1) * pageSize;
            int toIndex = Math.min(fromIndex + pageSize, total);
            List<Performers> assignedPerformers
                    = (fromIndex < total) ? allAssigned.subList(fromIndex, toIndex) : List.of();
            request.setAttribute("assignedPerformers", assignedPerformers);
            request.setAttribute("selectedSeriesId", seriesId);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
        }

        request.getRequestDispatcher("/admin/PerformerSeries.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        int seriesId = Integer.parseInt(request.getParameter("seriesId"));
        String performerIdStr = request.getParameter("performerId");

        if (performerIdStr != null && !performerIdStr.isEmpty()) {
            int performerId = Integer.parseInt(performerIdStr);
            if ("add".equals(action)) {
                dao.addPerformerToSeries(seriesId, performerId);
            } else if ("remove".equals(action)) {
                dao.removePerformerFromSeries(seriesId, performerId);
            }
        }

        response.sendRedirect(request.getContextPath() + "/performer/series?seriesId=" + seriesId);
    }
}
