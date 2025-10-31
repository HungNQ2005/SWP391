package dao;

import java.sql.*;
import model.User;

public class UserDAO {
    private static final String JDBC_URL = "jdbc:sqlserver://localhost:1433;databaseName=webFilm;encrypt=false";
    private static final String JDBC_USER = "sa";
    private static final String JDBC_PASSWORD = "123456";

    public Connection getConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Lấy user theo username
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM Users WHERE username=?";
        User u = null;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    u = new User();
                    u.setUserId(rs.getInt("user_id"));
                    u.setUsername(rs.getString("username"));
                    u.setEmail(rs.getString("email"));
                    u.setPasswordHash(rs.getString("password_hash"));
                    u.setFullName(rs.getString("full_name"));
                    u.setUserLevel(rs.getString("user_level"));
                    u.setAvatarUrl(rs.getString("avatar_url"));
                    u.setCreatedAt(rs.getTimestamp("created_at"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return u;
    }

    // Update email + password
    public boolean updateUser(User user) {
        String sql = "UPDATE Users SET email=?, password_hash=? WHERE user_id=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPasswordHash());
            ps.setInt(3, user.getUserId());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
