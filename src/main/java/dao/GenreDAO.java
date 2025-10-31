package dao;

import java.sql.*;
import java.util.*;
import model.Genre;

public class GenreDAO {

    private static final String JDBC_URL = "jdbc:sqlserver://localhost:1433;databaseName=movie_admin;encrypt=false";
    private static final String JDBC_USER = "sa"; // ⚠️ Thay nếu khác
    private static final String JDBC_PASSWORD = "123456"; // ⚠️ Thay bằng mật khẩu thật

    // ========================= CONNECT =========================
    public Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            System.out.println("✅ Connected to SQL Server successfully!");
        } catch (Exception e) {
            System.out.println("❌ Failed to connect to SQL Server: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }

    // ========================= GET ALL =========================
    public List<Genre> getAllGenres() {
        List<Genre> list = new ArrayList<>();
        String sql = "SELECT genre_id, genre_name, description FROM Genre";
        Connection conn = getConnection();

        if (conn == null) {
            System.out.println("❌ Connection is null. Cannot query database.");
            return list;
        }

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Genre g = new Genre();
                g.setGenreId(rs.getInt("genre_id"));
                g.setGenreName(rs.getString("genre_name"));
                g.setDescription(rs.getString("description"));
                list.add(g);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return list;
    }

    // ========================= INSERT =========================
    public boolean insertGenre(Genre g) {
        String sql = "INSERT INTO Genre (genre_name, description) VALUES (?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, g.getGenreName());
            ps.setString(2, g.getDescription());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ========================= GET BY ID =========================
    public Genre getGenreById(int id) {
        String sql = "SELECT genre_id, genre_name, description FROM Genre WHERE genre_id = ?";
        Genre g = null;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    g = new Genre();
                    g.setGenreId(rs.getInt("genre_id"));
                    g.setGenreName(rs.getString("genre_name"));
                    g.setDescription(rs.getString("description"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return g;
    }

    // ========================= UPDATE =========================
    public boolean updateGenre(Genre g) {
        String sql = "UPDATE Genre SET genre_name = ?, description = ? WHERE genre_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, g.getGenreName());
            ps.setString(2, g.getDescription());
            ps.setInt(3, g.getGenreId());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ========================= DELETE =========================
    public boolean deleteGenre(int id) {
        String sql = "DELETE FROM Genre WHERE genre_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
