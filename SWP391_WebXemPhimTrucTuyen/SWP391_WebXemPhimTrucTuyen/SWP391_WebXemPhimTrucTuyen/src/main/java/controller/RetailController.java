/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import com.google.gson.Gson;
import dao.RetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.util.List;
import model.Retail;

/**
 *
 * @author Nguyen Quoc Hung - CE190870
 */
@WebServlet("/api/retail")
public class RetailController extends HttpServlet {

    private final RetailDAO dao = new RetailDAO();
    private final Gson gson = new Gson();

    private void setCORS(HttpServletResponse resp) {
        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "GET, POST, DELETE, OPTIONS");
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type");
    }

    @Override
    protected void doOptions(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        setCORS(resp);
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        setCORS(resp);
        resp.setContentType("application/json;charset=UTF-8");
        List<Retail> list = dao.getAllRetail();
        resp.getWriter().write(gson.toJson(list));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        setCORS(resp);
        BufferedReader br = req.getReader();
        Retail r = gson.fromJson(br, Retail.class);
        boolean ok = dao.insertRetail(r);
        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().write("{\"success\":" + ok + "}");
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        setCORS(resp);
        String idParam = req.getParameter("id");
        boolean ok = false;
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                ok = dao.deleteRetail(id);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().write("{\"success\":" + ok + "}");
    }
}