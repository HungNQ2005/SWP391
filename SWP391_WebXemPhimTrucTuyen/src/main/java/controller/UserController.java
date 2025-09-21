/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.User;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Chau Tan Cuong - CE190026
 */
@WebServlet(name = "UserController", urlPatterns = {"/user"})
public class UserController extends HttpServlet {

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
        String error = "";
        String url = "";
        if (action.equals("signUp")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String passwordConfirm = request.getParameter("passwordConfirm");
            String email = request.getParameter("email");

            if (!password.equals(passwordConfirm)) {
                error += "Mẫu khẩu không khớp.<br/>";
            }
            request.setAttribute("error", error);
            if (error.length() > 0) {
                url = "/signup.html";
            } else {
                UserDAO userDAO = new UserDAO();
                userDAO.signUp(username, email, password, "", "Guest", "default");
                url += "index.html";
            }
            request.getRequestDispatcher(url).forward(request, response);
        }

        if (action.equals("login")) {
            try {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                User user = new User();
                UserDAO userDAO = new UserDAO();

                user = userDAO.login(username, password);

                if (user != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("guest", user);
                    url = "index.html";
                } else {
                    error = "Ten dang nhap hoac mat khau bi sai";
                    request.setAttribute("error", error);
                    url = "login.html";
                }
                request.getRequestDispatcher(url).forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
            }

        }

        if (action.equals("forgotPassword")) {
            String email = request.getParameter("email");
            UserDAO userDAO = new UserDAO();

            if (userDAO.findByEmail(email) != null) {
                String token = userDAO.saveResetToken(email);
                String resetLink = "http://localhost:8080/YourApp/user?action=resetPassword&token=" + token;
                request.setAttribute("message", "Link reset mật khẩu: " + resetLink);
            } else {
                request.setAttribute("error", "Email không tồn tại!");
            }
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
        }

        if ("resetPassword".equals(action)) {
            String token = request.getParameter("token");
            String newPassword = request.getParameter("password");

            UserDAO dao = new UserDAO();
            String email = dao.getEmailByToken(token);

            if (email != null) {
                dao.updatePassword(email, newPassword);
                request.setAttribute("message", "Đặt lại mật khẩu thành công, vui lòng đăng nhập lại!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Token không hợp lệ hoặc đã hết hạn!");
                request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            }
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
