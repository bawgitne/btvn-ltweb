package vn.iotstar.dao;

import vn.iotstar.model.User;

public interface UserDao {
    User get(String username);
    User getByEmail(String email);
    void insert(User user);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    void updateStatus(String email, int status);
    void updateCode(String email, String code);
    void updatePassword(String email, String newPassword);
}
