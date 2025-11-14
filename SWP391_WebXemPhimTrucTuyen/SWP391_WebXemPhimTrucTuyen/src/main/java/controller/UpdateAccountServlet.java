package controller;

import entity.User;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "UpdateAccountServlet", urlPatterns = {"/UpdateAccountServlet"})
public class UpdateAccountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("guest");

        // ✅ Nếu chưa đăng nhập → quay lại trang login
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ✅ Lấy dữ liệu từ form
        String email = request.getParameter("email");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        String error = null;
        String success = null;

        UserDAO dao = new UserDAO();

        try {
            // ✅ Kiểm tra mật khẩu hiện tại (hash check)
            boolean isValidPassword = user.getHash_password().equals(currentPassword)
                    || dao.login(user.getUsername(), currentPassword) != null;

            if (!isValidPassword) {
                error = "Mật khẩu hiện tại không chính xác!";
            } else if (newPassword != null && !newPassword.trim().isEmpty() && !newPassword.equals(confirmPassword)) {
                error = "Mật khẩu xác nhận không khớp!";
            } else {
                // ✅ Nếu đổi email
                if (email != null && !email.equals(user.getEmail())) {
                    user.setEmail(email);
                }

                // ✅ Nếu đổi mật khẩu
                if (newPassword != null && !newPassword.trim().isEmpty()) {
                    dao.updatePassword(user.getEmail(), newPassword);
                    user.setHash_password(newPassword);
                }

                // ✅ Lưu lại user vào session
                session.setAttribute("guest", user);
                success = "Cập nhật tài khoản thành công!";
            }

        } catch (Exception e) {
            e.printStackTrace();
            error = "Đã xảy ra lỗi hệ thống!";
        }

        // ✅ Gửi thông báo về trang update.jsp (nơi hiển thị form)
        if (error != null) {
            request.setAttribute("error", error);
        } else {
            request.setAttribute("success", success);
        }

        request.getRequestDispatcher("update.jsp").forward(request, response);
    }
}
