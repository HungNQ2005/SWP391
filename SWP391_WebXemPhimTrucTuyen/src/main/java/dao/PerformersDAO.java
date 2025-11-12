package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entity.Performers;
import entity.Series;


public class PerformersDAO {

    public List<entity.Performers> getAllPerformers() {
        List<entity.Performers> list = new ArrayList<>();
        String sql = "SELECT performer_id, name, photo_url, gender, description, \n" +
                "                   date_of_birth, nationality\n" +
                "            FROM Performer\n" +
                "       ;";

        try (Connection con = new DBContext().getConnection();  PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

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
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

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
        String sql = "   INSERT INTO Performer (name, photo_url, gender, description, date_of_birth, nationality)\n" +
                "            VALUES (?, ?, ?, ?, ?, ?)\n" +
                "       ;";

        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getPhotoUrl());
            ps.setString(3, p.getGender());
            ps.setString(4, p.getDescription());
            ps.setString(5, p.getDateOfBirth());
            ps.setString(6, p.getNationality());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updatePerformers(Performers performer) {
        String sql = " UPDATE Performer\n" +
                "            SET name=?, photo_url=?, gender=?, description=?, date_of_birth=?, nationality=?\n" +
                "            WHERE performer_id=?\n" +
                "        ;";

        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, performer.getName());
            ps.setString(2, performer.getPhotoUrl());
            ps.setString(3, performer.getGender());
            ps.setString(4, performer.getDescription());
            ps.setString(5, performer.getDateOfBirth());
            ps.setString(6, performer.getNationality());
            ps.setInt(7, performer.getPerformerID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean deletePerformers(int id) throws Exception {
        String sqlDeleteLink = "DELETE FROM Series_Performer WHERE performer_id = ?";
        String sqlDeletePerformer = "DELETE FROM Performer WHERE performer_id = ?";

        try (Connection conn = new DBContext().getConnection();) {
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
        String sql = " SELECT * FROM Performer \n" +
                "            ORDER BY performer_id \n" +
                "            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY\n" +
                "        ;";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
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
        String sql = "SELECT * FROM Performer \n" +
                "            WHERE name LIKE ? \n" +
                "            ORDER BY performer_id \n" +
                "            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY\n" +
                "        ;";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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
        return existsByQuery("SELECT COUNT(*) FROM Performer\n" +
                "            WHERE name=? AND date_of_birth=? AND nationality=? \n" +
                "              AND gender=? AND photo_url=? AND description=?\n" +
                "        , name, dob, nationality, gender, photoUrl, description);");

    }

    public boolean existsPerformerForOtherId(String name, String dob, String nationality,
            String gender, int id) {
        return existsByQuery("SELECT COUNT(*) FROM Performer\n" +
                "            WHERE name=? AND date_of_birth=? AND nationality=? AND gender=?\n" +
                "              AND performer_id<>?\n" +
                "       , name, dob, nationality, gender, id);\n" +
                "    }");

    }

    public boolean existsPhoto(String photoUrl) {
        return existsByQuery("SELECT COUNT(*) FROM Performer WHERE photo_url=?", photoUrl);
    }

    public boolean existsPhotoForOtherId(String photoUrl, int performerId) {
        return existsByQuery(
                "SELECT COUNT(*) FROM Performer WHERE photo_url=? AND performer_id<>?",
                photoUrl, performerId);
    }
    
      public List<Series> getSeriesByPerformer(int performerId) {
        List<Series> list = new ArrayList<>();
        String sql = "SELECT s.series_id, s.title, s.poster_url "
                + "FROM Series s "
                + "JOIN Series_Performer sp ON s.series_id = sp.series_id "
                + "WHERE sp.performer_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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

    public void updatePerformerSeries(int performerId, String[] seriesIds) {
        String deleteSQL = "DELETE FROM Series_Performer WHERE performer_id = ?";
        String insertSQL = "INSERT INTO Series_Performer(series_id, performer_id) VALUES (?, ?)";
        try (Connection conn = new DBContext().getConnection();) {
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
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, seriesId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Performers p = new Performers();
                p.setPerformerID(rs.getInt("performer_id"));
                p.setName(rs.getString("name"));
                p.setPhotoUrl(rs.getString("photo_url"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addPerformerToSeries(int seriesId, int performerId) {
        String sql = "INSERT INTO Series_Performer(series_id, performer_id) VALUES(?, ?)";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, seriesId);
            ps.setInt(2, performerId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
                                   
    public void removePerformerFromSeries(int seriesId, int performerId) {
        String sql = "DELETE FROM Series_Performer WHERE series_id = ? AND performer_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, seriesId);
            ps.setInt(2, performerId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
}
