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
import java.util.List;
import model.Performers;

/**
 *
 * @author Vo Thi Phi Yen - CE190428
 */
@WebServlet("/performers")
public class PerformerListServlet extends HttpServlet {
  PerformersDAO performerDAO = new PerformersDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Performers> list = performerDAO.getAllPerformers();
        request.setAttribute("performers", list);
        request.getRequestDispatcher("/UI/PerformerList.jsp").forward(request, response);
    }
}
