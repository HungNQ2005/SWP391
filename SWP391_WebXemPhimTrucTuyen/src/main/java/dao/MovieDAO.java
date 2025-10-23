/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Category;
import entity.Series;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Chau Tan Cuong - CE190026
 */
public class MovieDAO {

    public List<Series> getAllSeries() {
        List<Series> list = new ArrayList<>();

        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();

            String sql = "SELECT series_id, " +
                    "title, " +
                    "release_year," +
                    " country, " +
                    "poster_url " +
                    "FROM [dbo].[Series]";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Series series = new Series();

                series.setSeriesID(rs.getInt("series_id"));
                series.setTitle(rs.getString("title"));
                series.setPosteUrl(rs.getString("poster_url"));
                series.setCountry(rs.getString("country"));
                list.add(series);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        MovieDAO movieDAO = new MovieDAO();
        System.out.println(movieDAO.getAllSeries());
    }


    // 🟩 Lấy danh sách phim theo từng trang
    public List<Series> getSeriesByPage(int offset, int limit) {
        List<Series> list = new ArrayList<>();
        String sql = "SELECT series_id, title, release_year, country, poster_url " +
                "FROM [dbo].[Series] " +
                "ORDER BY series_id " +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Series s = new Series();
                s.setSeriesID(rs.getInt("series_id"));
                s.setTitle(rs.getString("title"));
                s.setPosteUrl(rs.getString("poster_url"));
                s.setCountry(rs.getString("country"));
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🟩 Đếm tổng số phim để tính số trang
    public int getTotalSeriesCount() {
        String sql = "SELECT COUNT(*) FROM [dbo].[Series]";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }


    public Series getSeriesById(int id) {
        Series s = null;
        String sql = "SELECT *\n"
                + "FROM [dbo].[Series]\n"
                + "WHERE [series_id] = ?; ";

        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                s = new Series(
                        rs.getInt("series_id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getInt("release_year"),
                        rs.getString("country"),
                        rs.getString("trailer_url"),
                        rs.getString("poster_url")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;

    }

    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        try {
            Connection conn = new DBContext().getConnection();
            String sql = "SELECT * FROM Category";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(
                        rs.getInt("category_id"),
                        rs.getString("name"),
                        rs.getString("description")
                );
                list.add(c);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Series> getSeriesByCategoryId(int categoryId) {
        List<Series> list = new ArrayList<>();

        String sql = "SELECT s.series_id, s.title, s.poster_url\n"
                + "        FROM Series s\n"
                + "        INNER JOIN Series_Category sc ON s.series_id = sc.series_id\n"
                + "        WHERE sc.category_id = ?";

        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Series series = new Series();
                series.setSeriesID(rs.getInt("series_id"));
                series.setTitle(rs.getString("title"));
                series.setPosteUrl(rs.getString("poster_url"));
                list.add(series);
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Series> getSeriesByTypeId(int typeId) {
        List<Series> s = new ArrayList<>();
        String sql = "SELECT *\n" +
                "FROM [dbo].[Series]\n" +
                "WHERE [type_id] = ? ";

        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, typeId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                s.add(new Series(
                        rs.getInt("series_id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getInt("release_year"),
                        rs.getString("country"),
                        rs.getString("trailer_url"),
                        rs.getString("poster_url")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;

    }

    public List<Series> getSeriesByCountry(String country) {
        List<Series> list = new ArrayList<>();
        String sql = "SELECT series_id, title, poster_url,country\n"
                + "FROM [dbo].[Series]\n"
                + "WHERE country = ?;";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, country);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Series s = new Series();
                s.setSeriesID(rs.getInt("series_id"));
                s.setTitle(rs.getString("title"));
                s.setPosteUrl(rs.getString("poster_url"));
                s.setCountry(rs.getString("country"));
                list.add(s);
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public List<Series> searchSeries(String keyword) {
        List<Series> list = new ArrayList<>();

        String sql = "SELECT series_id, title, description, release_year, country, poster_url " +
                "FROM [dbo].[Series] " +
                "WHERE title LIKE ? OR description LIKE ? OR country LIKE ?";

        try(Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Series s = new Series();
                s.setSeriesID(rs.getInt("series_id"));
                s.setTitle(rs.getString("title"));
                s.setDescription(rs.getString("description"));
                s.setCountry(rs.getString("country"));
                s.setPosteUrl(rs.getString("poster_url"));
                list.add(s);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }
}

