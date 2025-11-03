package controller;

import dao.AdsDAO;
import entity.Ads;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.Timestamp;


@WebServlet(name = "AdsController", urlPatterns = {"/Ads"})
public class AdsController extends HttpServlet {

    private AdsDAO dao = new AdsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("adsList", dao.getAllAds());
        request.getRequestDispatcher("/Admin/AdsDashBoard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if ("add".equals(action) || "update".equals(action)) {
            Ads ads = new Ads();
            ads.setAds_name(request.getParameter("ads_name"));
            ads.setAds_image((request.getParameter("ads_image")));
            ads.setAds_link((request.getParameter("ads_link")));
            ads.setStatus(request.getParameter("status"));

            if ("update".equals(action)) {
                ads.setAds_ID(Integer.parseInt(request.getParameter("ads_ID")));
                ads.setUpdated_at(new Timestamp(System.currentTimeMillis()));
                dao.updateAds(ads);
            } else {
                dao.addAds(ads);
            }

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("ads_ID"));
            dao.deleteAds(id);
        }

        response.sendRedirect("Ads");
    }
}