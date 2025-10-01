/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.CDKeyDAO;
import static jakarta.persistence.GenerationType.UUID;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.List;
import model.CDKey;
import util.CDKeyGenerator;

/**
 *
 * @author Nguyen Quoc Hung - CE190870
 */

@WebServlet("/admin/cdkey")
public class CDKeyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int pageSize = 10;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        CDKeyDAO dao = new CDKeyDAO();
        List<CDKey> list = dao.getCDKeys(page, pageSize);
        int total = dao.countCDKeys();
        int totalPages = (int) Math.ceil((double) total / pageSize);

        request.setAttribute("cdKeyList", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/admin/cdkey.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int count = Integer.parseInt(request.getParameter("count"));
        String user = "admin"; // Có thể lấy từ session sau này
        CDKeyDAO dao = new CDKeyDAO();

        for (int i = 0; i < count; i++) {
            String code = CDKeyGenerator.generateKey();
            dao.insertCDKey(code, "unused", user);
        }

        response.sendRedirect(request.getContextPath() + "/admin/cdkey");
        //note code done patch 1
    }
}