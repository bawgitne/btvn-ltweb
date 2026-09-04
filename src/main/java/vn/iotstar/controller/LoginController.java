package vn.iotstar.controller;

import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(urlPatterns = "/login")
public class LoginController extends HttpServlet {
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

        if ("1".equals(req.getParameter("activated"))) {
            req.setAttribute("msg", "Tài khoản của bạn đã được kích hoạt thành công! Hãy đăng nhập.");
        } else if ("1".equals(req.getParameter("registered"))) {
            req.setAttribute("msg", "Đăng ký thành công! Vui lòng kiểm tra email để nhận mã OTP kích hoạt.");
        } else if ("1".equals(req.getParameter("resetSuccess"))) {
            req.setAttribute("msg", "Đặt lại mật khẩu thành công! Hãy đăng nhập với mật khẩu mới.");
        }

        String rememberedUsername = getRememberedUsername(req);
        if (rememberedUsername != null) {
            User user = service.get(rememberedUsername);
            if (user != null && user.getStatus() == 1) {
                session = req.getSession(true);
                session.setAttribute(Constant.SESSION_ACCOUNT, user);
                session.setAttribute(Constant.SESSION_USERNAME, user.getUserName());
                resp.sendRedirect(req.getContextPath() + "/waiting");
                return;
            }
        }

        req.getRequestDispatcher(Constant.Path.LOGIN).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = trim(req.getParameter("username"));
        String password = req.getParameter("password");
        boolean isRememberMe = "on".equals(req.getParameter("remember"));

        if (username.isEmpty() || password == null || password.isEmpty()) {
            req.setAttribute("alert", "Tài khoản hoặc mật khẩu không được rỗng");
            req.getRequestDispatcher(Constant.Path.LOGIN).forward(req, resp);
            return;
        }

        User user = service.login(username, password);
        if (user != null) {
            if (user.getStatus() == 0) {
                String verifyUrl = req.getContextPath() + "/verify-otp?email=" + URLEncoder.encode(user.getEmail(), StandardCharsets.UTF_8);
                req.setAttribute("alert", "Tài khoản chưa được kích hoạt! <a href='" + verifyUrl + "'>Kích hoạt ngay tại đây</a>.");
                req.getRequestDispatcher(Constant.Path.LOGIN).forward(req, resp);
                return;
            }

            HttpSession session = req.getSession(true);
            session.setAttribute(Constant.SESSION_ACCOUNT, user);
            session.setAttribute(Constant.SESSION_USERNAME, user.getUserName());
            if (isRememberMe) saveRememberMe(resp, username);
            resp.sendRedirect(req.getContextPath() + "/waiting");
        } else {
            req.setAttribute("alert", "Tài khoản hoặc mật khẩu không đúng");
            req.getRequestDispatcher(Constant.Path.LOGIN).forward(req, resp);
        }
    }

    private void saveRememberMe(HttpServletResponse response, String username) {
        Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, username);
        cookie.setHttpOnly(true);
        cookie.setMaxAge(30 * 60);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    private String getRememberedUsername(HttpServletRequest req) {
        Cookie[] cookies = req.getCookies();
        if (cookies == null) return null;
        for (Cookie cookie : cookies) {
            if (Constant.COOKIE_REMEMBER.equals(cookie.getName())) return cookie.getValue();
        }
        return null;
    }

    private String trim(String s) { return s == null ? "" : s.trim(); }
}
