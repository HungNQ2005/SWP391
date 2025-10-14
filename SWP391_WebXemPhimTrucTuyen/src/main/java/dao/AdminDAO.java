/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Category;
import entity.Series;
import java.util.List;
import entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Chau Tan Cuong - CE190026
 */
public class AdminDAO {

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT user_id,"
                + " username,"
                + " email,"
                + " full_name,"
                + " user_level,"
                + " avatar_url "
                + "FROM Users";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User u = new User();
                u.setUser_id(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setFull_name(rs.getString("full_name"));
                u.setUser_level(rs.getString("user_level"));
                u.setAvatar_url(rs.getString("avatar_url"));
                list.add(u);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insertUser(User user) {
        String sql = "INSERT INTO Users ("
                + "username,"
                + " email,"
                + " password_hash,"
                + " full_name,"
                + " user_level,"
                + " avatar_url) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            String hashedPassword = HashUtil.hashPassword(user.getHash_password());
            ps.setString(3, hashedPassword);
            ps.setString(4, user.getFull_name());
            ps.setString(5, user.getUser_level());
            ps.setString(6, user.getAvatar_url());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateUser(User user) {
        String sql = "UPDATE Users SET"
                + " username=?,"
                + " email=?,"
                + " full_name=?,"
                + " user_level=?,"
                + " avatar_url=?"
                + " WHERE user_id=?";

        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getFull_name());
            ps.setString(4, user.getUser_level());
            ps.setString(5, user.getAvatar_url());
            ps.setInt(6, user.getUser_id());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteUser(int id) {
        String sql = "DELETE FROM Users WHERE user_id=?";

        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public User getUserById(int id) {
        String sql = "SELECT * FROM Users WHERE user_id=?";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("hash_password"),
                        rs.getString("full_name"),
                        rs.getString("user_level"),
                        rs.getString("avatar_url")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Series> getAllSeriesForAdmin() {
        List<Series> list = new ArrayList<>();

        String sql = "SELECT * FROM Series";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);

            while (rs.next()) {
                Series s = new Series();
                s.setSeriesID(rs.getInt("series_id"));
                s.setTitle(rs.getString("title"));
                s.setDescription(rs.getString("description"));
                s.setReleaseYear(rs.getShort("release_year"));
                s.setCountry(rs.getString("country"));
                s.setPosteUrl(rs.getString("poster_url"));
                s.setTrailerUrl(rs.getString("trailer_url"));
                s.setTypeId(rs.getShort("type_id"));
                list.add(s);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int insertSeriesForAdmin(Series s) {
        String sql = "INSERT INTO Series (title, description, release_year, country, poster_url, trailer_url, type_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        int generatedId = -1; // mặc định nếu lỗi

        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();

            // chỉ định trả về ID tự tăng
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, s.getTitle());
            ps.setString(2, s.getDescription());
            ps.setInt(3, s.getReleaseYear());
            ps.setString(4, s.getCountry());
            ps.setString(5, s.getPosteUrl());
            ps.setString(6, s.getTrailerUrl());
            ps.setInt(7, s.getTypeId());

            ps.executeUpdate();

            // lấy ID được tạo ra
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return generatedId;
    }

    public Series getSeriesByIdForAdmin(int id) {
        String sql = "SELECT * "
                + "FROM Series"
                + " WHERE series_id = ?";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Series s = new Series();
                s.setSeriesID(rs.getInt("series_id"));
                s.setTitle(rs.getString("title"));
                s.setDescription(rs.getString("description"));
                s.setReleaseYear(rs.getShort("release_year"));
                s.setCountry(rs.getString("country"));
                s.setPosteUrl(rs.getString("poster_url"));
                s.setTrailerUrl(rs.getString("trailer_url"));
                s.setTypeId(rs.getShort("type_id"));
                return s;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateSeriesForAdmin(Series s) {
        String sql = "UPDATE Series SET title=?, description=?, release_year=?, country=?, poster_url=?, trailer_url=?, type_id=? WHERE series_id=?";
        boolean success = false;

        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, s.getTitle());
            ps.setString(2, s.getDescription());
            ps.setInt(3, s.getReleaseYear());
            ps.setString(4, s.getCountry());
            ps.setString(5, s.getPosteUrl());
            ps.setString(6, s.getTrailerUrl());
            ps.setObject(7, s.getTypeId(), java.sql.Types.SMALLINT);
            ps.setInt(8, s.getSeriesID());

            int rows = ps.executeUpdate();
            success = (rows > 0); // nếu có ít nhất 1 dòng bị ảnh hưởng => thành công

            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    public boolean deleteSeriesForAdmin(int id) {
        String sql = "DELETE FROM Series WHERE series_id=?";
        boolean success = false;

        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            int rows = ps.executeUpdate();
            success = (rows > 0); // nếu có ít nhất 1 dòng bị xóa -> thành công

            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    public List<Integer> getCategoryBySeriesId(int seriesId) {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT category_id "
                + "FROM Series_Category"
                + " WHERE series_id = ?";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, seriesId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(rs.getInt("category_id"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insertSeriesCategories(int seriesId, List<Integer> categoryIds) {
        String sql = "INSERT INTO Series_Category"
                + " (series_id, category_id)"
                + " VALUES (?, ?)";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            for (int catId : categoryIds) {
                ps.setInt(1, seriesId);
                ps.setInt(2, catId);
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteSeriesCategories(int seriesId) {
        String sql = "DELETE FROM Series_Category"
                + " WHERE series_id = ?";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, seriesId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT category_id, name, description FROM Category";

        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category c = new Category();
                c.setCategory_id(rs.getInt("category_id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                list.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

}
