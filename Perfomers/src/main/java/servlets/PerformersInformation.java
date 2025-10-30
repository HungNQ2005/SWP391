package servlets;

import dao.PerformersDAO;
import dao.SeriesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Performers;
import model.Series;

@WebServlet("/performerInformation")
public class PerformersInformation extends HttpServlet {
    PerformersDAO dao = new PerformersDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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
        SeriesDAO sdao = new SeriesDAO();
        List<Series> seriesList = sdao.getSeriesByPerformer(performerId);
        request.setAttribute("performer", performer);
        request.setAttribute("seriesList", seriesList);
        request.getRequestDispatcher("/UI/PerformersInfomation.jsp").forward(request, response);
    }
}
