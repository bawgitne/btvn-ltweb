package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Video;

public class Test {
    public static void main(String[] args) {
        System.out.println(">>> TESTING JPA ENTITY MANAGER CONNECTION <<<");
        try {
            EntityManager enma = JpaConfig.getEntityManager();
            EntityTransaction trans = enma.getTransaction();

            Category cate = new Category();
            cate.setCategoryname("Iphone " + System.currentTimeMillis());
            cate.setImages("abc.jpg");
            cate.setStatus(1);

            Video video = new Video();
            video.setVideoId("v_" + System.currentTimeMillis());
            video.setTitle("test video");
            video.setCategory(cate);

            trans.begin();
            enma.persist(cate);
            enma.persist(video);
            trans.commit();

            System.out.println("SUCCESS: Connected & Inserted Category & Video via JPA!");
            enma.close();
            System.exit(0);
        } catch (Exception e) {
            System.err.println("FAILED: JPA Connection failed:");
            e.printStackTrace();
            System.exit(1);
        }
    }
}
