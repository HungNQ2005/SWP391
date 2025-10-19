/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Retail;
import util.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nguyen Quoc Hung - CE190870
 */
public class RetailDAO {

    /**
     * Get all retail records ordered by retail_ID ascending.
     *
     * @return list of Retail objects (may be empty, never null)
     */
    public List<Retail> getAllRetail() {
        List<Retail> list = new ArrayList<>();
        String sql = "SELECT retail_ID, name, address, phone, latitude, longitude, website FROM Retail ORDER BY retail_ID ASC";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Retail r = new Retail();
                r.setId(rs.getInt("retail_ID"));
                r.setName(rs.getString("name"));
                r.setAddress(rs.getString("address"));
                r.setPhone(rs.getString("phone"));
                r.setLatitude(rs.getDouble("latitude"));
                r.setLongitude(rs.getDouble("longitude"));
                r.setWebsite(rs.getString("website"));
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Get a single retail record by id.
     *
     * @param id retail_ID
     * @return Retail object or null if not found
     */
    public Retail getRetailById(int id) {
        String sql = "SELECT retail_ID, name, address, phone, latitude, longitude, website FROM Retail WHERE retail_ID = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Retail r = new Retail();
                    r.setId(rs.getInt("retail_ID"));
                    r.setName(rs.getString("name"));
                    r.setAddress(rs.getString("address"));
                    r.setPhone(rs.getString("phone"));
                    r.setLatitude(rs.getDouble("latitude"));
                    r.setLongitude(rs.getDouble("longitude"));
                    r.setWebsite(rs.getString("website"));
                    return r;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Insert a new retail record.
     *
     * @param r Retail object (id ignored)
     * @return true if insert succeeded
     */
    public boolean insertRetail(Retail r) {
        String sql = "INSERT INTO Retail(name, address, phone, latitude, longitude, website) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, r.getName());
            ps.setString(2, r.getAddress());
            ps.setString(3, r.getPhone());
            ps.setDouble(4, r.getLatitude());
            ps.setDouble(5, r.getLongitude());
            ps.setString(6, r.getWebsite());
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Update an existing retail record by id.
     *
     * @param r Retail object containing id and updated fields
     * @return true if update succeeded
     */
    public boolean updateRetail(Retail r) {
        String sql = "UPDATE Retail SET name = ?, address = ?, phone = ?, latitude = ?, longitude = ?, website = ? WHERE retail_ID = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, r.getName());
            ps.setString(2, r.getAddress());
            ps.setString(3, r.getPhone());
            ps.setDouble(4, r.getLatitude());
            ps.setDouble(5, r.getLongitude());
            ps.setString(6, r.getWebsite());
            ps.setInt(7, r.getId());
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Delete a retail record by id.
     *
     * @param id retail_ID to delete
     * @return true if delete succeeded
     */
    public boolean deleteRetail(int id) {
        String sql = "DELETE FROM Retail WHERE retail_ID = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
