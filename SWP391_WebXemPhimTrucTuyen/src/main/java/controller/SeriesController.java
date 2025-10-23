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

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

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
    MovieDAO movieDAO = new MovieDAO();
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "series?action=allOfSeries";
        }
        if (action.equals("allOfSeries")) {
            int page = 1;
            int limit = 1; // số phim mỗi trang
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            int offset = (page - 1) * limit;

            // Lấy danh sách phim theo trang
            List<Series> listSeries = movieDAO.getSeriesByPage(offset, limit);
            int totalSeries = movieDAO.getTotalSeriesCount();
            int totalPages = (int) Math.ceil((double) totalSeries / limit);

            // Lấy danh mục và danh sách quốc gia
            List<Category> listCategory = categoryDAO.getAllCategories();
            Set<String> listCountry = new LinkedHashSet<>();
            for (Series s : movieDAO.getAllSeries()) {
                if (s.getCountry() != null && !s.getCountry().isEmpty()) {
                    listCountry.add(s.getCountry());
                }
            }

            request.setAttribute("listCategory", listCategory);
            request.setAttribute("listSeries", listSeries);
            request.setAttribute("listCountry", listCountry);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("movie.jsp").forward(request, response);
            return;

        }

        if (action.equals("sendMovieInfo")) {
            String idFlim = request.getParameter("id");
            if (idFlim == null || idFlim.isEmpty()) {
                response.sendRedirect("series?action=allOfSeries");
                return;
            }

            int id = Integer.parseInt(idFlim);
            Series movie = movieDAO.getSeriesById(id);
            List<Category> listCategory = categoryDAO.getAllCategories();

            List<Series> allSeries = movieDAO.getAllSeries();
            Set<String> listCountry = new LinkedHashSet<>();
            for (Series s : allSeries) {
                if (s.getCountry() != null && !s.getCountry().isEmpty()) {
                    listCountry.add(s.getCountry());
                }
            }

            if (movie == null) {
                response.sendRedirect("error.jsp");
                return;
            }
            request.setAttribute("listCategory", listCategory);
            request.setAttribute("movie", movie);
            request.setAttribute("listCountry", listCountry);
            request.getRequestDispatcher("MovieInfo.jsp").forward(request, response);
            return;
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

            List<Series> allSeries = movieDAO.getAllSeries();
            Set<String> listCountry = new LinkedHashSet<>();
            for (Series s : allSeries) {
                if (s.getCountry() != null && !s.getCountry().isEmpty()) {
                    listCountry.add(s.getCountry());
                }
            }
            request.setAttribute("listSeries", listSeries);
            request.setAttribute("listCategory", listCategory);
            request.setAttribute("selectedCategory", categoryId);
            request.setAttribute("listCountry", listCountry);

            request.getRequestDispatcher("movie.jsp").forward(request, response);
            return;
        }
        if (action.equals("filterByCountry")) {
            String country = request.getParameter("country");

            if (country == null || country.isEmpty()) {
                response.sendRedirect("series?action=allOfSeries");
                return;
            }

            // ✅ Danh sách phim theo quốc gia được chọn
            List<Series> listSeries = movieDAO.getSeriesByCountry(country);

            // ✅ Luôn lấy danh mục và danh sách quốc gia từ toàn bộ Series
            List<Category> listCategory = categoryDAO.getAllCategories();

            // ✅ Quan trọng: KHÔNG tạo listCountry từ listSeries hiện tại
            List<Series> allSeries = movieDAO.getAllSeries();
            Set<String> listCountry = new LinkedHashSet<>();
            for (Series s : allSeries) {
                if (s.getCountry() != null && !s.getCountry().isEmpty()) {
                    listCountry.add(s.getCountry());
                }
            }

            // Gửi dữ liệu cho JSP
            request.setAttribute("listSeries", listSeries);
            request.setAttribute("listCategory", listCategory);
            request.setAttribute("listCountry", listCountry);
            request.setAttribute("selectedCountry", country);

            request.getRequestDispatcher("movie.jsp").forward(request, response);
            return;
        }
        if (action.equals("filterByType")) {
            String typeIdRaw = request.getParameter("typeId");
            if (typeIdRaw == null || typeIdRaw.isEmpty()) {
                response.sendRedirect("series?action=allOfSeries");
                return;
            }

            int typeId = Integer.parseInt(typeIdRaw);
            List<Series> listSeries = movieDAO.getSeriesByTypeId(typeId);
            List<Category> listCategory = categoryDAO.getAllCategories();

            List<Series> allSeries = movieDAO.getAllSeries();
            Set<String> listCountry = new LinkedHashSet<>();
            for (Series s : allSeries) {
                if (s.getCountry() != null && !s.getCountry().isEmpty()) {
                    listCountry.add(s.getCountry());
                }
            }

            request.setAttribute("listSeries", listSeries);
            request.setAttribute("listCategory", listCategory);
            request.setAttribute("listCountry", listCountry);
            request.setAttribute("selectedType", typeId);

            request.getRequestDispatcher("movie.jsp").forward(request, response);
            return;
        }
        if (action.equals("searchFilm")) {
            String query = request.getParameter("query");

            if (query != null) {
                query = query.trim(); // ✅ Cắt bỏ khoảng trắng đầu & cuối
            }

            if (query == null || query.isEmpty()) {
                response.sendRedirect("series?action=allOfSeries");
                return;
            }
            List<Series> listSeries = movieDAO.searchSeries(query);
            List<Category> listCategory = categoryDAO.getAllCategories();

            Set<String> listCountry = new LinkedHashSet<>();

            for (Series s : movieDAO.getAllSeries()) {
                if (s.getCountry() != null && !s.getCountry().isEmpty()) {
                    listCountry.add(s.getCountry());
                }
            }

            request.setAttribute("listSeries", listSeries);
            request.setAttribute("listCategory", listCategory);
            request.setAttribute("listCountry", listCountry);
            request.setAttribute("searchQuery", query);

            request.getRequestDispatcher("movie.jsp").forward(request, response);
        }


    }


    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
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
