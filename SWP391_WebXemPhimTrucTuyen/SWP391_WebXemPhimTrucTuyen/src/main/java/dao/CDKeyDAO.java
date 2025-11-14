/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import util.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.CDKey;


/**
 *
 * @author Nguyen Quoc Hung - CE190870
 */
public class CDKeyDAO {

    // Insert CDKey
    public void insertCDKey(String code, String status, String generatedBy) {
        String sql = "INSERT INTO CDKey(key_code, key_status, key_generatedBy, key_generatedTime) VALUES (?, ?, ?, GETDATE())";
        try (
                Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ps.setString(2, status);
            ps.setString(3, generatedBy);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lấy danh sách CDKey chưa dùng
    public List<CDKey> getUnusedKeys(int page, int pageSize) {
        List<CDKey> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT key_ID, key_code, key_status, key_generatedBy, key_generatedTime "
                   + "FROM CDKey WHERE LOWER(key_status) = 'unused' "
                   + "ORDER BY key_ID DESC "
                   + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CDKey key = new CDKey();
                    key.setKeyID(rs.getInt("key_ID"));
                    key.setKeyCode(rs.getString("key_code"));
                    key.setKeyStatus(rs.getString("key_status"));
                    key.setKeyGeneratedBy(rs.getString("key_generatedBy"));
                    key.setKeyGeneratedTime(rs.getTimestamp("key_generatedTime"));
                    list.add(key);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy danh sách key đã dùng + thông tin user (phân trang)
    public List<Map<String, Object>> getUsedKeysWithUser(int page, int pageSize) {
        List<Map<String, Object>> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        String sql = "SELECT k.key_ID, k.key_code, k.key_status, "
                   + "k.key_generatedBy, k.key_generatedTime, "
                   + "u.username AS usedBy, u.full_name AS usedFullName, "
                   + "a.activation_time AS usedAt "
                   + "FROM CDKey k "
                   + "JOIN CDKeyActivation a ON k.key_ID = a.key_ID "
                   + "JOIN [Users] u ON a.user_id = u.user_id "
                   + "WHERE LOWER(k.key_status) = 'used' "
                   + "ORDER BY a.activation_time DESC "
                   + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("keyID", rs.getInt("key_ID"));
                    row.put("keyCode", rs.getString("key_code"));
                    row.put("keyStatus", rs.getString("key_status"));
                    row.put("keyGeneratedBy", rs.getString("key_generatedBy"));
                    row.put("keyGeneratedTime", rs.getTimestamp("key_generatedTime"));
                    row.put("usedBy", rs.getString("usedBy"));
                    row.put("usedFullName", rs.getString("usedFullName"));
                    row.put("usedAt", rs.getTimestamp("usedAt"));
                    list.add(row);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đếm tổng key theo status 
    public int countKeysByStatus(String status) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM CDKey WHERE LOWER(key_status) = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status.toLowerCase());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}