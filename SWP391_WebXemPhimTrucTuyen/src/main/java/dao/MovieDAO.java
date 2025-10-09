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

            String sql = "SELECT series_id,"
                    + " title,"
                    + " poster_url"
                    + " FROM Series";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Series series = new Series();

                series.setSeriesID(rs.getInt("series_id"));
                series.setTitle(rs.getString("title"));
                series.setPosteUrl(rs.getString("poster_url"));
                list.add(series);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
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

    public static void main(String[] args) {
        MovieDAO movieDAO = new MovieDAO();
        System.out.println(movieDAO.getAllCategories());
    }
}
