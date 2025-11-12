/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;

import java.io.IOException;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.User;
import jakarta.servlet.http.HttpSession;
import dao.EmailUtil;
import dao.MovieDAO;
import entity.Category;
import entity.Series;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;

/**
 *
 * @author Chau Tan Cuong - CE190026
 */
@WebServlet(name = "UserController", urlPatterns = {"/user"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024, // 10MB
        maxRequestSize = 50 * 1024 * 1024)        // 50MB
public class UserController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UserController.class.getName());

    MovieDAO movieDAO = new MovieDAO();
    MovieDAO categoryDAO = new MovieDAO();

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("sendLogin")) {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
        if (action.equals("sendSignUp")) {
            request.getRequestDispatcher("/SignUp.jsp").forward(request, response);
        }
        if ("sendFogortPassword".equals(action)) {
            request.getRequestDispatcher("/forgotpassword.jsp").forward(request, response);
        }
        if ("sendGmail".equals(action)) {
            request.getRequestDispatcher("/Gmail.jsp").forward(request, response);
        }
        if ("profile".equals(action)) {
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
        }
        if ("sendResetPassword".equals(action)) {
            String token = request.getParameter("token");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/resetpassword.jsp").forward(request, response);
        }
        if (action.equals("logout")) {
            HttpSession session = request.getSession(false);

            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("series?action=allOfSeries");
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        // unused variables removed
        if (action.equals("signUp")) {
            String username = request.getParameter("username").trim();
            String password = request.getParameter("password").trim();
            String passwordConfirm = request.getParameter("passwordConfirm").trim();
            String email = request.getParameter("email").trim();

            StringBuilder errorBuilder = new StringBuilder();
            UserDAO userDAO = new UserDAO();

            if (username.isEmpty()) {
                errorBuilder.append("Tên đăng nhập không được để trống.<br/>");
            } else if (!username.matches("^[A-Za-z0-9_]{4,20}$")) {
                errorBuilder.append("Tên người dùng chỉ gồm chữ, số hoặc dấu gạch dưới (4–20 ký tự).<br/>");
            } else if (userDAO.existsByUsername(username)) {
                errorBuilder.append("Tên người dùng đã tồn tại.<br/>");
            }

            // Validation email
            if (email.isEmpty()) {
                errorBuilder.append("Email không được để trống.<br/>");
            } else if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
                errorBuilder.append("Định dạng email không hợp lệ.<br/>");
            } else if (userDAO.existsByEmail(email)) {
                errorBuilder.append("Email đã tồn tại.<br/>");
            }

            if (password.isEmpty()) {
                errorBuilder.append("Mật khẩu không được để trống.<br/>");
            } else if (!password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{8,32}$")) {
                errorBuilder.append("Mật khẩu phải chứa ít nhất 1 chữ hoa, 1 chữ thường, 1 số và 1 ký tự đặc biệt, độ dài 8–32 ký tự.<br/>");
            }

            if (!password.equals(passwordConfirm)) {
                errorBuilder.append("Mẫu khẩu không khớp.<br/>");
            }
            if (errorBuilder.length() > 0) {
                request.setAttribute("errorMsg", errorBuilder.toString());
                request.getRequestDispatcher("SignUp.jsp").forward(request, response);
                return;
            }

            userDAO.signUp(username, email, password, "", "User", "uploads/default.jpg");

            // Gửi mail kích hoạt
            request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

        if (action.equals("login")) {
            try {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                StringBuilder errorBuilder = new StringBuilder();

                if (username.isEmpty()) {
                    errorBuilder.append("Tên đăng nhập không được để trống.<br/>");
                }
                if (password.isEmpty()) {
                    errorBuilder.append("Mật khẩu không được để trống.<br/>");
                }

                if (errorBuilder.length() > 0) {
                    request.setAttribute("errorMsg", errorBuilder.toString());
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }

                User user;
                UserDAO userDAO = new UserDAO();

                user = userDAO.login(username, password);

                if (user != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user_id", user.getUser_id());
                    session.setAttribute("username", user.getUsername());
                    session.setAttribute("guest", user);

                    List<Series> listSeries = movieDAO.getAllSeries();
                    List<Category> listCategory = categoryDAO.getAllCategories();

                    List<Series> allSeries = movieDAO.getAllSeries();
                    Set<String> listCountry = new LinkedHashSet<>();
                    for (Series s : allSeries) {
                        if (s.getCountry() != null && !s.getCountry().isEmpty()) {
                            listCountry.add(s.getCountry());
                        }
                    }

                    request.setAttribute("listCountry", listCountry);

                    request.setAttribute("listCategory", listCategory);
                    request.setAttribute("listSeries", listSeries);
           
                    String redirectURL = (String) session.getAttribute("redirectAfterLogin");
                    if (redirectURL != null) {
                        session.removeAttribute("redirectAfterLogin");
                        request.getRequestDispatcher(redirectURL).forward(request, response);
                    } else {
                        response.sendRedirect("series?action=allOfSeries");
                    }
                    return; // prevent further forwarding after redirect
                } else {
                    request.setAttribute("errorMsg", "Tên đăng nhập hoặc mật khẩu không đúng.<br/>");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return; // ensure we don't continue after a forward
                }

            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error in login", e);
                request.setAttribute("errorMsg", "Đã xảy ra lỗi hệ thống, vui lòng thử lại.<br/>");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        }

        if (action.equals("forgotPassword")) {
            String email = request.getParameter("email");
            UserDAO userDAO = new UserDAO();

            // Kiểm tra xem email có tồn tại không
            if (userDAO.findByEmail(email) != null) {
                // Tạo token và lưu vào DB
                String token = userDAO.saveResetToken(email);

                // Tạo link reset password (đưa token vào link)
                String resetLink = "http://localhost:8080/SWP391_WebXemPhimTrucTuyen_war_exploded/user?action=sendResetPassword&token=" + token;

                // --- Gửi email ---
                String subject = "Yêu cầu đặt lại mật khẩu";
                String content = "Xin chào,\n\n"
                        + "Bạn đã yêu cầu đặt lại mật khẩu cho tài khoản của mình.\n"
                        + "Vui lòng nhấp vào link sau để đặt lại mật khẩu:\n"
                        + resetLink + "\n\n"
                        + "Nếu bạn không yêu cầu điều này, vui lòng bỏ qua email này.";

                // Gọi class gửi email
                EmailUtil.sendEmail(email, subject, content);

                // Thông báo cho user kiểm tra email
                request.setAttribute("message", "Liên kết đặt lại mật khẩu đã được gửi tới email của bạn!");
                request.getRequestDispatcher("/forgotpassword.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Email không tồn tại!");
                request.getRequestDispatcher("/forgotpassword.jsp").forward(request, response);
            }
        }

        if ("resetPassword".equals(action)) {
            String token = request.getParameter("token");
            String newPassword = request.getParameter("password");

            UserDAO dao = new UserDAO();
            String email = dao.getEmailByToken(token);

            if (newPassword.isEmpty()) {
                request.setAttribute("error", "Mật khẩu không được để trống");
                request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
                return;
            }
            if (!newPassword.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{8,32}$")) {
                request.setAttribute("error", "Mật khẩu phải chứa ít nhất 1 chữ hoa, 1 chữ thường, 1 số và 1 ký tự đặc biệt, độ dài 8–32 ký tự");
                request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
                return;
            }
            if (email != null) {
                dao.updatePassword(email, newPassword);
                request.setAttribute("message", "Đặt lại mật khẩu thành công, vui lòng đăng nhập lại!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            } else {
                request.setAttribute("error", "Token không hợp lệ hoặc đã hết hạn!");
                request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
            }
        }
        if ("activate".equals(action)) {
            String token = request.getParameter("token");
            UserDAO dao = new UserDAO();
            boolean success = dao.activateUser(token);
            if (success) {
                request.setAttribute("message", "Kích hoạt thành công, mời đăng nhập!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Token không hợp lệ hoặc đã được dùng!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
        }

        if ("emailSignUp".equals(action)) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String passwordConfirm = request.getParameter("passwordConfirm");

            if (!password.equals(passwordConfirm)) {
                request.setAttribute("error", "Mật khẩu không khớp!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }

            // Hash password
            // Tạo token
            String token = java.util.UUID.randomUUID().toString();

            // Lưu vào DB (DAO cần có method signUpWithEmail)
            UserDAO userDAO = new UserDAO();
            userDAO.signUpWithEmail(username, email, password, token);

            // Gửi mail xác thực
            String activationLink = "http://localhost:8080/YourApp/user?action=active&token=" + token;
            EmailUtil.sendEmail(email, "Xác thực tài khoản",
                    "Chào " + username + ",\n\nVui lòng nhấp vào link để kích hoạt tài khoản: " + activationLink);

            // Thông báo cho user kiểm tra email
            request.setAttribute("message", "Vui lòng kiểm tra email để kích hoạt tài khoản!");
            request.getRequestDispatcher("checkEmail.jsp").forward(request, response);
        }

        if (action.equals("updateAvatar")) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("guest");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            Part filePart = request.getPart("avatar");
            String fileName = getFileName(filePart);

            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                boolean created = uploadDir.mkdirs();
                if (!created) {
                    LOGGER.log(Level.WARNING, "Could not create upload directory: {0}", uploadPath);
                }
            }

            String filePath = uploadPath + File.separator + fileName;

            try (InputStream inputStream = filePart.getInputStream(); FileOutputStream outputStream = new FileOutputStream(filePath)) {
                inputStream.transferTo(outputStream);
            } catch (IOException ioe) {
                LOGGER.log(Level.SEVERE, "Failed to save uploaded file", ioe);
                throw ioe;
            }

            String relativePath = "uploads/" + fileName;
            UserDAO dao = new UserDAO();
            dao.updateAvatar(user.getUser_id(), relativePath);

            user.setAvatar_url(relativePath);
            session.setAttribute("guest", user);

            response.sendRedirect("series?action=allOfSeries");
        }

        // 🧩 --- Xử lý update email ---
        if ("updateEmail".equals(action)) {
            HttpSession session = request.getSession();
            UserDAO userDAO = new UserDAO();

            User currentUser = (User) session.getAttribute("guest");

            if (currentUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String username = request.getParameter("username");
            String oldEmail = request.getParameter("oldEmail");
            String newEmail = request.getParameter("newEmail");

            if (oldEmail == null || newEmail == null
                    || oldEmail.trim().isEmpty() || newEmail.trim().isEmpty()) {
                request.setAttribute("error", "⚠️ Vui lòng nhập đầy đủ thông tin.");
                request.getRequestDispatcher("updateEmail.jsp").forward(request, response);
                return;
            }

            boolean success = userDAO.updateEmail(username, oldEmail, newEmail);

            if (success) {
                currentUser.setEmail(newEmail);
                session.setAttribute("guest", currentUser);
                request.setAttribute("success", "✅ Cập nhật email thành công!");
            } else {
                request.setAttribute("error", "❌ Email hiện tại không đúng hoặc email mới đã tồn tại!");
            }

            request.getRequestDispatcher("Gmail.jsp").forward(request, response);
            return;
        }

    }

    private String getFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
