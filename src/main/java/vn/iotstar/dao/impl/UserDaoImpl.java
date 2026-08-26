package vn.iotstar.dao.impl;

import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.UserDao;
import vn.iotstar.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDaoImpl implements UserDao {
    private final DBConnection dbConnection = new DBConnection();

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
    public void insert(User user) {
        String sql = "INSERT INTO " + DBConnection.userTableName()
                + "(email, username, fullname, password, avatar, roleid, phone, createdDate) "
                + "VALUES (?,?,?,?,?,?,?,?)";
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
        return user;
    }
}
