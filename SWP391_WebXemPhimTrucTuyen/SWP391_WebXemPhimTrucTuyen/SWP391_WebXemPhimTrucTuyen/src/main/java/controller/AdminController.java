/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AdminDAO;
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
import util.EmailUtil;

/**
 *
 * @author Chau Tan Cuong - CE190026
 */
@WebServlet(name = "AdminController", urlPatterns = {"/admin/account"})
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
            response.sendRedirect("account?action=sendAccountDashboard");
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
            u.setUser_level(userLevel); // tạm set password mặc định

            u.setHash_password(rawPassword); // tạm set password mặc định
            u.setAvatar_url("default.jpg");
            adminDAO.insertUser(u);

            if (email != null && !email.trim().isEmpty()) {
                final String to = email;
                final String subject = "Admin account information";
                final StringBuilder body = new StringBuilder();
                body.append("Hello ").append(fullName == null ? "" : fullName).append(",\n\n");
                body.append("Your admin account has been created. Login information:\n");
                body.append("username: ").append(username).append("\n");
                body.append("password: ").append(rawPassword).append("\n");
                u.setHash_password(rawPassword);
                body.append("Please change your password after first login.\n\n");
                body.append("Dear,\nAdmin Team");

                new Thread(() -> {
                    try {
                        EmailUtil.sendEmail(to, subject, body.toString());
                    } catch (Exception ex) {
                        // Log lỗi (hiện tại in stacktrace)
                        ex.printStackTrace();
                    }
                }).start();
            }
            response.sendRedirect("account?action=sendAccountDashboard");
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
                final String subject = "Notice: Admin account has been updated";
                final StringBuilder body = new StringBuilder();
                body.append("Hello ").append(fullName == null ? "" : fullName).append(",\n\n");
                body.append("Your admin account has been updated. Current information:\n");
                body.append("username: ").append(username).append("\n");
                body.append("role: ").append(userLevel == null ? "" : userLevel).append("\n");
                if (passwordChanged) {
                    body.append("password (new): ").append(rawPassword).append("\n\n");
                    body.append("Please change your password if this is not you.\n\n");
                } else {
                    body.append("\n");
                }
                body.append("Dear,\nAdmin Team");

                new Thread(() -> {
                    try {
                        EmailUtil.sendEmail(to, subject, body.toString());
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                }).start();
            }
            response.sendRedirect("account?action=sendAccountDashboard");
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
