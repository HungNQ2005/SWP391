// ======== VALIDATION UTILS ========
            // Hàm hiển thị lỗi
            function showError(input, message) {
                const parent = input.parentElement;
                const feedback = parent.querySelector('.invalid-feedback');
                input.classList.add('is-invalid');
                input.classList.remove('is-valid');
                if (feedback) {
                    feedback.innerText = message; // Cập nhật nội dung lỗi động
                }
            }

            // Hàm báo thành công
            function showSuccess(input) {
                input.classList.remove('is-invalid');
                input.classList.add('is-valid');
            }

            // Kiểm tra Email bằng Regex
            function checkEmail(input) {
                const re = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
                if (re.test(input.value.trim())) {
                    showSuccess(input);
                    return true;
                } else {
                    showError(input, 'Email không đúng định dạng (vd: abc@gmail.com)');
                    return false;
                }
            }

            // Kiểm tra Username (không dấu cách, không ký tự đặc biệt, 3-20 ký tự)
            function checkUsername(input) {
                const re = /^[a-zA-Z0-9_]{3,20}$/;
                if (re.test(input.value.trim())) {
                    showSuccess(input);
                    return true;
                } else {
                    showError(input, 'Username 3-20 ký tự, không chứa dấu cách/ký tự đặc biệt.');
                    return false;
                }
            }

            // Kiểm tra độ dài (cho Password, Fullname)
            function checkLength(input, min, max, fieldName) {
                if (input.value.trim().length < min) {
                    showError(input, `${fieldName} phải có ít nhất ${min} ký tự.`);
                    return false;
                } else if (input.value.trim().length > max) {
                    showError(input, `${fieldName} không được quá ${max} ký tự.`);
                    return false;
                } else {
                    showSuccess(input);
                    return true;
                }
            }

            // ======== ADD FORM VALIDATION ========
            const addForm = document.getElementById('addForm');

            addForm.addEventListener('submit', function (e) {
                // Ngăn form gửi đi ngay lập tức
                e.preventDefault();

                const username = document.getElementById('addUserName');
                const email = document.getElementById('addEmail');
                const password = document.getElementById('addPassword'); // Lưu ý: bạn cần thêm id="addPassword" vào input password
                const fullname = document.getElementById('addFullName');

                let isValid = true;

                if (!checkUsername(username))
                    isValid = false;
                if (!checkEmail(email))
                    isValid = false;
                if (!checkLength(password, 6, 50, 'Password'))
                    isValid = false;
                if (!checkLength(fullname, 1, 100, 'Full Name'))
                    isValid = false;

                // Nếu tất cả hợp lệ thì mới submit
                if (isValid) {
                    addForm.submit();
                }
            });

            // ======== EDIT FORM VALIDATION & SUBMIT ========

            // Populate Modal Logic (Giữ nguyên code cũ của bạn)
            document.addEventListener("click", function (e) {
                if (e.target.classList.contains("editBtn")) {
                    const btn = e.target;
                    // Reset validation state khi mở modal
                    document.querySelectorAll('.is-invalid, .is-valid').forEach(el => {
                        el.classList.remove('is-invalid', 'is-valid');
                    });

                    document.getElementById("editId").value = btn.getAttribute("data-id");
                    document.getElementById("editUserName").value = btn.getAttribute("data-username");
                    document.getElementById("editEmail").value = btn.getAttribute("data-email");
                    document.getElementById("editRole").value = btn.getAttribute("data-role");

                    new bootstrap.Modal(document.getElementById("editModal")).show();
                }
            });

            // Handle Edit Submit
            document.getElementById("editForm").addEventListener("submit", function (e) {
                e.preventDefault();

                const username = document.getElementById('editUserName');
                const email = document.getElementById('editEmail');

                let isValid = true;

                // Validate dữ liệu form Edit
                if (!checkUsername(username))
                    isValid = false;
                if (!checkEmail(email))
                    isValid = false;

                // Nếu dữ liệu không hợp lệ, dừng lại, không gọi fetch
                if (!isValid)
                    return;

                // Nếu hợp lệ, tiến hành gọi API
                const data = new URLSearchParams();
                data.append("action", "update");
                data.append("user_id", document.getElementById("editId").value);
                data.append("username", username.value.trim());
                data.append("email", email.value.trim());
                data.append("user_level", document.getElementById("editRole").value);

                fetch("account", {
                    method: "POST",
                    body: data
                }).then(() => location.reload());
            });

            // ======== DELETE FUNCTION (Giữ nguyên code cũ) ========
            let userToDelete = null;
            document.addEventListener("click", function (e) {
                if (e.target.classList.contains("deleteBtn")) {
                    userToDelete = e.target.getAttribute("data-id");
                    // Cần đảm bảo trang có Delete Modal (code JSP bạn gửi thiếu phần HTML DeleteModal, 
                    // nhưng nếu code gốc có rồi thì OK)
                    const modalElement = document.getElementById("deleteModal");
                    if (modalElement)
                        new bootstrap.Modal(modalElement).show();
                }
            });

            const confirmDeleteBtn = document.getElementById("confirmDelete");
            if (confirmDeleteBtn) {
                confirmDeleteBtn.addEventListener("click", function () {
                    if (userToDelete) {
                        window.location.href = "account?action=delete&id=" + userToDelete;
                    }
                });
            }