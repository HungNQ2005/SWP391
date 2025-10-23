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

        if (action == null ||action.equals("sendAccountDashboard")) {
            int page = 1;
            int recordsPerPage = 1;

            if(request.getParameter("page") != null) {
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
            u.setUsername(request.getParameter("username"));
            u.setEmail(request.getParameter("email"));
            u.setFull_name(request.getParameter("full_name"));
            u.setUser_level(request.getParameter("user_level"));
            u.setHash_password(request.getParameter("password")); // tạm set password mặc định
            u.setAvatar_url("default.jpg");
            adminDAO.insertUser(u);
            response.sendRedirect("admin?action=sendAccountDashboard");
        } 
        
        
        else if ("update".equals(action)) {
            User u = new User();
            u.setUser_id(Integer.parseInt(request.getParameter("user_id")));
            u.setUsername(request.getParameter("username"));
            u.setEmail(request.getParameter("email"));
            u.setFull_name(request.getParameter("full_name"));
            u.setUser_level(request.getParameter("user_level"));
            adminDAO.updateUser(u);
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
