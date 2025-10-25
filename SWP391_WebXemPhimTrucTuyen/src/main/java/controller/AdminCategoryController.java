/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import dao.AdminDAO;
import entity.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Chau Tan Cuong - CE190026
 */
@WebServlet(name="AdminCategoryController", urlPatterns={"/adminCategory"})
public class AdminCategoryController extends HttpServlet {
   AdminDAO adminDAO = new AdminDAO();


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            List<Category> list = adminDAO.getAllCategories();
            request.setAttribute("listCategory", list);
            request.getRequestDispatcher("/Admin/CategoryDashboard.jsp").forward(request, response);
            return;
        }

        if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            adminDAO.deleteCategory(id);
            response.sendRedirect("adminCategory?action=list");
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("insert")) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            adminDAO.insertCategory(name, description);
            response.sendRedirect("adminCategory?action=list");
        }

        if (action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("category_id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            adminDAO.updateCategory(id, name, description);
            response.sendRedirect("adminCategory?action=list");
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "CRUD Category Controller";
    }
}
