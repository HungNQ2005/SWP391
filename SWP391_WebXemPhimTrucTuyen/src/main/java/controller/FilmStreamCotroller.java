// java
package controller;

import dao.MovieDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.nio.file.Files;

@WebServlet("/film")
public class FilmStreamCotroller extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

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

        String filmUrl = new MovieDAO().getFilmUrlById(id);
        if (filmUrl == null || filmUrl.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Film not found");
            return;
        }

        // Nếu là link YouTube hoặc link ngoài
        if (filmUrl.startsWith("http://") || filmUrl.startsWith("https://")) {
            resp.sendRedirect(filmUrl);
            return;
        }

        // ✅ Tự động tìm đường dẫn thực trong thư mục webapp
        String realPath = getServletContext().getRealPath("/" + filmUrl);
        File filmFile = new File(realPath);

        if (!filmFile.exists() || !filmFile.isFile()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Film file missing: " + realPath);
            return;
        }

        // Gửi file video
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
