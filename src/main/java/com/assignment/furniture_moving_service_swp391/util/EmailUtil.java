package com.assignment.furniture_moving_service_swp391.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class EmailUtil {

    // ✅ THAY THẾ BẰNG THÔNG TIN CỦA BẠN
    private static final String FROM_EMAIL = "thanhnthe160345@fpt.edu.vn"; // Email Gmail của bạn
    private static final String APP_PASSWORD = "eazv kwup rmpb qtla"; // 16 ký tự Mật khẩu ứng dụng bạn vừa tạo

    public static void sendEmail(String toEmail, String subject, String body) {
        // Cấu hình thuộc tính cho SMTP server của Gmail
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP Host
        props.put("mail.smtp.port", "587"); // TLS Port
        props.put("mail.smtp.auth", "true"); // Bật xác thực
        props.put("mail.smtp.starttls.enable", "true"); // Bật STARTTLS

        // Tạo Authenticator để xác thực
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        };

        // Lấy đối tượng Session
        Session session = Session.getInstance(props, auth);

        try {
            // Tạo một đối tượng MimeMessage
            MimeMessage mimeMessage = new MimeMessage(session);

            // Đặt người gửi
            mimeMessage.setFrom(new InternetAddress(FROM_EMAIL));

            // Đặt người nhận
            mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));

            // Đặt chủ đề
            mimeMessage.setSubject(subject);

            // Đặt nội dung email (cho phép HTML)
            mimeMessage.setContent(body, "text/html; charset=utf-8");

            // Gửi email
            Transport.send(mimeMessage);

            System.out.println("Email đã được gửi thành công đến " + toEmail);

        } catch (MessagingException e) {
            System.out.println("Gửi email thất bại!");
            e.printStackTrace();
        }
    }
}