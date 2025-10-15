package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Performers;
import utils.DBContext;

public class PerformersDAO {

    public List<Performers> getAllPerformers() {
        List<Performers> list = new ArrayList<>();
        String sql = "SELECT * FROM Performer";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Performers p = new Performers(
                        rs.getInt("performer_id"),
                        rs.getString("name"),
                        rs.getString("photo_url"),
                        rs.getString("gender"),
                        rs.getString("description"),
                        rs.getString("date_of_birth"),
                        rs.getString("nationality")
                );
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Performers getPerformerById(int id) {
        String sql = "SELECT * FROM Performer WHERE performer_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Performers(
                        rs.getInt("performer_id"),
                        rs.getString("name"),
                        rs.getString("photo_url"),
                        rs.getString("gender"),
                        rs.getString("description"),
                        rs.getString("date_of_birth"),
                        rs.getString("nationality")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Performers addPerformers(Performers p) {
        String sql = "INSERT INTO Performer (name, photo_url, gender, description, date_of_birth, nationality) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getPhoto_url());
            ps.setString(3, p.getGender());
            ps.setString(4, p.getDescription());
            ps.setString(5, p.getDate_of_birth());
            ps.setString(6, p.getNationality());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updatePerformers(Performers performer) {
        String sql = "UPDATE Performer SET name=?, photo_url=?, gender=?, description=?, date_of_birth=?, nationality=? WHERE performer_id=?";
        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, performer.getName());
            ps.setString(2, performer.getPhoto_url());
            ps.setString(3, performer.getGender());
            ps.setString(4, performer.getDescription());
            ps.setString(5, performer.getDate_of_birth());
            ps.setString(6, performer.getNationality());
            ps.setInt(7, performer.getPerformer_id());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Performers> getPerformersByPage(int page, int pageSize) {
        List<Performers> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM Performer ORDER BY performer_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Performers(
                            rs.getInt("performer_id"),
                            rs.getString("name"),
                            rs.getString("photo_url"),
                            rs.getString("gender"),
                            rs.getString("description"),
                            rs.getString("date_of_birth"),
                            rs.getString("nationality")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countPerformers() {
        String sql = "SELECT COUNT(*) FROM Performer";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void deletePerformers(int id) {
        String sql = "DELETE FROM Performer WHERE performer_id=?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate(); 
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public int countPerformersByKeyword(String keyword) {
        String sql = "SELECT COUNT(*) FROM Performer WHERE name LIKE ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Performers> getPerformersByPageAndKeyword(int page, int pageSize, String keyword) {
        List<Performers> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM Performer WHERE name LIKE ? ORDER BY performer_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, offset);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Performers(
                    rs.getInt("performer_id"),
                    rs.getString("name"),
                    rs.getString("photo_url"),
                    rs.getString("gender"),
                    rs.getString("description"),
                    rs.getString("date_of_birth"),
                    rs.getString("nationality")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}