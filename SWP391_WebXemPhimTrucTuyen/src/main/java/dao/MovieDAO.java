/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Category;
import entity.Country;
import entity.Series;
import org.w3c.dom.ls.LSOutput;

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
        String sql = "SELECT s.series_id, s.title, s.release_year, "
                + "STRING_AGG(c.country_name, ', ') AS countries, s.poster_url "
                + "FROM Series s "
                + "LEFT JOIN Series_Country sc ON s.series_id = sc.series_id "
                + "LEFT JOIN Country c ON sc.country_id = c.country_id "
                + "GROUP BY s.series_id, s.title, s.release_year, s.poster_url";

        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Series series = new Series();
                series.setSeriesID(rs.getInt("series_id"));
                series.setTitle(rs.getString("title"));
                series.setPosteUrl(rs.getString("poster_url"));
                series.setCountry(rs.getString("countries"));
                list.add(series);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🟩 Lấy danh sách phim theo từng trang
    public List<Series> getSeriesByPage(int offset, int limit) {
        List<Series> list = new ArrayList<>();
        String sql = "SELECT s.series_id, s.title, s.release_year, "
                + "STRING_AGG(c.country_name, ', ') AS country, s.poster_url "
                + "FROM [dbo].[Series] s "
                + "LEFT JOIN Series_Country sc ON s.series_id = sc.series_id "
                + "LEFT JOIN Country c ON sc.country_id = c.country_id "
                + "GROUP BY s.series_id, s.title, s.release_year, s.poster_url "
                + "ORDER BY s.series_id "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Series s = new Series();
                    s.setSeriesID(rs.getInt("series_id"));
                    s.setTitle(rs.getString("title"));
                    s.setPosteUrl(rs.getString("poster_url"));
                    s.setCountry(rs.getString("country"));
                    list.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🟩 Đếm tổng số phim để tính số trang
    public int getTotalSeriesCount() {
        String sql = "SELECT COUNT(*) FROM [dbo].[Series]";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
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
        String sql = "SELECT s.series_id, s.title, s.description, s.release_year, "
                + "STRING_AGG(c.country_name, ', ') AS country, s.trailer_url, s.poster_url "
                + "FROM [dbo].[Series] s "
                + "LEFT JOIN Series_Country sc ON s.series_id = sc.series_id "
                + "LEFT JOIN Country c ON sc.country_id = c.country_id "
                + "WHERE s.series_id = ? "
                + "GROUP BY s.series_id, s.title, s.description, s.release_year, s.trailer_url, s.poster_url";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
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
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;
    }

    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Category";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Category c = new Category(
                        rs.getInt("category_id"),
                        rs.getString("name"),
                        rs.getString("description")
                );
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Series> getSeriesByCategoryId(int categoryId) {
        List<Series> list = new ArrayList<>();

        String sql = "SELECT s.series_id, s.title, s.poster_url "
                + "FROM Series s "
                + "INNER JOIN Series_Category sc ON s.series_id = sc.series_id "
                + "WHERE sc.category_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Series series = new Series();
                    series.setSeriesID(rs.getInt("series_id"));
                    series.setTitle(rs.getString("title"));
                    series.setPosteUrl(rs.getString("poster_url"));
                    list.add(series);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Series> getSeriesByTypeId(int typeId) {
        List<Series> s = new ArrayList<>();
        String sql = "SELECT s.series_id, s.title, s.description, s.release_year, "
                + "STRING_AGG(c.country_name, ', ') AS country, s.trailer_url, s.poster_url "
                + "FROM [dbo].[Series] s "
                + "LEFT JOIN Series_Country sc ON s.series_id = sc.series_id "
                + "LEFT JOIN Country c ON sc.country_id = c.country_id "
                + "WHERE s.type_id = ? "
                + "GROUP BY s.series_id, s.title, s.description, s.release_year, s.trailer_url, s.poster_url";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, typeId);
            try (ResultSet rs = ps.executeQuery()) {
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
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;
    }

    public List<Series> getSeriesByCountry(String country) {
        List<Series> list = new ArrayList<>();
        String sql = "SELECT s.series_id, s.title, s.poster_url, "
                + "STRING_AGG(c.country_name, ', ') AS countries "
                + "FROM Series s "
                + "INNER JOIN Series_Country sc ON s.series_id = sc.series_id "
                + "INNER JOIN Country c ON sc.country_id = c.country_id "
                + "WHERE c.country_name = ? "
                + "GROUP BY s.series_id, s.title, s.poster_url";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, country);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Series s = new Series();
                    s.setSeriesID(rs.getInt("series_id"));
                    s.setTitle(rs.getString("title"));
                    s.setPosteUrl(rs.getString("poster_url"));
                    s.setCountry(rs.getString("countries"));
                    list.add(s);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public List<Series> searchSeries(String keyword) {
        List<Series> list = new ArrayList<>();

        String sql = "SELECT s.series_id, s.title, s.description, s.release_year,\n"
                + "           STRING_AGG(c.country_name, ', ') AS country, s.poster_url\n"
                + "    FROM [dbo].[Series] s\n"
                + "    LEFT JOIN Series_Country sc ON s.series_id = sc.series_id\n"
                + "    LEFT JOIN Country c ON sc.country_id = c.country_id\n"
                + "    WHERE s.title LIKE ?\n"
                + "    GROUP BY s.series_id, s.title, s.description, s.release_year, s.poster_url\n"
                + "    ;";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Series s = new Series();
                    s.setSeriesID(rs.getInt("series_id"));
                    s.setTitle(rs.getString("title"));
                    s.setDescription(rs.getString("description"));
                    s.setCountry(rs.getString("country"));
                    s.setPosteUrl(rs.getString("poster_url"));
                    list.add(s);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Country> getAllCountry() {
        List<Country> list = new ArrayList<>();
        String sql = "SELECT country_id, country_name FROM Country ORDER BY country_name";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Country c = new Country(rs.getInt("country_id"), rs.getString("country_name"));
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public String getFilmUrlById(int id) {
        String sql = "SELECT film_url FROM [dbo].[Series] WHERE series_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("film_url");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Series getMovieById(int id) {
        String sql = "SELECT * FROM Series WHERE series_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Series m = new Series();
                m.setSeriesID(rs.getInt("series_id"));
                m.setTitle(rs.getString("title"));
                m.setDescription(rs.getString("description"));
                m.setReleaseYear(rs.getInt("release_year"));
                m.setPosteUrl(rs.getString("poster_url"));
                m.setTrailerUrl(rs.getString("trailer_url"));
                m.setFilmUrl(rs.getString("film_url"));
                m.setTypeId(rs.getInt("type_id")); // 1 = phim lẻ, 2 = phim bộ
                return m;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        MovieDAO dao = new MovieDAO();
        Series m = dao.getMovieById(2);
        System.out.println(m);
    }

}
