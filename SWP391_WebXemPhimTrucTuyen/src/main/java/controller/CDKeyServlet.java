/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CDKeyDAO;
import dao.RetailDAO;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
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

        int unusedPage = 1;
        int usedPage = 1;
        int pageSize = 10;

        try {
            if (request.getParameter("unusedPage") != null) {
                unusedPage = Integer.parseInt(request.getParameter("unusedPage"));
            }
            if (request.getParameter("usedPage") != null) {
                usedPage = Integer.parseInt(request.getParameter("usedPage"));
            }
        } catch (NumberFormatException e) {
            // keep defaults if invalid params
        }

        CDKeyDAO dao = new CDKeyDAO();

        // unused
        List<CDKey> unusedList = dao.getUnusedKeys(unusedPage, pageSize);
        int totalUnused = dao.countKeysByStatus("unused");
        int totalUnusedPages = (int) Math.ceil((double) totalUnused / pageSize);

        // used (with user info)
        List<Map<String, Object>> usedList = dao.getUsedKeysWithUser(usedPage, pageSize);
        int totalUsed = dao.countKeysByStatus("used");
        int totalUsedPages = (int) Math.ceil((double) totalUsed / pageSize);

        // set attributes for JSP (names match JSP below)
        request.setAttribute("unusedList", unusedList);
        request.setAttribute("usedList", usedList);
        request.setAttribute("unusedPage", unusedPage);
        request.setAttribute("usedPage", usedPage);
        request.setAttribute("totalUnusedPages", totalUnusedPages);
        request.setAttribute("totalUsedPages", totalUsedPages);
        RetailDAO retailDAO = new RetailDAO();
        request.setAttribute("retailList", retailDAO.getAllRetailForCDKey());

        request.getRequestDispatcher("/admin/cdkey.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int count = 0;
        int retailID = 0;
        try {
            count = Integer.parseInt(request.getParameter("count"));
            retailID = Integer.parseInt(request.getParameter("retail"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/cdkey");
            return;
        }

        if (count <= 0) {
            response.sendRedirect(request.getContextPath() + "/admin/cdkey");
            return;
        }

        RetailDAO retailDAO = new RetailDAO();
        CDKeyDAO dao = new CDKeyDAO();
        String retailName = retailDAO.getRetailNameById(retailID);
        String createdBy = "ADMIN for " + retailName;

        // generate keys
        List<CDKey> generatedKeys = new ArrayList<>();
        for (int i = 0; i < count; i++) {
            String code = CDKeyGenerator.generateKey();
            dao.insertCDKey(code, "unused", createdBy);
            CDKey k = new CDKey();
            k.setKeyCode(code);
            k.setKeyGeneratedBy(createdBy);
            k.setKeyGeneratedTime(java.sql.Timestamp.valueOf(java.time.LocalDateTime.now()));
            generatedKeys.add(k);
        }

        // Lưu danh sách vào session để tải
        request.getSession().setAttribute("generatedKeys", generatedKeys);

        // Chuyển hướng sang servlet download
        response.sendRedirect(request.getContextPath() + "/admin/downloadcdkey");
    }
}
