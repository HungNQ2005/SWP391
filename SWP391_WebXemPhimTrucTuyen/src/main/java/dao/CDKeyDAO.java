/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.CDKey;
import util.DBContext;

/**
 *
 * @author Nguyen Quoc Hung - CE190870
 */

public class CDKeyDAO {

    public List<CDKey> getCDKeys(int page, int pageSize) {
        List<CDKey> list = new ArrayList<>();
        String sql = "SELECT * FROM ( " +
                     " SELECT ROW_NUMBER() OVER (ORDER BY key_ID DESC) AS rownum, * " +
                     " FROM CDKey ) AS t " +
                     " WHERE rownum BETWEEN ? AND ?";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int start = (page - 1) * pageSize + 1;
            int end = page * pageSize;
            ps.setInt(1, start);
            ps.setInt(2, end);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new CDKey(
                        rs.getInt("key_ID"),
                        rs.getString("key_code"),
                        rs.getString("key_status"),
                        rs.getString("key_generatedBy"),
                        rs.getTimestamp("key_generatedTime")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countCDKeys() {
        String sql = "SELECT COUNT(*) FROM CDKey";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void insertCDKey(String code, String status, String generatedBy) {
        String sql = "INSERT INTO CDKey (key_code, key_status, key_generatedBy, key_generatedTime) " +
                     "VALUES (?, ?, ?, GETDATE())";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, code);
            ps.setString(2, status);
            ps.setString(3, generatedBy);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}