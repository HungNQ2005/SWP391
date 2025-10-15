/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package utils;

import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Vo Thi Phi Yen - CE190428
 */
public class DBContext {
     private static final String URL
            = "jdbc:sqlserver://localhost:1433;databaseName=NetFlopDB;encrypt=true;trustServerCertificate=true"; // Nhớ chỉnh database cho đúng
    private static final String USER = "sa";
    private static final String PASSWORD = "12345678";// điền pass của bạn 

    public static java.sql.Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//Tùy chọn JDBC 4+ 
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("SQL Server JDBC Driver not found", e);
        }
    }
}

