package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.UserDao;
import vn.iotstar.entity.User;

import java.util.List;

public class UserDaoImpl implements UserDao {

    @Override
    public User findById(int id) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            return enma.find(User.class, id);
        } finally {
            enma.close();
        }
    }

    @Override
    public User get(String username) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            TypedQuery<User> query = enma.createNamedQuery("User.findByUsername", User.class);
            query.setParameter("username", username);
            List<User> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            enma.close();
        }
    }

    @Override
    public User getByEmail(String email) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            TypedQuery<User> query = enma.createNamedQuery("User.findByEmail", User.class);
            query.setParameter("email", email);
            List<User> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            enma.close();
        }
    }

    @Override
    public void insert(User user) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw new RuntimeException("Không thể thêm user với JPA", e);
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(User user) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw new RuntimeException("Không thể cập nhật user với JPA", e);
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean checkExistEmail(String email) {
        if (email == null || email.isBlank()) return false;
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT count(u) FROM User u WHERE u.email = :email";
            TypedQuery<Long> query = enma.createQuery(jpql, Long.class);
            query.setParameter("email", email);
            return query.getSingleResult() > 0;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean checkExistUsername(String username) {
        if (username == null || username.isBlank()) return false;
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT count(u) FROM User u WHERE u.userName = :username";
            TypedQuery<Long> query = enma.createQuery(jpql, Long.class);
            query.setParameter("username", username);
            return query.getSingleResult() > 0;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean checkExistPhone(String phone) {
        if (phone == null || phone.isBlank()) return false;
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT count(u) FROM User u WHERE u.phone = :phone";
            TypedQuery<Long> query = enma.createQuery(jpql, Long.class);
            query.setParameter("phone", phone);
            return query.getSingleResult() > 0;
        } finally {
            enma.close();
        }
    }

    @Override
    public void updateStatus(String email, int status) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            User user = getByEmail(email);
            if (user != null) {
                user.setStatus(status);
                enma.merge(user);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            enma.close();
        }
    }

    @Override
    public void updateCode(String email, String code) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            User user = getByEmail(email);
            if (user != null) {
                user.setCode(code);
                enma.merge(user);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            enma.close();
        }
    }

    @Override
    public void updatePassword(String email, String newPassword) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            User user = getByEmail(email);
            if (user != null) {
                user.setPassWord(newPassword);
                user.setCode(null);
                enma.merge(user);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            enma.close();
        }
    }
}
