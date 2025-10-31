/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/updateUserServlet")
public class UpdateUserServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String email = request.getParameter("email");
        String currentPassword = request.getParameter("current-password");
        String newPassword = request.getParameter("new-password");

        if (!user.getPasswordHash().equals(currentPassword)) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
            request.getRequestDispatcher("update.jsp").forward(request, response);
            return;
        }

        user.setEmail(email);
        user.setPasswordHash(newPassword);
        boolean updated = userDAO.updateUser(user);

        if (updated) {
            session.setAttribute("currentUser", user);
            response.sendRedirect("account.jsp");
        } else {
            request.setAttribute("error", "Cập nhật thất bại, thử lại!");
            request.getRequestDispatcher("update.jsp").forward(request, response);
        }
    }
}
