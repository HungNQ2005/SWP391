package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import util.DBContext;

/**
 *
 * @author Nguyen Quoc Hung - CE190870
 */

@WebServlet("/activation")
public class AccountUpgradeController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String cdkey = request.getParameter("cdkey");
        String message = "";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBContext().getConnection();

            // 1. Lấy user
            String sqlUser = "SELECT user_ID, user_level FROM [User] WHERE username = ?";
            ps = conn.prepareStatement(sqlUser);
            ps.setString(1, username);
            rs = ps.executeQuery();

            if (!rs.next()) {
                message = "User not found!";
            } else {
                int userId = rs.getInt("user_ID");
                String userLevel = rs.getString("user_level");

                if (!"USR".equals(userLevel)) {
                    if ("PRE".equals(userLevel)) {
                        message = "You Are Already A Premium User!! Thank You For Your Support!";
                    } else {
                        message = "Only normal users can upgrade their account status!";
                    }
                } else {
                    // 2. Check CDkey
                    String sqlKey = "SELECT key_ID, key_status FROM CDKey WHERE key_code = ?";
                    ps = conn.prepareStatement(sqlKey);
                    ps.setString(1, cdkey.trim().toUpperCase());
                    rs = ps.executeQuery();

                    if (!rs.next()) {
                        message = "CD Key not found!";
                    } else {
                        int keyId = rs.getInt("key_ID");
                        String status = rs.getString("key_status").trim();

                        if (!"UNUSED".equalsIgnoreCase(status)) {
                            message = "CD Key already used or invalid!";
                        } else {
                            // 3. Update user level
                            String updateUser = "UPDATE [User] SET user_level = 'PRE' WHERE user_ID = ?";
                            ps = conn.prepareStatement(updateUser);
                            ps.setInt(1, userId);
                            ps.executeUpdate();

                            // 4. Update key status
                            String updateKey = "UPDATE CDKey SET key_status = 'USED' WHERE key_ID = ?";
                            ps = conn.prepareStatement(updateKey);
                            ps.setInt(1, keyId);
                            ps.executeUpdate();

                            // 5. Insert log
                            String insertLog = "INSERT INTO CDKeyActivation(user_ID, key_ID, activation_time) VALUES (?, ?, GETDATE())";
                            ps = conn.prepareStatement(insertLog);
                            ps.setInt(1, userId);
                            ps.setInt(2, keyId);
                            ps.executeUpdate();

                            message = "Activation successful! User upgraded to Premium.";
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            message = "Error: " + e.getMessage();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception ignored) {
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception ignored) {
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception ignored) {
            }
        }

        // Gửi message về lại JSP
        request.setAttribute("message", message);
        request.getRequestDispatcher("upgrade/activation.jsp").forward(request, response);
    }
}
