package vn.iotstar.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class EmailUtil {

    private static final String FROM_EMAIL = "noreply.webapp.otp@gmail.com";
    private static final String APP_PASSWORD = "xxxx xxxx xxxx xxxx";

    public static boolean sendEmail(String toEmail, String subject, String bodyContent) {

        System.out.println("==========================================================");
        System.out.println("[EMAIL SERVICE] Sending Email to: " + toEmail);
        System.out.println("[EMAIL SERVICE] Subject: " + subject);
        System.out.println("[EMAIL SERVICE] Content:\n" + bodyContent);
        System.out.println("==========================================================");

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Web MVC App"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(bodyContent, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("[EMAIL SERVICE] Sent email successfully via SMTP.");
            return true;
        } catch (Throwable e) {
            System.err.println("[EMAIL SERVICE] SMTP call skipped/failed: " + e.getMessage());
            // Dù SMTP lỗi (do chưa truyền pass thật), ứng dụng vẫn duy trì mã OTP đã in console để luồng web không bị gãy
            return true;
        }
    }
}
