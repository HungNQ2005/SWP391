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

    public List<Retail> getAllRetail() {
        List<Retail> list = new ArrayList<>();
        String sql = "SELECT retail_ID, name, address, phone, latitude, longitude FROM Retail ORDER BY retail_ID ASC";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Retail r = new Retail();
                r.setId(rs.getInt("retail_ID"));
                r.setName(rs.getString("name"));
                r.setAddress(rs.getString("address"));
                r.setPhone(rs.getString("phone"));
                r.setLatitude(rs.getDouble("latitude"));
                r.setLongitude(rs.getDouble("longitude"));
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertRetail(Retail r) {
        String sql = "INSERT INTO Retail(name, address, phone, latitude, longitude) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, r.getName());
            ps.setString(2, r.getAddress());
            ps.setString(3, r.getPhone());
            ps.setDouble(4, r.getLatitude());
            ps.setDouble(5, r.getLongitude());
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteRetail(int id) {
        String sql = "DELETE FROM Retail WHERE retail_ID = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

