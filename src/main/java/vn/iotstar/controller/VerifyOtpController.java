package vn.iotstar.controller;

import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = "/verify-otp")
public class VerifyOtpController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        req.setAttribute("email", email);
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String code = req.getParameter("code");

        if (email == null || email.isBlank() || code == null || code.isBlank()) {
            req.setAttribute("alert", "Vui lòng nhập đầy đủ Email và Mã OTP.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        boolean isVerified = userService.verifyOtp(email.trim(), code.trim());
        if (isVerified) {
            resp.sendRedirect(req.getContextPath() + "/login?activated=1");
        } else {
            req.setAttribute("alert", "Mã OTP không chính xác hoặc đã hết hạn!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}
