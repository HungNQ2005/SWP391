package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Performers;
import utils.DBContext;

public class PerformersDAO {

    public List<Performers> getAllPerformers() {
        List<Performers> list = new ArrayList<>();
        String sql = """
            SELECT performer_id, name, photo_url, gender, description, 
                   date_of_birth, nationality
            FROM Performer
        """;
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToPerformer(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Performers mapResultSetToPerformer(ResultSet rs) throws SQLException {
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

    public Performers getPerformerById(int id) {
        String sql = "SELECT * FROM Performer WHERE performer_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPerformer(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addPerformers(Performers p) {
        String sql = """
            INSERT INTO Performer (name, photo_url, gender, description, date_of_birth, nationality)
            VALUES (?, ?, ?, ?, ?, ?)
        """;
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getPhoto_url());
            ps.setString(3, p.getGender());
            ps.setString(4, p.getDescription());
            ps.setString(5, p.getDate_of_birth());
            ps.setString(6, p.getNationality());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updatePerformers(Performers performer) {
        String sql = """
            UPDATE Performer
            SET name=?, photo_url=?, gender=?, description=?, date_of_birth=?, nationality=?
            WHERE performer_id=?
        """;
        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, performer.getName());
            ps.setString(2, performer.getPhoto_url());
            ps.setString(3, performer.getGender());
            ps.setString(4, performer.getDescription());
            ps.setString(5, performer.getDate_of_birth());
            ps.setString(6, performer.getNationality());
            ps.setInt(7, performer.getPerformer_id());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean deletePerformers(int id) throws Exception {
        String sqlDeleteLink = "DELETE FROM Series_Performer WHERE performer_id = ?";
        String sqlDeletePerformer = "DELETE FROM Performer WHERE performer_id = ?";

        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps1 = conn.prepareStatement(sqlDeleteLink); PreparedStatement ps2 = conn.prepareStatement(sqlDeletePerformer)) {

                ps1.setInt(1, id);
                ps1.executeUpdate();

                ps2.setInt(1, id);
                int rows = ps2.executeUpdate();

                conn.commit();
                return rows > 0;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public List<Performers> getPerformersByPage(int page, int pageSize) {
        List<Performers> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = """
            SELECT * FROM Performer 
            ORDER BY performer_id 
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, offset);
            ps.setInt(2, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToPerformer(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private int countByQuery(String sql, String... params) {
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.length; i++) {
                ps.setString(i + 1, params[i]);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countPerformers() {
        return countByQuery("SELECT COUNT(*) FROM Performer");
    }

    public int countPerformersByKeyword(String keyword) {
        return countByQuery("SELECT COUNT(*) FROM Performer WHERE name LIKE ?", "%" + keyword + "%");
    }

    public List<Performers> getPerformersByPageAndKeyword(int page, int pageSize, String keyword) {
        List<Performers> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = """
            SELECT * FROM Performer 
            WHERE name LIKE ? 
            ORDER BY performer_id 
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, offset);
            ps.setInt(3, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToPerformer(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private boolean existsByQuery(String sql, Object... params) {
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean existsPerformer(String name, String dob, String nationality,
            String gender, String photoUrl, String description) {
        return existsByQuery("""
            SELECT COUNT(*) FROM Performer
            WHERE name=? AND date_of_birth=? AND nationality=? 
              AND gender=? AND photo_url=? AND description=?
        """, name, dob, nationality, gender, photoUrl, description);
    }

    public boolean existsPerformerForOtherId(String name, String dob, String nationality,
            String gender, int id) {
        return existsByQuery("""
            SELECT COUNT(*) FROM Performer
            WHERE name=? AND date_of_birth=? AND nationality=? AND gender=?
              AND performer_id<>?
        """, name, dob, nationality, gender, id);
    }

    public boolean existsPhoto(String photoUrl) {
        return existsByQuery("SELECT COUNT(*) FROM Performer WHERE photo_url=?", photoUrl);
    }

    public boolean existsPhotoForOtherId(String photoUrl, int performerId) {
        return existsByQuery(
                "SELECT COUNT(*) FROM Performer WHERE photo_url=? AND performer_id<>?",
                photoUrl, performerId);
    }
}
