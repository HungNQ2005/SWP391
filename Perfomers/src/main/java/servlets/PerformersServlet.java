/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlets;

import dao.PerformersDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Performers;

/**
 *
 * @author Vo Thi Phi Yen - CE190428
 */
@WebServlet( "/performerInformation")
public class PerformersServlet extends HttpServlet {

    PerformersDAO dao = new PerformersDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idRaw = request.getParameter("id");
        int id = 1; 
        try {
            if (idRaw != null) {
                id = Integer.parseInt(idRaw);
            }
        } catch (NumberFormatException e) {
            id = 1;
        }

        Performers performer = dao.getPerformerById(id);
        if (performer == null) {
            request.setAttribute("error", "Không tìm thấy diễn viên");
        }

        request.setAttribute("performer", performer);
        request.getRequestDispatcher("/UI/PerformersInfomation.jsp").forward(request, response);
    }
}