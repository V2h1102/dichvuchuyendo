package com.assignment.furniture_moving_service_swp391.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=Transport_V0;encrypt=false";
    private static final String USER = "sa";
    private static final String PASSWORD = "sa"; // thay bằng mật khẩu SQL Server của bạn

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("SQLServer JDBC Driver not found!", e);
        }
    }
}
