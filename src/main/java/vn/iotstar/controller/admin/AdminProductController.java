package vn.iotstar.controller.admin;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;

@MultipartConfig
@WebServlet(urlPatterns = { "/admin/products", "/admin/product/add", "/admin/product/insert",
        "/admin/product/edit", "/admin/product/update", "/admin/product/delete" })
public class AdminProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/admin/products")) {
            List<Product> list = productService.findAll();
            req.setAttribute("listproduct", list);
            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/add")) {
            List<Category> categories = cateService.findAll();
            req.setAttribute("listcate", categories);
            req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            List<Category> categories = cateService.findAll();
            req.setAttribute("product", product);
            req.setAttribute("listcate", categories);
            req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                productService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("/admin/product/insert")) {
            String productName = req.getParameter("productName");
            double price = parseDouble(req.getParameter("price"));
            String description = req.getParameter("description");
            int quantity = parseInt(req.getParameter("quantity"));
            int status = parseInt(req.getParameter("status"));
            int categoryId = parseInt(req.getParameter("categoryId"));
            String images = req.getParameter("images");

            Product product = new Product();
            product.setProductName(productName);
            product.setPrice(price);
            product.setDescription(description);
            product.setQuantity(quantity);
            product.setStatus(status);
            product.setCreatedDate(new Date());

            if (categoryId > 0) {
                Category category = cateService.findById(categoryId);
                product.setCategory(category);
            }

            String fname = uploadImage(req, "images1", images, null);
            product.setImages(fname);

            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } else if (url.contains("/admin/product/update")) {
            int productId = parseInt(req.getParameter("productId"));
            String productName = req.getParameter("productName");
            double price = parseDouble(req.getParameter("price"));
            String description = req.getParameter("description");
            int quantity = parseInt(req.getParameter("quantity"));
            int status = parseInt(req.getParameter("status"));
            int categoryId = parseInt(req.getParameter("categoryId"));
            String images = req.getParameter("images");

            Product product = productService.findById(productId);
            if (product == null) {
                product = new Product();
                product.setProductId(productId);
            }

            String oldImage = product.getImages();
            product.setProductName(productName);
            product.setPrice(price);
            product.setDescription(description);
            product.setQuantity(quantity);
            product.setStatus(status);

            if (categoryId > 0) {
                Category category = cateService.findById(categoryId);
                product.setCategory(category);
            }

            String fname = uploadImage(req, "images1", images, oldImage);
            product.setImages(fname);

            productService.update(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    private String uploadImage(HttpServletRequest req, String partName, String imageUrlInput, String oldFile) {
        String uploadPath = Constant.DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        try {
            Part part = req.getPart(partName);
            if (part != null && part.getSize() > 0) {
                if (oldFile != null && !oldFile.isEmpty() && !oldFile.startsWith("http")) {
                    deleteFile(uploadPath + File.separator + oldFile);
                }
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                int index = filename.lastIndexOf(".");
                String ext = (index > 0) ? filename.substring(index + 1) : "png";
                String fname = System.currentTimeMillis() + "." + ext;
                part.write(uploadPath + File.separator + fname);
                return fname;
            } else if (imageUrlInput != null && !imageUrlInput.isBlank()) {
                return imageUrlInput.trim();
            } else if (oldFile != null && !oldFile.isEmpty()) {
                return oldFile;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "product_default.png";
    }

    private void deleteFile(String filePath) {
        try {
            Path path = Paths.get(filePath);
            Files.deleteIfExists(path);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private int parseInt(String val) {
        try { return Integer.parseInt(val); } catch (Exception e) { return 0; }
    }

    private double parseDouble(String val) {
        try { return Double.parseDouble(val); } catch (Exception e) { return 0.0; }
    }
}
