package com.assignment.furniture_moving_service_swp391;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SqlServerConnection {

    public static void main(String[] args) {
        // --- THAY ĐỔI CÁC THÔNG SỐ NÀY ---
        String server = "localhost";
        String port = "1433";
        String database = "Test";
        String user = "sa"; // Ví dụ: sa
        String password = "sa";
        // ------------------------------------

        // Tạo chuỗi kết nối
        String connectionUrl = "jdbc:sqlserver://" + server + ":" + port + ";"
                + "databaseName=" + database + ";"
                + "user=" + user + ";"
                + "password=" + password + ";"
                + "encrypt=true;"
                + "trustServerCertificate=true;";

        Connection connection = null;

        try {
            // 1. Tải driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // 2. Thiết lập kết nối
            System.out.println("Đang kết nối tới cơ sở dữ liệu...");
            connection = DriverManager.getConnection(connectionUrl);
            System.out.println("Kết nối thành công!");

            // 3. Tạo và thực thi câu lệnh SQL
            String sqlQuery = "SELECT @@VERSION"; // Một câu lệnh SQL đơn giản để kiểm tra
            try (Statement stmt = connection.createStatement();
                 ResultSet rs = stmt.executeQuery(sqlQuery)) {

                // 4. Xử lý kết quả
                if (rs.next()) {
                    System.out.println("Phiên bản SQL Server: " + rs.getString(1));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Kết nối thất bại!");
            e.printStackTrace();
        } finally {
            // 5. Đóng kết nối
            if (connection != null) {
                try {
                    connection.close();
                    System.out.println("Đã đóng kết nối.");
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}