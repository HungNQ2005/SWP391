/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import util.DBContext;
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
public class FavoriteDAO {

    public boolean addFavorite(int userId, int seriesId) {
        if(isFavoriteExists(seriesId, userId)) {
            System.out.println("Phim đã có trong danh sách yêu thích, bỏ qua thêm mới!");
            return false;
        }
        String sql = "INSERT INTO Wishlist (user_id, series_id) "
                + "VALUES (?, ?)";

        try {
            Connection con = new DBContext().getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, seriesId);
            ps.executeUpdate();
            con.close();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean removeFavorite(int userId, int seriesId) {
        String sql = "DELETE FROM Wishlist "
                + "WHERE user_id=? AND series_id=?";

        try {
            Connection con = new DBContext().getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, seriesId);
            ps.executeUpdate();
            con.close();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Series> getFavoritesByUser(int userId) {
        List<Series> list = new ArrayList<>();
        String sql = "SELECT s.* "
                + "FROM Series "
                + "s JOIN Wishlist f "
                + "ON s.series_id = f.series_id "
                + "WHERE f.user_id = ?";

        try {
            Connection con = new DBContext().getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Series s = new Series();
                s.setSeriesID(rs.getInt("series_id"));
                s.setTitle(rs.getString("title"));
                s.setDescription(rs.getString("description"));
                s.setPosteUrl(rs.getString("poster_url"));
                list.add(s);
            }
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean isFavoriteExists(int userId, int seriesId) {
        String sql = "SELECT COUNT(*) " +
                "AS total FROM Wishlist" +
                " WHERE user_id = ? AND series_id = ?";

        try {
            Connection con = new DBContext().getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1,userId);
            ps.setInt(2, seriesId);

            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                int count = rs.getInt("total");
                con.close();
                return count > 0;
            }

        }catch (SQLException e){
            e.printStackTrace();

        }
        return false;
    }

    public static void main(String[] args) {
        FavoriteDAO dao = new FavoriteDAO();

        int testUserId = 19;
        int testSeriesId = 2;

        System.out.println("=== Bắt đầu test FavoriteDAO ===");

        boolean added = dao.addFavorite(testUserId, testSeriesId);
        System.out.println("addFavorite returned: " + added);

        boolean exists = dao.isFavoriteExists(testUserId, testSeriesId);
        System.out.println("isFavoriteExists = " + exists);

        System.out.println("\nDanh sách favorites hiện tại:");
        printFavorites(dao.getFavoritesByUser(testUserId));

        boolean removed = dao.removeFavorite(testUserId, testSeriesId);
        System.out.println("\nremoveFavorite returned: " + removed);

        System.out.println("\n=== Kết thúc test ===");
    }

    private static void printFavorites(List<Series> list) {
        if (list == null || list.isEmpty()) {
            System.out.println("[Không có phim trong danh sách yêu thích]");
            return;
        }
        for (Series s : list) {
            System.out.printf("ID=%d | Title=%s | Poster=%s\n",
                    s.getSeriesID(),
                    s.getTitle(),
                    s.getPosteUrl());
        }
    }
}

