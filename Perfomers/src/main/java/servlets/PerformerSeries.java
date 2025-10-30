package servlets;

import dao.PerformersDAO;
import dao.SeriesDAO;
import model.Series;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Performers;

@WebServlet(name = "PerformerSeries", urlPatterns = {"/performerseries"})
public class PerformerSeries extends HttpServlet {

    SeriesDAO seriesDao = new SeriesDAO();
    PerformersDAO dao = new PerformersDAO();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Series> seriesList = seriesDao.getAllSeries();
        List<Performers> performerList = dao.getAllPerformers();
        request.setAttribute("seriesList", seriesList);
        request.setAttribute("performerList", performerList);

        String seriesIdStr = request.getParameter("seriesId");
        int page = 1;
        int pageSize = 10; // 10 diễn viên/trang
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        if (seriesIdStr != null) {
            int seriesId = Integer.parseInt(seriesIdStr);
            List<Performers> allAssigned = seriesDao.getPerformersBySeries(seriesId);

            // Tính phân trang
            int total = allAssigned.size();
            int totalPages = (int) Math.ceil((double) total / pageSize);
            int fromIndex = (page - 1) * pageSize;
            int toIndex = Math.min(fromIndex + pageSize, total);

            List<Performers> assignedPerformers;
            if (fromIndex < total) {
                assignedPerformers = allAssigned.subList(fromIndex, toIndex);
            } else {
                assignedPerformers = List.of();
            }

            request.setAttribute("assignedPerformers", assignedPerformers);
            request.setAttribute("selectedSeriesId", seriesId);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
        }

        request.getRequestDispatcher("/UI/PerformerSeries.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action"); // add hoặc remove
        int seriesId = Integer.parseInt(request.getParameter("seriesId"));
        String performerIdStr = request.getParameter("performerId");

        if (performerIdStr != null && !performerIdStr.isEmpty()) {
            int performerId = Integer.parseInt(performerIdStr);

            if ("add".equals(action)) {
                seriesDao.addPerformerToSeries(seriesId, performerId); // bạn cần tạo method này
            } else if ("remove".equals(action)) {
                seriesDao.removePerformerFromSeries(seriesId, performerId); // method xóa
            }
        }

        // Redirect về trang GET với seriesId để load lại UI
        response.sendRedirect("performerseries?seriesId=" + seriesId);
    }
}
