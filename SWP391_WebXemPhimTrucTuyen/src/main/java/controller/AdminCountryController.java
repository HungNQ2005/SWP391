/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import dao.AdminDAO;
import entity.Country;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Chau Tan Cuong - CE190026
 */
@WebServlet(name = "AdminCountryController", urlPatterns = {"/adminCountry"})
public class AdminCountryController extends HttpServlet {

    private AdminDAO adminDAO = new AdminDAO();

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

        if (action == null || action.equals("list")) {
            List<Country> list = adminDAO.getAllCountries();
            request.setAttribute("listCountry", list);
            request.getRequestDispatcher("/Admin/CountryDashboard.jsp").forward(request, response);
            return;
        }

        if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            adminDAO.deleteCountry(id);
            response.sendRedirect("adminCountry?action=list");
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession(); // Lấy session để gửi thông báo
        if (action.equals("insert")) {
            String name = request.getParameter("name");
            Country existingCountry = adminDAO.findCountryByName(name);

            if (existingCountry == null) {
                // Tên không bị trùng -> Cho phép insert
                adminDAO.insertCountry(name);
                session.setAttribute("successMessage", "Thêm quốc gia thành công!");
            } else {
                // Tên đã tồn tại -> Báo lỗi
                session.setAttribute("errorMessage", "Lỗi: Tên quốc gia '" + name + "' đã tồn tại.");
            }
            // -------------------------

            response.sendRedirect("adminCountry?action=list");
        }

        if (action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("country_id"));
            String name = request.getParameter("name");
            
            
            
            adminDAO.updateCountry(id, name);
            response.sendRedirect("adminCountry?action=list");
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
