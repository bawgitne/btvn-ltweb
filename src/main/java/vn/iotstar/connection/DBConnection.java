package vn.iotstar.connection;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {
    private static final DriverManagerDataSource dataSource;

    static {
        dataSource = new DriverManagerDataSource();
        // Cấu hình cứng tạm thời để dễ dàng chạy Spring Boot không lỗi
        // Sau này có thể refactor sang @Autowired DataSource của Spring
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://127.0.0.1:3306/ServletCRUDMVC?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8");
        dataSource.setUsername("root");
        dataSource.setPassword("bang123");
    }

    public Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
    
    // Giữ lại các hàm cũ đề phòng nơi khác gọi
    public static String getDbType() {
        return "mysql";
    }

    public static String userTableName() {
        return "`User`";
    }
}
