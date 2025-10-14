/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AdminDAO;
import entity.Category;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import entity.Series;
import java.util.Arrays;
import java.util.stream.Collectors;

/**
 *
 * @author Chau Tan Cuong - CE190026
 */
@WebServlet(name = "AdminMovieController", urlPatterns = {"/adminMovie"})
public class AdminMovieController extends HttpServlet {

    AdminDAO adminDAO = new AdminDAO();
    AdminDAO seriesCategoryDAO = new AdminDAO();

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("sendSeriesDashboard")) {
            List<Series> list = adminDAO.getAllSeriesForAdmin();
            List<Category> listCategory = adminDAO.getAllCategories();
            request.setAttribute("listCategory", listCategory);
            request.setAttribute("listSeries", list);
            request.getRequestDispatcher("/Admin/MovieDashBoard.jsp").forward(request, response);
            return;
        }
        if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            adminDAO.deleteSeriesForAdmin(id);
            response.sendRedirect("adminMovie?action=sendSeriesDashboard");
            return;
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            Series s = new Series();
            s.setTitle(request.getParameter("title"));
            s.setDescription(request.getParameter("description"));
            s.setReleaseYear(Integer.parseInt(request.getParameter("release_year")));
            s.setCountry(request.getParameter("country"));
            s.setPosteUrl(request.getParameter("poster_url"));
            s.setTrailerUrl(request.getParameter("trailer_url"));
            s.setTypeId(Integer.parseInt(request.getParameter("type_id")));

            int newSeriesId = adminDAO.insertSeriesForAdmin(s);

            //Them the loai
            String[] categoryIds = request.getParameterValues("category_ids");
            if (categoryIds != null) {
                List<Integer> catList = Arrays.stream(categoryIds)
                        .map(Integer::parseInt)
                        .collect(Collectors.toList());
                seriesCategoryDAO.insertSeriesCategories(newSeriesId, catList);

            }
            response.sendRedirect("adminMovie?action=sendSeriesDashboard");
            return;
        }

        if ("update".equals(action)) {
            Series s = new Series();
            s.setSeriesID(Integer.parseInt(request.getParameter("series_id")));
            s.setTitle(request.getParameter("title"));
            s.setDescription(request.getParameter("description"));
            s.setReleaseYear(Integer.parseInt(request.getParameter("release_year")));
            s.setCountry(request.getParameter("country"));
            s.setPosteUrl(request.getParameter("poster_url"));
            s.setTrailerUrl(request.getParameter("trailer_url"));
            s.setTypeId(Integer.parseInt(request.getParameter("type_id")));

            boolean updated = adminDAO.updateSeriesForAdmin(s);

            seriesCategoryDAO.deleteSeriesCategories(s.getSeriesID());
            String[] categoryIds = request.getParameterValues("category_ids");
            if (categoryIds != null) {
                List<Integer> catList = Arrays.stream(categoryIds)
                        .map(Integer::parseInt)
                        .collect(Collectors.toList());
                seriesCategoryDAO.insertSeriesCategories(s.getSeriesID(), catList);
            }

            response.sendRedirect("adminMovie?action=sendSeriesDashboard");
            return;
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
