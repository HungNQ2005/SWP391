/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author PHUOCSANH
 */
public class DBContext {
    protected Connection conn;
    private final String DB_URL = "jdbc:sqlserver://localhost\\SQLEXPRESS02:1433;databaseName=NetFlopDB2;encrypt=true;trustServerCertificate=true";
    private final String DB_USER = "sa";
    private final String DB_PWD = "123456";

    public DBContext() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PWD);
            System.out.println("✅ Kết nối SQL Server thành công!");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("❌ Lỗi kết nối SQL Server: " + e.getMessage());
        }
    }

    // SELECT Query
    protected ResultSet executeSelectQuery(String sql, Object... params) throws SQLException {
        PreparedStatement ps = conn.prepareStatement(sql);
        setParams(ps, params);
        return ps.executeQuery();
    }

    // INSERT, UPDATE, DELETE
    protected int executeQuery(String sql, Object... params) throws SQLException {
        PreparedStatement ps = conn.prepareStatement(sql);
        setParams(ps, params);
        return ps.executeUpdate();
    }

    // Gán params cho PreparedStatement
    private void setParams(PreparedStatement ps, Object... params) throws SQLException {
        if (params != null) {
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
        }
    }

    // Close connection khi tắt project (optional)
    public void close() {
        try {
            if (conn != null && !conn.isClosed())
                conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }   
    }
}