/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlets;

import dao.PerformersDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Performers;

/**
 *
 * @author Vo Thi Phi Yen - CE190428
 */
@WebServlet(name="PerformerDetail", urlPatterns={"/PerformerDetail"})
public class PerformerDetail extends HttpServlet {
  PerformersDAO performerDAO = new PerformersDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int performerId = Integer.parseInt(request.getParameter("id"));
        Performers performer = performerDAO.getPerformerById(performerId);
        request.setAttribute("performer", performer);
        request.getRequestDispatcher("UI/PerformerDetail.jsp").forward(request, response);
    }
   
}
 