package vn.iotstar.controller;

import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserService service = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute(Constant.SESSION_ACCOUNT) != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }
        req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = trim(req.getParameter("username"));
        String password = req.getParameter("password");
        String email = trim(req.getParameter("email"));
        String fullname = trim(req.getParameter("fullname"));
        String phone = trim(req.getParameter("phone"));

        if (username.isEmpty() || password == null || password.isEmpty()
                || email.isEmpty() || fullname.isEmpty()) {
            forwardWithAlert(req, resp, "Vui lòng nhập đầy đủ tài khoản, mật khẩu, email và họ tên.");
            return;
        }
        if (service.checkExistEmail(email)) {
            forwardWithAlert(req, resp, "Email đã tồn tại!");
            return;
        }
        if (service.checkExistUsername(username)) {
            forwardWithAlert(req, resp, "Tài khoản đã tồn tại!");
            return;
        }
        if (!phone.isEmpty() && service.checkExistPhone(phone)) {
            forwardWithAlert(req, resp, "Số điện thoại đã tồn tại!");
            return;
        }

        try {
            boolean isSuccess = service.register(username, password, email, fullname, phone);
            if (isSuccess) {
                // Chuyển hướng sang trang xác nhận OTP kích hoạt tài khoản
                resp.sendRedirect(req.getContextPath() + "/verify-otp?email=" + URLEncoder.encode(email, StandardCharsets.UTF_8));
            } else {
                forwardWithAlert(req, resp, "Không thể đăng ký tài khoản.");
            }
        } catch (RuntimeException e) {
            e.printStackTrace();
            forwardWithAlert(req, resp, "System error!");
        }
    }

    private void forwardWithAlert(HttpServletRequest req, HttpServletResponse resp, String msg)
            throws ServletException, IOException {
        req.setAttribute("alert", msg);
        req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
    }

    private String trim(String s) { return s == null ? "" : s.trim(); }
}
