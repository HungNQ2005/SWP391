<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Account" %>

<%
    Account account = (Account) request.getAttribute("account");
    String error = (String) request.getAttribute("error");
    if (account == null) {
        account = new Account();
    }
%>

<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Update Account</title>
    <link rel="stylesheet" href="../css/update.css" />
  </head>

  <body>
    <div class="update-container">
      <h2>Update Account Information</h2>

      <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
      <% } %>

      <form id="updateForm" action="account.jsp" method="post" class="update-form">
        <input type="hidden" name="id" value="<%= account.getId() %>" />

        <!-- Email -->
        <div class="form-group">
          <label for="email">Email</label>
          <input
            type="email"
            id="email"
            name="email"
            value="<%= account.getEmail() %>"
            required
          />
        </div>

        <!-- Current Password -->
        <div class="form-group">
          <label for="password">Current Password</label>
          <input
            type="password"
            id="password"
            name="password"
            placeholder="Enter current password"
            required
          />
        </div>

        <!-- New Password -->
        <div class="form-group">
          <label for="new-password">New Password</label>
          <input
            type="password"
            id="new-password"
            name="new-password"
            placeholder="Enter new password"
            required
          />
          <small id="password-error" class="error-message"></small>
        </div>

        <!-- Confirm Password -->
        <div class="form-group">
          <label for="confirm-password">Confirm Password</label>
          <input
            type="password"
            id="confirm-password"
            name="confirm-password"
            placeholder="Confirm new password"
            required
          />
          <small id="confirm-error" class="error-message"></small>
        </div>

        <div class="button-group">
          <button type="submit" class="btn-save">Save</button>
          <a href="account?action=list" class="btn-cancel">Cancel</a>
        </div>
      </form>
    </div>

    <script>
      const form = document.getElementById("updateForm");
      const newPass = document.getElementById("new-password");
      const confirmPass = document.getElementById("confirm-password");
      const passError = document.getElementById("password-error");
      const confirmError = document.getElementById("confirm-error");

      form.addEventListener("submit", function (e) {
        let isValid = true;

        const password = newPass.value;
        const passwordRegex =
          /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$/;

        if (!passwordRegex.test(password)) {
          isValid = false;
          passError.innerHTML =
            "⚠️ Mật khẩu phải có ít nhất 8 ký tự, gồm chữ hoa, chữ thường, số và ký tự đặc biệt.";
          passError.style.display = "block";
          newPass.style.borderColor = "red";
        } else {
          passError.style.display = "none";
        }

        if (newPass.value !== confirmPass.value) {
          isValid = false;
          confirmError.textContent = "⚠️ Mật khẩu xác nhận không khớp.";
          confirmError.style.display = "block";
          confirmPass.style.borderColor = "red";
        } else {
          confirmError.style.display = "none";
        }

        if (!isValid) e.preventDefault();
      });
    </script>
  </body>
</html>
