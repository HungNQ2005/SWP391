/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.*;
import java.util.*;
import model.Ads;

/**
 *
 * @author PHUOCSANH
 */
public class AdsDAO extends DBContext {
    public List<Ads> getAllAds() {
        List<Ads> list = new ArrayList<>();
        String sql = "SELECT * FROM Ads ORDER BY ads_ID DESC";
        try ( ResultSet rs = executeSelectQuery(sql)) {
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

    public Ads getAdsById(int id) {
        String sql = "SELECT * FROM Ads WHERE ads_ID = ?";
        try ( ResultSet rs = executeSelectQuery(sql, new Object[]{id})) {
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addAds(Ads a) {
        String sql = "INSERT INTO Ads (ads_name, ads_image, ads_link, status, created_at) VALUES (?, ?, ?, ?, GETDATE())";
        try {
            executeQuery(sql, new Object[]{
                a.getAds_name(),
                a.getAds_image(),
                a.getAds_link(),
                a.getStatus()
            });
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateAds(Ads a) {
        String sql = "UPDATE Ads SET ads_name = ?, ads_image = ?, ads_link = ?, status = ?, updated_at = GETDATE() WHERE ads_ID = ?";
        try {
            executeQuery(sql, new Object[]{
                a.getAds_name(),
                a.getAds_image(),
                a.getAds_link(),
                a.getStatus(),
                a.getAds_ID()
            });
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteAds(int id) {
        String sql = "DELETE FROM Ads WHERE ads_ID = ?";
        try {
            executeQuery(sql, new Object[]{id});
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    

}
