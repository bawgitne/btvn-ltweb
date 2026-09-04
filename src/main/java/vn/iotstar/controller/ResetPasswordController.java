package vn.iotstar.controller;

import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = "/reset-password")
public class ResetPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        req.setAttribute("email", email);
        req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String code = req.getParameter("code");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        req.setAttribute("email", email);

        if (email == null || email.isBlank() || code == null || code.isBlank()
                || newPassword == null || newPassword.isBlank()) {
            req.setAttribute("alert", "Vui lòng nhập đầy đủ thông tin.");
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("alert", "Mật khẩu xác nhận không trùng khớp!");
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        boolean success = userService.resetPasswordWithOtp(email.trim(), code.trim(), newPassword);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/login?resetSuccess=1");
        } else {
            req.setAttribute("alert", "Mã OTP không đúng hoặc email không chính xác!");
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
        }
    }
}
