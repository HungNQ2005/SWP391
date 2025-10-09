/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import entity.Series;
import dao.MovieDAO;
import entity.Category;

/**
 *
 * @author Chau Tan Cuong - CE190026
 */
@WebServlet(name = "SeriesController", urlPatterns = {"/series"})
public class SeriesController extends HttpServlet {

    MovieDAO categoryDAO = new MovieDAO();

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
        MovieDAO movieDAO = new MovieDAO();
        if (action.equals("allOfSeries")) {
            List<Series> listSeries = movieDAO.getAllSeries();
            List<Category> listCategory = categoryDAO.getAllCategories();
            request.setAttribute("listCategory", listCategory);
            request.setAttribute("listSeries", listSeries);
            request.getRequestDispatcher("movie.jsp").forward(request, response);

        }
        if (action.equals("sendMovieInfo")) {
            String idFlim = request.getParameter("id");
            if (idFlim == null || idFlim.isEmpty()) {
                response.sendRedirect("series?action=allOfSeries");
                return;
            }

            int id = Integer.parseInt(idFlim);
            Series movie = movieDAO.getSeriesById(id);

            if (movie == null) {
                response.sendRedirect("error.jsp");
                return;
            }

            request.setAttribute("movie", movie);
            request.getRequestDispatcher("MovieInfo.jsp").forward(request, response);
        }

        if (action.endsWith("filterByCategory")) {
            String categoryIdRaw = request.getParameter("categoryId");

            if (categoryIdRaw == null || categoryIdRaw.isEmpty()) {
                response.sendRedirect("series?action=allOfSeries");
                return;
            }

            int categoryId = Integer.parseInt(categoryIdRaw);
            List<Series> listSeries = movieDAO.getSeriesByCategoryId(categoryId);

            List<Category> listCategory = categoryDAO.getAllCategories();

            request.setAttribute("listSeries", listSeries);
            request.setAttribute("listCategory", listCategory);
            request.setAttribute("selectedCategory", categoryId);

            request.getRequestDispatcher("movie.jsp").forward(request, response);
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
