/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AdminDAO;
import entity.Category;

import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import entity.Series;
import java.util.Arrays;
import java.util.stream.Collectors;
import dao.MovieDAO;
import entity.Country;
import java.util.Set;
import java.util.LinkedHashSet;
import jakarta.servlet.annotation.MultipartConfig;

/**
 *
 * @author Chau Tan Cuong - CE190026
 */
@WebServlet(name = "AdminMovieController", urlPatterns = {"/admin/movie"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AdminMovieController extends HttpServlet {

    AdminDAO adminDAO = new AdminDAO();
    AdminDAO seriesCategoryDAO = new AdminDAO();
    // Thêm MovieDAO để lấy country (movieDao trả country_name trong Series.country)
    private final MovieDAO movieDao = new MovieDAO();

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

        if (action == null || "sendSeriesDashboard".equals(action)) {
            int page = 1;
            int limit = 10; // bạn đổi số item mỗi trang tùy ý

            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            int offset = (page - 1) * limit;

            List<Series> list = adminDAO.getSeriesByPage(offset, limit);
            int totalSeries = adminDAO.getTotalSeriesCount();
            int totalPages = (int) Math.ceil((double) totalSeries / limit);

            List<Category> listCategory = adminDAO.getAllCategories();

            // Lấy danh sách country từ adminDAO (dùng getAllSeriesForAdmin để có trường country)
            List<Series> allSeries = adminDAO.getAllSeriesForAdmin();

            List<Country> listCountry = adminDAO.getAllCountries();

            request.setAttribute("listCategory", listCategory);
            request.setAttribute("listSeries", list);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("listCountry", listCountry);

            request.getRequestDispatcher("/Admin/MovieDashBoard.jsp").forward(request, response);
            return;
        }

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            adminDAO.deleteSeriesForAdmin(id);
            response.sendRedirect("movie?action=sendSeriesDashboard");
            return;
        }

        if ("searchFilmAdmin".equals(action)) {
            String query = request.getParameter("query");
            if (query != null) {
                query = query.trim();
            }

            if (query == null || query.isEmpty()) {
                response.sendRedirect("movie?action=sendSeriesDashboard");
                return;
            }

            List<Series> listSeries = adminDAO.searchSeries(query);
            List<Category> listCategory = adminDAO.getAllCategories();
            List<Series> allSeries = adminDAO.getAllSeriesForAdmin();
            Set<String> listCountry = buildCountrySet(allSeries);

            int currentPage = 1;
            int totalPages = 1;

            request.setAttribute("listSeries", listSeries);
            request.setAttribute("listCategory", listCategory);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("searchQuery", query);
            request.setAttribute("listCountry", listCountry);

            request.getRequestDispatcher("/Admin/MovieDashBoard.jsp").forward(request, response);
            return;
        }
        if ("viewDetails".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));

                Series movie = adminDAO.getSeriesById(id);

                if (movie != null) {
                    request.setAttribute("movie", movie);
                    request.getRequestDispatcher("/Admin/MovieDetail.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Movie not found");
                }

            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid movie ID");
            }
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
            String title = request.getParameter("title");
            if (title != null) {
                title = title.trim();
            }
            if (adminDAO.checkSeriesTitleExists(title)) {
                request.setAttribute("error", "Thêm thất bại: Tên phim '" + title + "' đã tồn tại trong hệ thống!");

                // B. Giữ lại các giá trị người dùng đã nhập (để họ không phải gõ lại)
                request.setAttribute("enteredTitle", title);
                request.setAttribute("enteredDesc", request.getParameter("description"));
                request.setAttribute("enteredYear", request.getParameter("release_year"));
                request.setAttribute("enteredTrailer", request.getParameter("trailer_url"));
                // (Lưu ý: File upload không thể giữ lại giá trị qua request được vì bảo mật trình duyệt)

                // C. LOAD LẠI DỮ LIỆU CHO DASHBOARD (Bắt buộc để không bị lỗi trang trắng hoặc thiếu bảng)
                // (Copy logic từ sendSeriesDashboard để trang JSP có dữ liệu hiển thị)
                int page = 1;
                int limit = 10;
                List<Series> list = adminDAO.getSeriesByPage(0, limit);
                int totalSeries = adminDAO.getTotalSeriesCount();
                int totalPages = (int) Math.ceil((double) totalSeries / limit);
                List<Category> listCategory = adminDAO.getAllCategories();
                List<Country> listCountry = adminDAO.getAllCountries();

                request.setAttribute("listCategory", listCategory);
                request.setAttribute("listSeries", list);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("listCountry", listCountry);

                // D. Quay về trang Dashboard kèm thông báo lỗi
                request.getRequestDispatcher("/Admin/MovieDashBoard.jsp").forward(request, response);
                return; // Dừng code tại đây, KHÔNG upload file, KHÔNG insert DB
            }

            Series s = new Series();
            s.setTitle(request.getParameter("title"));
            s.setDescription(request.getParameter("description"));
            s.setReleaseYear(Integer.parseInt(request.getParameter("release_year")));
            // xử lý countries multi-select (trước khi submit JS đã gán chuỗi vào hidden "country")
            String[] selectedCountries = request.getParameterValues("countries");
            // Nếu JS không gửi selectedCountries, fallback vào single hidden param
            String countryJoined = null;
            if (selectedCountries != null && selectedCountries.length > 0) {
                countryJoined = Arrays.stream(selectedCountries).map(String::trim)
                        .filter(x -> !x.isEmpty())
                        .collect(Collectors.joining(", "));
            } else {
                countryJoined = request.getParameter("country"); // fallback
            }
            s.setCountry(countryJoined);
            // Xử lý file upload
            jakarta.servlet.http.Part filePart = request.getPart("poster_file");
            String fileName = new java.io.File(filePart.getSubmittedFileName()).getName();

            // Đường dẫn lưu thật
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "movies";
            java.io.File uploadDir = new java.io.File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Ghi file vào thư mục
            filePart.write(uploadPath + File.separator + fileName);

            // Đường dẫn tương đối lưu vào DB
            String posterRelativePath = "uploads/movies/" + fileName;
            s.setPosteUrl(posterRelativePath);

            // === UPLOAD VIDEO ===
            jakarta.servlet.http.Part videoPart = request.getPart("video_file");
            if (videoPart != null && videoPart.getSize() > 0) {
                String videoName = new File(videoPart.getSubmittedFileName()).getName();
                String videoUploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "filmStream";
                File videoDir = new File(videoUploadPath);
                if (!videoDir.exists()) {
                    videoDir.mkdirs();
                }
                videoPart.write(videoUploadPath + File.separator + videoName);

                // Đường dẫn lưu DB
                String videoRelativePath = "uploads/filmStream/" + videoName;
                s.setFilmUrl(videoRelativePath); // nhớ thêm trường video_url trong class Series + DB
            }

            s.setTrailerUrl(request.getParameter("trailer_url"));
            s.setTypeId(Integer.parseInt(request.getParameter("type_id")));

            int newSeriesId = adminDAO.insertSeriesForAdmin(s);

            // Thêm thể loại
            String[] categoryIds = request.getParameterValues("category_ids");
            if (categoryIds != null) {
                List<Integer> catList = Arrays.stream(categoryIds)
                        .map(Integer::parseInt)
                        .collect(Collectors.toList());
                seriesCategoryDAO.insertSeriesCategories(newSeriesId, catList);
            }

            response.sendRedirect("movie?action=sendSeriesDashboard");
            return;
        }

        if ("update".equals(action)) {
            Series s = new Series();
            s.setSeriesID(Integer.parseInt(request.getParameter("series_id")));
            s.setTitle(request.getParameter("title"));
            s.setDescription(request.getParameter("description"));
            s.setReleaseYear(Integer.parseInt(request.getParameter("release_year")));

            String[] selectedCountries = request.getParameterValues("countries");
            String countryJoined = null;
            if (selectedCountries != null && selectedCountries.length > 0) {
                countryJoined = Arrays.stream(selectedCountries).map(String::trim)
                        .filter(x -> !x.isEmpty())
                        .collect(Collectors.joining(", "));
            } else {
                countryJoined = request.getParameter("country"); // fallback
            }
            s.setCountry(countryJoined);

            // Xử lý file upload
            jakarta.servlet.http.Part filePart = request.getPart("poster_file");
            String fileName = new java.io.File(filePart.getSubmittedFileName()).getName();

            // Đường dẫn lưu thật
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "movies";
            java.io.File uploadDir = new java.io.File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Ghi file vào thư mục
            filePart.write(uploadPath + File.separator + fileName);

            // Đường dẫn tương đối lưu vào DB
            String posterRelativePath = "uploads/movies/" + fileName;
            s.setPosteUrl(posterRelativePath);

            // === UPLOAD VIDEO (optional) ===
            jakarta.servlet.http.Part videoPart = request.getPart("video_file");
            if (videoPart != null && videoPart.getSize() > 0) {
                String videoName = new File(videoPart.getSubmittedFileName()).getName();
                String videoUploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "filmStream";
                File videoDir = new File(videoUploadPath);
                if (!videoDir.exists()) {
                    videoDir.mkdirs();
                }
                videoPart.write(videoUploadPath + File.separator + videoName);

                String videoRelativePath = "uploads/filmStream/" + videoName;
                s.setFilmUrl(videoRelativePath);
            } else {
                // Nếu không chọn video mới, giữ nguyên video cũ
                s.setFilmUrl(request.getParameter("oldVideo"));
            }

            s.setTrailerUrl(request.getParameter("trailer_url"));
            s.setTypeId(Integer.parseInt(request.getParameter("type_id")));

            adminDAO.updateSeriesForAdmin(s);

            seriesCategoryDAO.deleteSeriesCategories(s.getSeriesID());
            String[] categoryIds = request.getParameterValues("category_ids");
            if (categoryIds != null) {
                List<Integer> catList = Arrays.stream(categoryIds)
                        .map(Integer::parseInt)
                        .collect(Collectors.toList());
                seriesCategoryDAO.insertSeriesCategories(s.getSeriesID(), catList);
            }

            response.sendRedirect("movie?action=sendSeriesDashboard");
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
        return "AdminMovieController";
    }// </editor-fold>

    // Helper: build set countries từ list Series (Series.country là country_name)
    private Set<String> buildCountrySet(List<Series> allSeries) {
        Set<String> set = new LinkedHashSet<>();
        if (allSeries == null) {
            return set;
        }
        for (Series s : allSeries) {
            if (s.getCountry() != null && !s.getCountry().isEmpty()) {
                // nếu có nhiều country trong 1 series, thêm từng phần
                String[] parts = s.getCountry().split(",\\s*");
                for (String p : parts) {
                    if (!p.trim().isEmpty()) {
                        set.add(p.trim());
                    }
                }
            }
        }
        return set;
    }

}
