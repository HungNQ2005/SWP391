package controller;

import dao.DBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;


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
            DBContext db = new DBContext();
            conn = new DBContext().getConnection();

            // 1. Lấy user
            String sqlUser = "SELECT user_id, user_level FROM [Users] WHERE username = ?";
            ps = conn.prepareStatement(sqlUser);
            ps.setString(1, username);
            rs = ps.executeQuery();

            if (!rs.next()) {
                message = "User not found!";
            } else {
                int userId = rs.getInt("user_id");
                String userLevel = rs.getString("user_level");

                if (!"User".equals(userLevel) && !"premium".equals(userLevel)) {
                    message = "Only normal users or premium users can activate CD Keys!";
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
                            // Nếu user hiện tại là USR → nâng lên PRE + set hạn = ngày hiện tại + 180 ngày
                            if ("User".equalsIgnoreCase(userLevel)) {
                                String updateUser = "UPDATE [Users] "
                                        + "SET user_level = 'premium', "
                                        + "premiumExpireDate = DATEADD(DAY, 180, GETDATE()) "
                                        + "WHERE user_id = ?";
                                ps = conn.prepareStatement(updateUser);
                                ps.setInt(1, userId);
                                ps.executeUpdate();

                                message = "Activation successful! User upgraded to Premium (180 days).";

                            // Nếu user hiện tại đã là PRE → giữ nguyên role, cộng thêm 180 ngày vào premiumExpireDate
                            } else if ("premium".equalsIgnoreCase(userLevel)) {
                                String updateUser = "UPDATE [Users] "
                                        + "SET premiumExpireDate = DATEADD(DAY, 180, premiumExpireDate) "
                                        + "WHERE user_id = ?";
                                ps = conn.prepareStatement(updateUser);
                                ps.setInt(1, userId);
                                ps.executeUpdate();

                                message = "Premium extended for additional 180 days.";
                            }

                            // 4. Update key status
                            String updateKey = "UPDATE CDKey SET key_status = 'USED' WHERE key_ID = ?";
                            ps = conn.prepareStatement(updateKey);
                            ps.setInt(1, keyId);
                            ps.executeUpdate();

                            // 5. Insert log
                            String insertLog = "INSERT INTO CDKeyActivation(user_id, key_ID, activation_time) VALUES (?, ?, GETDATE())";
                            ps = conn.prepareStatement(insertLog);
                            ps.setInt(1, userId);
                            ps.setInt(2, keyId);
                            ps.executeUpdate();
                        }
                    }
                }

            }

        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException ignored) {
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException ignored) {
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ignored) {
            }
        }

        // Gửi message về lại JSP
        request.setAttribute("message", message);
        request.getRequestDispatcher("upgrade/activation.jsp").forward(request, response);
    }


}