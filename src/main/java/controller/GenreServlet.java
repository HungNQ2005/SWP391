package controller;

import dao.GenreDAO;
import model.Genre;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/genre")
public class GenreServlet extends HttpServlet {
    private GenreDAO genreDAO;

    @Override
    public void init() {
        genreDAO = new GenreDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteGenre(request, response);
                break;
            default:
                listGenres(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            insertGenre(request, response);
        } else if ("update".equals(action)) {
            updateGenre(request, response);
        } else {
            response.sendRedirect("genre?action=list");
        }
    }

    // ========================= LIST =========================
    private void listGenres(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Genre> list = genreDAO.getAllGenres();
        request.setAttribute("listGenre", list);
        request.getRequestDispatcher("/jsp/listGenre.jsp").forward(request, response);
    }

    // ========================= NEW FORM =========================
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/addGenre.jsp").forward(request, response);
    }

    // ========================= EDIT FORM =========================
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Genre genre = genreDAO.getGenreById(id);
        request.setAttribute("genre", genre);
        request.getRequestDispatcher("/jsp/editGenre.jsp").forward(request, response);
    }

    // ========================= INSERT =========================
    private void insertGenre(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String genreName = request.getParameter("name");
        String description = request.getParameter("description");

        Genre genre = new Genre();
        genre.setGenreName(genreName);
        genre.setDescription(description);

        genreDAO.insertGenre(genre);
        response.sendRedirect(request.getContextPath() + "/genre?action=list");
    }

    // ========================= UPDATE =========================
    private void updateGenre(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String genreName = request.getParameter("name");
        String description = request.getParameter("description");

        Genre genre = new Genre();
        genre.setGenreId(id);
        genre.setGenreName(genreName);
        genre.setDescription(description);

        genreDAO.updateGenre(genre);
        response.sendRedirect(request.getContextPath() + "/genre?action=list");
    }

    // ========================= DELETE =========================
    private void deleteGenre(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        genreDAO.deleteGenre(id);
        response.sendRedirect(request.getContextPath() + "/genre?action=list");
    }
}
