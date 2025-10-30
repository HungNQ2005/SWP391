/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Performers;
import model.Series;
import utils.DBContext;

/**
 *
 * @author Vo Thi Phi Yen - CE190428
 */
public class SeriesDAO {

    public List<Series> getSeriesByPerformer(int performerId) {
        List<Series> list = new ArrayList<>();
        String sql = "SELECT s.series_id, s.title, s.poster_url "
                + "FROM Series s "
                + "JOIN Series_Performer sp ON s.series_id = sp.series_id "
                + "WHERE sp.performer_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, performerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Series s = new Series();
                s.setSeriesID(rs.getInt("series_id"));
                s.setTitle(rs.getString("title"));
                s.setPosteUrl(rs.getString("poster_url"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Series> getAllSeries() {
        List<Series> list = new ArrayList<>();

        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();

            String sql = "SELECT series_id, "
                    + "title, "
                    + "release_year,"
                    + " country, "
                    + "poster_url "
                    + "FROM [dbo].[Series]";

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

    // Cập nhật performer-series (xóa cũ, thêm mới)
    public void updatePerformerSeries(int performerId, String[] seriesIds) {
        String deleteSQL = "DELETE FROM Series_Performer WHERE performer_id = ?";
        String insertSQL = "INSERT INTO Series_Performer(series_id, performer_id) VALUES (?, ?)";
        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement psDel = conn.prepareStatement(deleteSQL)) {
                psDel.setInt(1, performerId);
                psDel.executeUpdate();
            }

            if (seriesIds != null) {
                try (PreparedStatement psIns = conn.prepareStatement(insertSQL)) {
                    for (String sid : seriesIds) {
                        psIns.setInt(1, Integer.parseInt(sid));
                        psIns.setInt(2, performerId);
                        psIns.addBatch();
                    }
                    psIns.executeBatch();
                }
            }

            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Performers> getPerformersBySeries(int seriesId) {
        List<Performers> list = new ArrayList<>();
        String sql = "SELECT p.performer_id, p.name, p.photo_url "
                + "FROM Performer p "
                + "JOIN Series_Performer sp ON p.performer_id = sp.performer_id "
                + "WHERE sp.series_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, seriesId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Performers p = new Performers();
                p.setPerformer_id(rs.getInt("performer_id"));
                p.setName(rs.getString("name"));
                p.setPhoto_url(rs.getString("photo_url"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm performer vào series
    public void addPerformerToSeries(int seriesId, int performerId) {
        String sql = "INSERT INTO Series_Performer(series_id, performer_id) VALUES(?, ?)";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, seriesId);
            ps.setInt(2, performerId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

// Xóa performer khỏi series
    public void removePerformerFromSeries(int seriesId, int performerId) {
        String sql = "DELETE FROM Series_Performer WHERE series_id = ? AND performer_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, seriesId);
            ps.setInt(2, performerId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
