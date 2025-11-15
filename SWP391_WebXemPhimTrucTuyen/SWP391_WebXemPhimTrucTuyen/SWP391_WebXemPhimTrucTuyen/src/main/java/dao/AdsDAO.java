package dao;

import entity.Ads;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;

/**
 * @author
 * Chau Tan Cuong - CE190026
 */
public class AdsDAO {

    // 🟩 Lấy tất cả quảng cáo
    public List<Ads> getAllAds() {
        List<Ads> list = new ArrayList<>();
        String sql = "SELECT * FROM Ads ORDER BY ads_ID DESC";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Ads a = new Ads(
                        rs.getInt("ads_ID"),
                        rs.getString("ads_name"),
                        rs.getString("ads_image"),
                        rs.getString("ads_link"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                list.add(a);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🟩 Lấy quảng cáo theo ID
    public Ads getAdsById(int id) {
        String sql = "SELECT * FROM Ads WHERE ads_ID = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Ads(
                            rs.getInt("ads_ID"),
                            rs.getString("ads_name"),
                            rs.getString("ads_image"),
                            rs.getString("ads_link"),
                            rs.getString("status"),
                            rs.getTimestamp("created_at"),
                            rs.getTimestamp("updated_at")
                    );
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 🟩 Thêm quảng cáo mới
    public void addAds(Ads a) {
        String sql = "INSERT INTO Ads (ads_name, ads_image, ads_link, status, created_at) "
                + "VALUES (?, ?, ?, ?, GETDATE())";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, a.getAds_name());
            ps.setString(2, a.getAds_image());
            ps.setString(3, a.getAds_link());
            ps.setString(4, a.getStatus());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 🟩 Cập nhật quảng cáo
    public void updateAds(Ads a) {
        String sql = "UPDATE Ads SET ads_name = ?, ads_image = ?, ads_link = ?, "
                + "status = ?, updated_at = GETDATE() WHERE ads_ID = ?";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, a.getAds_name());
            ps.setString(2, a.getAds_image());
            ps.setString(3, a.getAds_link());
            ps.setString(4, a.getStatus());
            ps.setInt(5, a.getAds_ID());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 🟩 Xóa quảng cáo
    public void deleteAds(int id) {
        String sql = "DELETE FROM Ads WHERE ads_ID = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Ads> getActiveAds() {
    List<Ads> list = new ArrayList<>();
    String sql = "SELECT * FROM Ads WHERE status = 'Active' ORDER BY ads_ID DESC";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Ads a = new Ads(
                    rs.getInt("ads_ID"),
                    rs.getString("ads_name"),
                    rs.getString("ads_image"),
                    rs.getString("ads_link"),
                    rs.getString("status"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at")
            );
            list.add(a);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}



}
