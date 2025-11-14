package filter;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import entity.User; 

@WebFilter(urlPatterns = {"/admin/*"})
public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        if (session == null) {
            // Chua Login
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // project hiện lưu object user vào session với tên "guest"
        Object userObj = session.getAttribute("guest");
        if (userObj == null) {
            // try alternative neu nhu sua ten luc sau
            userObj = session.getAttribute("user");
        }

        if (userObj == null || !(userObj instanceof User)) {
            // chưa login / session không hợp lệ
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) userObj;
        String level = user.getUser_level(); 

        if (level == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // all admin
        if ("admin".equalsIgnoreCase(level.trim())) {
            // cho qua
            chain.doFilter(request, response);
        } else {
            // đã login nhưng không có quyền
            // bạn có thể trả 403 hoặc redirect tới 1 trang 'no-permission.jsp'
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Không có quyền truy cập khu vực admin.");
        }
    }

    @Override
    public void destroy() {
        // Tu Huy
    }
}
