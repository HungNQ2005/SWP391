<%-- 
    Document   : EditPerformer
    Created on : Oct 15, 2025, 1:23:31 PM
    Author     : Vo Thi Phi Yen - CE190428
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Performer</title>
    </head>
   <div class="modal fade" id="editModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header border-0">
                        <h5 class="modal-title">Chỉnh sửa Diễn viên</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editForm" method="post" action="${pageContext.request.contextPath}/PerformersAdmin">
                            <input type="hidden" name="action" value="edit" />
                            <input type="hidden" id="editId" name="id" />

                            <div class="mb-3">
                                <label class="form-label">Tên</label>
                                <input type="text" id="editName" name="name" class="form-control bg-dark text-white" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Ngày sinh</label>
                                <input type="date" id="editDOB" name="date_of_birth" class="form-control bg-dark text-white" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Giới tính</label>
                                <input type="text" id="editGender" name="gender" class="form-control bg-dark text-white" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Quốc tịch</label>
                                <input type="text" id="editNation" name="nationality" class="form-control bg-dark text-white" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Ảnh (URL)</label>
                                <input type="text" id="editPhoto" name="photo_url" class="form-control bg-dark text-white" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mô tả</label>
                                <textarea id="editDesc" name="description" class="form-control bg-dark text-white" rows="3"></textarea>
                            </div>

                            <button type="submit" class="btn btn-danger w-100">Lưu thay đổi</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

</html>
