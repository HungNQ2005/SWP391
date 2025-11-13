/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AdminDAO;
import dao.EmailUtil;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import entity.User;
import org.eclipse.tags.shaded.org.apache.bcel.generic.AALOAD;

/**
 *
 * @author Chau Tan Cuong - CE190026
 */
@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

    AdminDAO adminDAO = new AdminDAO();

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

        if (action == null || action.equals("sendAccountDashboard")) {
            int page = 1;
            int recordsPerPage = 10;

            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            int totalRecords = adminDAO.getTotalUserCount();
            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

            int offset = (page - 1) * recordsPerPage;
            List<User> users = adminDAO.getUsersByPage(offset, recordsPerPage);

            request.setAttribute("users", users);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/Admin/AccountDashboard.jsp").forward(request, response);
            return;
        }
        if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            adminDAO.deleteUser(id);
            response.sendRedirect("admin?action=sendAccountDashboard");
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
            User u = new User();
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String fullName = request.getParameter("full_name");
            String userLevel = request.getParameter("user_level");
            String rawPassword = request.getParameter("password");

            u.setUsername(username);
            u.setEmail(email);
            u.setFull_name(fullName);
            u.setUser_level(userLevel);
            u.setHash_password(rawPassword); // tạm set password mặc định
            u.setAvatar_url("default.jpg");
            adminDAO.insertUser(u);

            if (email != null && !email.trim().isEmpty()) {
                final String to = email;
                final String subject = "Thông tin tài khoản admin";
                final StringBuilder body = new StringBuilder();
                body.append("Xin chào ").append(fullName == null ? "" : fullName).append(",\n\n");
                body.append("Tài khoản admin của bạn đã được tạo. Thông tin đăng nhập:\n");
                body.append("username: ").append(username).append("\n");
                u.setHash_password(rawPassword);
                body.append("Vui lòng đổi mật khẩu sau lần đăng nhập đầu tiên.\n\n");
                body.append("Trân trọng,\nAdmin Team");

                new Thread(() -> {
                    try {
                        EmailUtil.sendEmail(to, subject, body.toString());
                    } catch (Exception ex) {
                        // Log lỗi (hiện tại in stacktrace)
                        ex.printStackTrace();
                    }
                }).start();
            }
            response.sendRedirect("admin?action=sendAccountDashboard");
        } else if ("update".equals(action)) {
            User u = new User();
            int userId = Integer.parseInt(request.getParameter("user_id"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String fullName = request.getParameter("full_name");
            String userLevel = request.getParameter("user_level");
            String rawPassword = request.getParameter("password");

            // từ edit form (có thể rỗng)
            u.setUser_id(userId);
            u.setUsername(username);
            u.setEmail(email);
            u.setFull_name(fullName);
            u.setUser_level(userLevel);

            // Nếu có password mới (không rỗng) thì cập nhật password
            boolean passwordChanged = false;
            if (rawPassword != null && !rawPassword.trim().isEmpty()) {
                u.setHash_password(rawPassword);
                passwordChanged = true;
            }
            adminDAO.updateUser(u);

            // Gửi email thông báo cập nhật (nếu có email)
            if (email != null && !email.trim().isEmpty()) {
                final String to = email;
                final String subject = "Thông báo: Tài khoản admin đã được cập nhật";
                final StringBuilder body = new StringBuilder();
                body.append("Xin chào ").append(fullName == null ? "" : fullName).append(",\n\n");
                body.append("Tài khoản admin của bạn đã được cập nhật. Thông tin hiện tại:\n");
                body.append("username: ").append(username).append("\n");
                body.append("role: ").append(userLevel == null ? "" : userLevel).append("\n");
                if (passwordChanged) {
                    body.append("password (mới): ").append(rawPassword).append("\n\n");
                    body.append("Vui lòng đổi mật khẩu nếu đây không phải bạn.\n\n");
                } else {
                    body.append("\n");
                }
                body.append("Trân trọng,\nAdmin Team");

                new Thread(() -> {
                    try {
                        EmailUtil.sendEmail(to, subject, body.toString());
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                }).start();
            }
            response.sendRedirect("admin?action=sendAccountDashboard");
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
