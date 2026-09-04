package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.entity.Product;

import java.util.List;

public class ProductDaoImpl implements IProductDao {

    @Override
    public void insert(Product product) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(product);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Product product) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(product);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int id) throws Exception {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Product product = enma.find(Product.class, id);
            if (product != null) {
                enma.remove(product);
            } else {
                throw new Exception("Không tìm thấy Product với id: " + id);
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public Product findById(int id) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            return enma.find(Product.class, id);
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Product> findAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            TypedQuery<Product> query = enma.createQuery("SELECT p FROM Product p ORDER BY p.productId DESC", Product.class);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Product> findTop10Newest() {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            TypedQuery<Product> query = enma.createQuery("SELECT p FROM Product p ORDER BY p.productId DESC", Product.class);
            query.setMaxResults(10);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Product> findAll(int page, int pageSize) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            TypedQuery<Product> query = enma.createQuery("SELECT p FROM Product p ORDER BY p.productId DESC", Product.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public int count() {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            Query query = enma.createQuery("SELECT COUNT(p) FROM Product p");
            return ((Long) query.getSingleResult()).intValue();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Product> searchByName(String name) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            TypedQuery<Product> query = enma.createQuery("SELECT p FROM Product p WHERE p.productName LIKE :name ORDER BY p.productId DESC", Product.class);
            query.setParameter("name", "%" + name + "%");
            return query.getResultList();
        } finally {
            enma.close();
        }
    }
}
