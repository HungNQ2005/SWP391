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
            int page = 1;
            int limit = 1; // số phim mỗi trang, bạn có thể đổi

            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            int offset = (page - 1) * limit;

            List<Series> list = adminDAO.getSeriesByPage(offset, limit);
            int totalSeries = adminDAO.getTotalSeriesCount();
            int totalPages = (int) Math.ceil((double) totalSeries / limit);

            List<Category> listCategory = adminDAO.getAllCategories();

            request.setAttribute("listCategory", listCategory);
            request.setAttribute("listSeries", list);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/Admin/MovieDashBoard.jsp").forward(request, response);

        }
        if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            adminDAO.deleteSeriesForAdmin(id);
            response.sendRedirect("adminMovie?action=sendSeriesDashboard");
            return;
        }

        if (action.equals("searchFilmAdmin")) {
            String query = request.getParameter("query");
            if (query != null) {
                query = query.trim(); // ✅ Cắt bỏ khoảng trắng đầu & cuối
            }

            if (query == null || query.isEmpty()) {
                response.sendRedirect("adminMovie?action=sendSeriesDashboard");
                return;
            }

            List<Series> listSeries = adminDAO.searchSeries(query);
            List<Category> listCategory = adminDAO.getAllCategories(); // hoặc categoryDAO nếu bạn có

            // Đếm tổng số trang (nếu có phân trang)
            int totalSeries = listSeries.size();
            int currentPage = 1;
            int totalPages = 1;

            // Gửi dữ liệu về lại JSP
            request.setAttribute("listSeries", listSeries);
            request.setAttribute("listCategory", listCategory);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("searchQuery", query);

            request.getRequestDispatcher("/Admin/MovieDashBoard.jsp").forward(request, response);
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
