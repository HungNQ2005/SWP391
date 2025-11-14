package controller;

import dao.AdsDAO;
import entity.Ads;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.nio.file.Path;
import java.io.File;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)
@WebServlet(name = "AdsController", urlPatterns = {"/admin/ads"})
public class AdsController extends HttpServlet {

    private boolean isValidURL(String url) {
        try {
            HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
            connection.setRequestMethod("HEAD");
            connection.setConnectTimeout(3000);
            connection.setReadTimeout(3000);

            int code = connection.getResponseCode();
            return code >= 200 && code < 400;
        } catch (Exception e) {
            return false;
        }
    }
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

            String name = request.getParameter("ads_name");
            String link = request.getParameter("ads_link");
            String status = request.getParameter("status");

            Part filePart = request.getPart("ads_image");
            String fileName = (filePart != null) ? Path.of(filePart.getSubmittedFileName()).getFileName().toString() : "";

            String imagePath;
            if (fileName != null && !fileName.isBlank()) {
                // Upload ảnh mới
                String uploadPath = request.getServletContext().getRealPath("") + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);

                imagePath = "/uploads/" + fileName;
            } else {
                // giữ ảnh cũ
                imagePath = request.getParameter("old_image");
            }

            Ads ads = new Ads();
            ads.setAds_name(name);
            ads.setAds_link(link);
            ads.setStatus(status);
            ads.setAds_image(imagePath);

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

        response.sendRedirect("ads");
    }
}
