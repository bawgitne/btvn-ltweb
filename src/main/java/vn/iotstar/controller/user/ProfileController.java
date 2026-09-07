package vn.iotstar.controller.user;

import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
@WebServlet(urlPatterns = {"/user/profile", "/profile", "/user/profile/update"})
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User sessionUser = session == null ? null : (User) session.getAttribute(Constant.SESSION_ACCOUNT);

        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Tải lại thông tin mới nhất từ DB thông qua JPA
        User currentUser = userService.findById(sessionUser.getId());
        if (currentUser == null) {
            currentUser = userService.get(sessionUser.getUserName());
        }

        if (currentUser != null) {
            req.setAttribute("user", currentUser);
            // Cập nhật lại session
            session.setAttribute(Constant.SESSION_ACCOUNT, currentUser);
        } else {
            req.setAttribute("user", sessionUser);
        }

        req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        User sessionUser = session == null ? null : (User) session.getAttribute(Constant.SESSION_ACCOUNT);

        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fullname = trim(req.getParameter("fullname"));
        String phone = trim(req.getParameter("phone"));

        // Lấy thông tin user hiện tại từ JPA
        User currentUser = userService.findById(sessionUser.getId());
        if (currentUser == null) {
            currentUser = userService.get(sessionUser.getUserName());
        }

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Cập nhật các trường thông tin cơ bản
        if (!fullname.isEmpty()) {
            currentUser.setFullName(fullname);
        }
        currentUser.setPhone(phone);

        // Xử lý upload file hình ảnh qua multipart/form-data
        String uploadPath = Constant.DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {
            Part part = req.getPart("images");
            if (part == null || part.getSize() == 0) {
                // Thử tìm theo tên field thay thế nếu cần
                part = req.getPart("avatar");
            }

            if (part != null && part.getSize() > 0) {
                String submittedFileName = part.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.isBlank()) {
                    String originalName = Paths.get(submittedFileName).getFileName().toString();
                    String ext = "";
                    int lastDot = originalName.lastIndexOf(".");
                    if (lastDot > 0) {
                        ext = originalName.substring(lastDot);
                    }

                    // Tên file lưu trên đĩa
                    String fname = System.currentTimeMillis() + "_" + sanitizeFileName(originalName);
                    String fileSavePath = uploadPath + File.separator + fname;

                    // Xóa ảnh cũ trên đĩa nếu có và không phải ảnh link external
                    String oldImage = currentUser.getAvatar();
                    if (oldImage != null && !oldImage.isBlank() && !oldImage.startsWith("http")) {
                        deleteOldFile(uploadPath + File.separator + oldImage);
                    }

                    // Ghi file mới
                    part.write(fileSavePath);
                    currentUser.setAvatar(fname);
                    currentUser.setImages(fname);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi xử lý file upload hình ảnh: " + e.getMessage());
        }

        // Lưu cập nhật vào cơ sở dữ liệu qua JPA
        try {
            userService.update(currentUser);
            // Cập nhật lại session account với dữ liệu mới
            session.setAttribute(Constant.SESSION_ACCOUNT, currentUser);
            req.setAttribute("msg", "Cập nhật thông tin profile thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi cập nhật profile vào DB: " + e.getMessage());
        }

        req.setAttribute("user", currentUser);
        req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
    }

    private void deleteOldFile(String filePath) {
        try {
            Path path = Paths.get(filePath);
            Files.deleteIfExists(path);
        } catch (Exception ignored) {}
    }

    private String sanitizeFileName(String name) {
        return name.replaceAll("[^a-zA-Z0-9._-]", "_");
    }

    private String trim(String s) {
        return s == null ? "" : s.trim();
    }
}
