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
import dao.EmailUtil;
import dao.HashUtil;
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
        String action = request.getParameter("action");
        
        if(action.equals("sendLogin")){
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
        if(action.equals("sendSignUp")){
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
        }
        if("sendFogortPassword".equals(action)){
            request.getRequestDispatcher("/forgotpassword.jsp").forward(request, response);
        }
        if("sendResetPassword".equals(action)){
            request.getRequestDispatcher("/resetpassword.jsp").forward(request, response);
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
                url = "/signup.jsp";
            } else {
                UserDAO userDAO = new UserDAO();
                userDAO.signUp(username, email, password, "", "Guest", "default");
                url += "index.jsp";
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
                    url = "index.jsp";
                } else {
                    error = "Ten dang nhap hoac mat khau bi sai";
                    request.setAttribute("error", error);
                    url = "login.jsp";
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
                String resetLink = request.getContextPath() +"/user?action=sendResetPassword";
                request.setAttribute("token", token);
                request.getRequestDispatcher("/resetpassword.jsp").forward(request, response);
                
            } else {
                request.setAttribute("error", "Email không tồn tại!");
                request.getRequestDispatcher("/forgotpassword.jsp").forward(request, response);
            }
            
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
                request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
            }
        }
        if ("activate".equals(action)) {
            String token = request.getParameter("token");
            UserDAO dao = new UserDAO();
            boolean success = dao.activateUser(token);
            if (success) {
                request.setAttribute("message", "Kích hoạt thành công, mời đăng nhập!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Token không hợp lệ hoặc đã được dùng!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
        }

        if ("emailSignUp".equals(action)) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String passwordConfirm = request.getParameter("passwordConfirm");

            if (!password.equals(passwordConfirm)) {
                request.setAttribute("error", "Mật khẩu không khớp!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }

            // Hash password
            

            // Tạo token
            String token = java.util.UUID.randomUUID().toString();

            // Lưu vào DB (DAO cần có method signUpWithEmail)
            UserDAO userDAO = new UserDAO();
            userDAO.signUpWithEmail(username, email, password, token);

            // Gửi mail xác thực
            String activationLink = "http://localhost:8080/YourApp/user?action=active&token=" + token;
            EmailUtil.sendEmail(email, "Xác thực tài khoản",
                    "Chào " + username + ",\n\nVui lòng nhấp vào link để kích hoạt tài khoản: " + activationLink);

            // Thông báo cho user kiểm tra email
            request.setAttribute("message", "Vui lòng kiểm tra email để kích hoạt tài khoản!");
            request.getRequestDispatcher("checkEmail.jsp").forward(request, response);
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
