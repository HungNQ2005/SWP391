/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Series;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Chau Tan Cuong - CE190026
 */
public class MovieDAO {

    public List<Series> getAllSeries() {
        List<Series> list = new ArrayList<>();

        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();

            String sql = "SELECT series_id,"
                    + " title,"
                    + " poster_url"
                    + " FROM Series";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Series series = new Series();

                series.setSeriesID(rs.getInt("series_id"));
                series.setTitle(rs.getString("title"));
                series.setPosteUrl(rs.getString("poster_url"));
                list.add(series);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public static void main(String[] args) {
        MovieDAO movieDAO = new MovieDAO();
        System.out.println(movieDAO.getAllSeries());
    }
}
