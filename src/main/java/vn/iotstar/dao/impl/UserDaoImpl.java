package vn.iotstar.dao.impl;

import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.UserDao;
import vn.iotstar.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class UserDaoImpl implements UserDao {
    private final DBConnection dbConnection = new DBConnection();

    public UserDaoImpl() {
        ensureColumnsExist();
    }

    private void ensureColumnsExist() {
        try (Connection conn = dbConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            // Tự động bổ sung cột status và code nếu bảng DB chưa có
            try {
                stmt.executeUpdate("ALTER TABLE " + DBConnection.userTableName() + " ADD COLUMN status INT DEFAULT 0");
            } catch (Exception ignored) {}
            try {
                stmt.executeUpdate("ALTER TABLE " + DBConnection.userTableName() + " ADD COLUMN code VARCHAR(50) NULL");
            } catch (Exception ignored) {}
        } catch (Exception e) {
            // Tự bỏ qua nếu bảng chưa tạo hoặc đã tồn tại cột
        }
    }

    @Override
    public User get(String username) {
        String sql = "SELECT * FROM " + DBConnection.userTableName() + " WHERE username = ?";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public User getByEmail(String email) {
        String sql = "SELECT * FROM " + DBConnection.userTableName() + " WHERE email = ?";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void insert(User user) {
        String sql = "INSERT INTO " + DBConnection.userTableName()
                + "(email, username, fullname, password, avatar, roleid, phone, createdDate, status, code) "
                + "VALUES (?,?,?,?,?,?,?,?,?,?)";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getUserName());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPassWord());
            ps.setString(5, user.getAvatar());
            ps.setInt(6, user.getRoleid());
            ps.setString(7, user.getPhone());
            ps.setDate(8, user.getCreatedDate());
            ps.setInt(9, user.getStatus());
            ps.setString(10, user.getCode());
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("Không thể thêm user", e);
        }
    }

    @Override
    public boolean checkExistEmail(String email) {
        return exists("email", email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return exists("username", username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        if (phone == null || phone.isBlank()) return false;
        return exists("phone", phone);
    }

    @Override
    public void updateStatus(String email, int status) {
        String sql = "UPDATE " + DBConnection.userTableName() + " SET status = ? WHERE email = ?";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateCode(String email, String code) {
        String sql = "UPDATE " + DBConnection.userTableName() + " SET code = ? WHERE email = ?";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updatePassword(String email, String newPassword) {
        String sql = "UPDATE " + DBConnection.userTableName() + " SET password = ?, code = NULL WHERE email = ?";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private boolean exists(String column, String value) {
        String sql = "SELECT 1 FROM " + DBConnection.userTableName() + " WHERE " + column + " = ?";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, value);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private User mapUser(ResultSet rs) throws Exception {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setEmail(rs.getString("email"));
        user.setUserName(rs.getString("username"));
        user.setFullName(rs.getString("fullname"));
        user.setPassWord(rs.getString("password"));
        user.setAvatar(rs.getString("avatar"));
        user.setRoleid(rs.getInt("roleid"));
        user.setPhone(rs.getString("phone"));
        user.setCreatedDate(rs.getDate("createdDate"));
        try {
            user.setStatus(rs.getInt("status"));
        } catch (Exception e) {
            user.setStatus(1); // default active if column missing
        }
        try {
            user.setCode(rs.getString("code"));
        } catch (Exception e) {
            user.setCode(null);
        }
        return user;
    }
}
