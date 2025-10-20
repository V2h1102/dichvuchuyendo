package com.assignment.furniture_moving_service_swp391.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final Logger logger = LoggerFactory.getLogger(DatabaseConnection.class);
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=MoveEasyDB;encrypt=true;trustServerCertificate=true;characterEncoding=UTF-8;useUnicode=true";
    private static final String USER = "sa";
    private static final String PASSWORD = "123";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(



                    "com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            logger.debug("Database connection established");
            return conn;
        } catch (ClassNotFoundException e) {
            logger.error("SQL Server JDBC Driver not found: {}", e.getMessage(), e);
            throw new SQLException("SQL Server JDBC Driver not found", e);
        } catch (SQLException e) {
            logger.error("Database connection error: {}", e.getMessage(), e);
            throw e;
        }
    }

    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                // ignore
            }
        }
    }

    public static void main(String[] args) {
        Connection connection = null;
        try {
            connection = getConnection();
            if (connection != null && !connection.isClosed()) {
                System.out.println("Database connection successful!");
            } else {
                System.out.println("Failed to establish a database connection.");
            }
        } catch (SQLException e) {
            System.out.println("Error while connecting to the database:");
            e.printStackTrace();
        } finally {
            closeConnection(connection);
        }
    }
}
