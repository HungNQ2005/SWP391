package controller;

import dao.MovieDAO;
import dao.EpisodeDAO;
import entity.Episode;
import entity.Series;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.nio.file.Files;
import java.util.List;

@WebServlet(urlPatterns = {"/film", "/playFilm"})
public class FilmStreamCotroller extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        // Nếu người dùng truy cập /playFilm → hiển thị trang playFilm.jsp
        if ("/playFilm".equals(path)) {
            handlePlayPage(req, resp);
            return;
        }

        // Còn lại là /film → stream video
        handleStreamVideo(req, resp);
    }

    // ✅ 1️⃣ Hiển thị giao diện xem phim
    private void handlePlayPage(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String seriesIdParam = req.getParameter("id");
        if (seriesIdParam == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing seriesId");
            return;
        }

        int seriesId = Integer.parseInt(seriesIdParam);
        String epIdParam = req.getParameter("epId");

        MovieDAO movieDAO = new MovieDAO();
        EpisodeDAO episodeDAO = new EpisodeDAO();

        Series movie = movieDAO.getMovieById(seriesId);
        if (movie == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Movie not found");
            return;
        }

        if (movie.getTypeId() == 1) {
            // 🔹 Phim lẻ
            req.setAttribute("movie", movie);
            req.getRequestDispatcher("playFilm.jsp").forward(req, resp);
        } else {
            // 🔹 Phim bộ
            List<Episode> episodes = episodeDAO.getEpisodesBySeriesId(seriesId);
            Episode currentEp = null;

            if (epIdParam != null) {
                try {
                    currentEp = episodeDAO.getEpisodeById(Integer.parseInt(epIdParam));
                } catch (NumberFormatException ignored) {}
            }

            if (currentEp == null && !episodes.isEmpty()) {
                currentEp = episodes.get(0); // lấy tập đầu tiên nếu chưa chọn
            }

            req.setAttribute("movie", movie);
            req.setAttribute("episodes", episodes);
            req.setAttribute("currentEpisode", currentEp);
            req.getRequestDispatcher("playFilm.jsp").forward(req, resp);
        }
    }

    // ✅ 2️⃣ Stream video (giữ nguyên code cũ của bạn)
    private void handleStreamVideo(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String idParam = req.getParameter("id");
        if (idParam == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing id");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid id");
            return;
        }

        MovieDAO movieDAO = new MovieDAO();
        EpisodeDAO episodeDAO = new EpisodeDAO();

        String filmUrl = null;

        // Kiểm tra xem id thuộc series (phim lẻ) hay episode (phim bộ)
        Series movie = movieDAO.getMovieById(id);
        Episode episode = null;

        if (movie != null) {
            if (movie.getTypeId() == 1) {
                // Phim lẻ
                filmUrl = movie.getFilmUrl();
            } else {
                // Phim bộ
                String epIdParam = req.getParameter("epId");
                if (epIdParam != null) {
                    try {
                        int epId = Integer.parseInt(epIdParam);
                        episode = episodeDAO.getEpisodeById(epId);
                        if (episode != null) {
                            filmUrl = episode.getEpisodeUrl();
                        }
                    } catch (NumberFormatException ignored) {}
                }
                if (filmUrl == null) {
                    Episode firstEp = episodeDAO.getFirstEpisodeBySeriesId(movie.getSeriesID());
                    if (firstEp != null) {
                        filmUrl = firstEp.getEpisodeUrl();
                    }
                }
            }
        } else {
            episode = episodeDAO.getEpisodeById(id);
            if (episode != null) {
                filmUrl = episode.getEpisodeUrl();
            }
        }

        if (filmUrl == null || filmUrl.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Film not found");
            return;
        }

        // Nếu là link ngoài (YouTube, CDN,...)
        if (filmUrl.startsWith("http://") || filmUrl.startsWith("https://")) {
            resp.sendRedirect(filmUrl);
            return;
        }

        // ✅ Lấy đường dẫn thật trong project
        String realPath = getServletContext().getRealPath("/" + filmUrl);
        File filmFile = new File(realPath);

        if (!filmFile.exists() || !filmFile.isFile()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Film file missing: " + realPath);
            return;
        }

        // Truyền video
        String contentType = Files.probeContentType(filmFile.toPath());
        if (contentType == null) contentType = "video/mp4";
        resp.setHeader("Accept-Ranges", "bytes");
        resp.setContentType(contentType);

        long fileLength = filmFile.length();
        String range = req.getHeader("Range");
        long start = 0, end = fileLength - 1;

        if (range != null && range.startsWith("bytes=")) {
            String[] parts = range.substring(6).split("-", 2);
            try {
                start = Long.parseLong(parts[0]);
                if (parts.length > 1 && parts[1].length() > 0) {
                    end = Long.parseLong(parts[1]);
                }
            } catch (NumberFormatException ignored) {}

            if (end > fileLength - 1) end = fileLength - 1;
            if (start > end) {
                resp.sendError(HttpServletResponse.SC_REQUESTED_RANGE_NOT_SATISFIABLE);
                return;
            }

            long contentLength = end - start + 1;
            resp.setStatus(HttpServletResponse.SC_PARTIAL_CONTENT);
            resp.setHeader("Content-Range", "bytes " + start + "-" + end + "/" + fileLength);
            resp.setContentLengthLong(contentLength);
        } else {
            resp.setContentLengthLong(fileLength);
        }

        try (RandomAccessFile raf = new RandomAccessFile(filmFile, "r");
             OutputStream out = resp.getOutputStream()) {

            raf.seek(start);
            byte[] buffer = new byte[8192];
            long toWrite = end - start + 1;
            int len;
            while (toWrite > 0 && (len = raf.read(buffer, 0, (int) Math.min(buffer.length, toWrite))) != -1) {
                out.write(buffer, 0, len);
                toWrite -= len;
            }
        }
    }
}
