/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;

import entity.Country;
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

    private final MovieDAO dao = new MovieDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        // fix: default action should be the action name, not a URL
        if (action == null) {
            action = "allOfSeries";
        }

        if (action.equals("allOfSeries")) {
            int page = 1;
            int limit = 8; // number of items per page
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            int offset = (page - 1) * limit;

            List<Series> listSeries = dao.getSeriesByPage(offset, limit);
            int totalSeries = dao.getTotalSeriesCount();
            int totalPages = (int) Math.ceil((double) totalSeries / limit);

            List<Category> listCategory = dao.getAllCategories();
          List<Country> listCountry = dao.getAllCountry();

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
            Series movie = dao.getSeriesById(id);
            List<Category> listCategory = dao.getAllCategories();

            List<Country> listCountry = dao.getAllCountry();
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
            List<Series> listSeries = dao.getSeriesByCategoryId(categoryId);

            List<Category> listCategory = dao.getAllCategories();
            List<Country> listCountry = dao.getAllCountry();
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

            List<Series> listSeries = dao.getSeriesByCountry(country);
            List<Category> listCategory = dao.getAllCategories();
            List<Country> listCountry = dao.getAllCountry();
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
            List<Series> listSeries = dao.getSeriesByTypeId(typeId);
            List<Category> listCategory = dao.getAllCategories();
            List<Country> listCountry = dao.getAllCountry();
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
                query = query.trim();
            }

            if (query == null || query.isEmpty()) {
                response.sendRedirect("series?action=allOfSeries");
                return;
            }
            List<Series> listSeries = dao.searchSeries(query);
            List<Category> listCategory = dao.getAllCategories();

            List<Country> listCountry = dao.getAllCountry();
            request.setAttribute("listSeries", listSeries);
            request.setAttribute("listCategory", listCategory);
            request.setAttribute("listCountry", listCountry);
            request.setAttribute("searchQuery", query);

            request.getRequestDispatcher("movie.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // no POST actions currently
    }

    @Override
    public String getServletInfo() {
        return "Series controller";
    }



}
