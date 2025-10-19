package controller;

import dao.RetailDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Retail;

/**
 * 
 * @author Nguyen Quoc Hung - CE190870
 */
@WebServlet("/admin/retail")
public class RetailManagerController extends HttpServlet {

    private RetailDAO dao;

    @Override
    public void init() throws ServletException {
        dao = new RetailDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteRetail(request, response);
                break;
            default:
                listRetail(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "insert":
                insertRetail(request, response);
                break;
            case "update":
                updateRetail(request, response);
                break;
            default:
                listRetail(request, response);
                break;
        }
    }

    private void listRetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Retail> list = dao.getAllRetail();
        request.setAttribute("listRetail", list);
        RequestDispatcher rd = request.getRequestDispatcher("/admin/retailmanager.jsp");
        rd.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Retail existing = dao.getRetailById(id);
        request.setAttribute("retail", existing);
        listRetail(request, response);
    }

    private void insertRetail(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Retail r = new Retail();
        r.setName(request.getParameter("name"));
        r.setAddress(request.getParameter("address"));
        r.setPhone(request.getParameter("phone"));
        r.setLatitude(Double.parseDouble(request.getParameter("latitude")));
        r.setLongitude(Double.parseDouble(request.getParameter("longitude")));
        r.setWebsite(request.getParameter("website"));

        boolean success = dao.insertRetail(r);
        response.sendRedirect("retail?success=" + (success ? "insert" : "fail"));
    }

    private void updateRetail(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Retail r = new Retail();
        r.setId(Integer.parseInt(request.getParameter("id")));
        r.setName(request.getParameter("name"));
        r.setAddress(request.getParameter("address"));
        r.setPhone(request.getParameter("phone"));
        r.setLatitude(Double.parseDouble(request.getParameter("latitude")));
        r.setLongitude(Double.parseDouble(request.getParameter("longitude")));
        r.setWebsite(request.getParameter("website"));

        boolean success = dao.updateRetail(r);
        response.sendRedirect("retail?success=" + (success ? "update" : "fail"));
    }

    private void deleteRetail(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = dao.deleteRetail(id);
        response.sendRedirect("retail?success=" + (success ? "delete" : "fail"));
    }
}