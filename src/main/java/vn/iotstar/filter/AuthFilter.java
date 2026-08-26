package vn.iotstar.filter;

import vn.iotstar.model.User;
import vn.iotstar.util.Constant;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*", "/manager/*"})
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        User user = session == null ? null : (User) session.getAttribute(Constant.SESSION_ACCOUNT);

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String uri = req.getRequestURI().substring(req.getContextPath().length());
        if (uri.startsWith("/admin/") && user.getRoleid() != 1) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Chỉ admin được truy cập trang này.");
            return;
        }
        if (uri.startsWith("/manager/") && user.getRoleid() != 2) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Chỉ manager được truy cập trang này.");
            return;
        }
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }
}
