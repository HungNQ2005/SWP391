/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import entity.User;
/**
 *
 * @author Chau Tan Cuong - CE190026
 */
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.UUID;

public class UserDAO {

    public int signUp(String username, String email, String password, String full_name, String user_level, String avatar_url) {
        int result = 0;

        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            String sql = "INSERT INTO [dbo].[Users](\n"
                    + "[username],\n"
                    + "[email],\n"
                    + "[password_hash],\n"
                    + "[full_name],\n"
                    + "[user_level],\n"
                    + "[avatar_url])\n"
                    + "VALUES(?,?,?,?,?,?);";
            PreparedStatement st = con.prepareStatement(sql);

            String hash_password = HashUtil.hashPassword(password);
            st.setString(1, username);
            st.setString(2, email);
            st.setString(3, hash_password);
            st.setString(4, "will update");
            st.setString(5, "Guest");
            st.setString(6, "default");

            result = st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public User login(String username, String password) {
        User result = null;

        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();

            // Chỉ query theo username
            String sql = "SELECT * FROM [dbo].[Users] WHERE [username] = ?";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("password_hash");

                // So sánh mật khẩu nhập vào với mật khẩu hash trong DB
                if (HashUtil.checkPassword(password, hashedPassword)) {
                    result = new User();
                    result.setUser_id(rs.getInt("user_id"));
                    result.setUsername(rs.getString("username"));
                    result.setEmail(rs.getString("email"));
                    result.setHash_password(hashedPassword);
                    result.setFull_name(rs.getString("full_name"));
                    result.setUser_level(rs.getString("user_level"));
                    result.setAvatar_url(rs.getString("avatar_url"));
                }
            }

            DBContext.closeConnection(con);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public User findByEmail(String email) {
        try {

            DBContext db = new DBContext();
            Connection con = db.getConnection();

            String sql = "SELECT * \n"
                    + "FROM [dbo].[Users]\n"
                    + "WHERE [email] = ?;";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUser_id(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setHash_password(rs.getString("password_hash"));

                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String saveResetToken(String email) {
        String token = UUID.randomUUID().toString();

        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();

            String sql = "UPDATE Users SET"
                    + " reset_token = ?,"
                    + " token_expiry = ? "
                    + "WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, token);
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis() + 3600 * 1000));
            ps.setString(3, email);

            int updated = ps.executeUpdate();

            if (updated > 0) {
                return token;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getEmailByToken(String token) {

        // Check tham số đầu vào
        if (token == null || token.trim().isEmpty()) {
            return null;
        }
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();

            String sql = "SELECT email, token_expiry "
                    + "FROM Users "
                    + "WHERE reset_token = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Timestamp expiry = rs.getTimestamp("token_expiry");
                if (expiry != null && expiry.after(new Timestamp(System.currentTimeMillis()))) {
                    return rs.getString("email");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updatePassword(String email, String newPassword) {
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();

            String sql = "UPDATE Users SET "
                    + "password_hash = ?, "
                    + "reset_token = NULL, "
                    + "token_expiry = NULL "
                    + "WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            String hashedPassword = HashUtil.hashPassword(newPassword);
            ps.setString(1, hashedPassword);
            ps.setString(2, email);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean activateUser(String token) {
        try (Connection con = new DBContext().getConnection()) {
            String sql = "UPDATE Users SET is_active = 1, activation_token = NULL WHERE activation_token = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, token);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void signUpWithEmail(String username, String email, String password, String token) {
        String sql = "INSERT INTO Users (username, email, password_hash, is_active, activation_token) VALUES (?, ?, ?, 0, ?)";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, email);
            String hashedPassword = HashUtil.hashPassword(password);
            ps.setString(3, hashedPassword);
            ps.setString(4, token);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateAvatar(int userId, String avatarPath) {
        String sql = "UPDATE Users "
                + "SET avatar_url = ? "
                + "WHERE user_id = ?";
        try {

            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, avatarPath);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
