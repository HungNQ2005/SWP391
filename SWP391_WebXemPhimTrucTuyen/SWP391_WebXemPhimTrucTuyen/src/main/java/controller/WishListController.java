package controller;

import dao.FavoriteDAO;
import entity.Series;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * @author Chau Tan Cuong - CE190026
 */
@WebServlet(name = "WishListController", urlPatterns = {"/wishlist"})
public class WishListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (action == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        switch (action) {
            // 🟩 Thêm phim vào danh sách yêu thích
            case "addFilmInFavorite": {
                if (userId == null) {
                    response.sendRedirect("user?action=sendLogin");
                    return;
                }

                String seriesIdStr = request.getParameter("seriesId");
                int seriesId = Integer.parseInt(seriesIdStr);

                FavoriteDAO favoriteDAO = new FavoriteDAO();
                boolean added = favoriteDAO.addFavorite(userId, seriesId);

                response.setContentType("text/html;charset=UTF-8");
                PrintWriter out = response.getWriter();

                if (added) {
                    // 🟢 Nếu thêm thành công
                    out.println("<script>");
                    out.println("alert('Đã thêm phim vào danh sách yêu thích!');");
                    out.println("window.location='wishlist?action=allOfFilmInFavorite';");
                    out.println("</script>");
                } else {
                    // 🔴 Nếu phim đã tồn tại
                    out.println("<script>");
                    out.println("alert('Phim này đã có trong danh sách yêu thích của bạn!');");
                    out.println("window.location='wishlist?action=allOfFilmInFavorite';");
                    out.println("</script>");
                }
                break;
            }

            // 🟩 Hiển thị tất cả phim yêu thích
            case "allOfFilmInFavorite": {
                if (userId == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }

                FavoriteDAO dao = new FavoriteDAO();
                List<Series> favorites = dao.getFavoritesByUser(userId);

                request.setAttribute("favorites", favorites);
                request.getRequestDispatcher("WishList.jsp").forward(request, response);
                break;
            }

            // 🟩 Xóa phim khỏi danh sách yêu thích
            case "removeFilmInFavorite": {
                if (userId == null) {
                    response.sendRedirect("user?action=sendLogin");
                    return;
                }

                String seriesIdStr = request.getParameter("seriesId");
                int seriesId = Integer.parseInt(seriesIdStr);

                FavoriteDAO favoriteDAO = new FavoriteDAO();
                boolean removed = favoriteDAO.removeFavorite(userId, seriesId);

                if (removed) {
                    response.sendRedirect("wishlist?action=allOfFilmInFavorite");
                } else {
                    response.getWriter().print("Lỗi khi xóa khỏi danh sách yêu thích!");
                }
                break;
            }

            // 🟩 Hành động không xác định
            default:
                response.sendRedirect("index.jsp");
                break;
        }
    }
}
