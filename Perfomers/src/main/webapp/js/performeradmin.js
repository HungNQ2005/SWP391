document.addEventListener("DOMContentLoaded", function () {

    const editModal = document.getElementById('editModal');
    if (editModal) {
        editModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            console.log("👉 Button clicked:", button);
            console.log("👉 Data received:", button.dataset);
            document.getElementById("editId").value = button.dataset.id || "";
            document.getElementById("editName").value = button.dataset.name || "";
            document.getElementById("editDOB").value = button.dataset.dob || "";
            document.getElementById("editGender").value = button.dataset.gender || "";
            document.getElementById("editNation").value = button.dataset.nation || "";
            document.getElementById("editDesc").value = button.dataset.desc || "";
        });
    }
    // --- DELETE Modal ---
    const deleteModal = document.getElementById('deleteModal');
    if (deleteModal) {
        deleteModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            const performerId = button.getAttribute('data-id') || "";
            const performerName = button.getAttribute('data-name') || 'Unknown';
            const currentPage = button.getAttribute('data-page') || 1;
            const keyword = button.getAttribute('data-keyword') || '';

            document.getElementById('deleteId').value = performerId;
            document.getElementById('deletePage').value = currentPage;
            document.getElementById('deleteKeyword').value = keyword;
            document.getElementById('deleteMessage').innerHTML =
                    `Are you sure you want to delete <strong>${performerName}</strong>?`;
        });
    }

    // --- SEARCH FORM ---
    const searchForm = document.querySelector('.search-box');
    if (searchForm) {
        searchForm.addEventListener('submit', function (e) {
            const keyword = this.querySelector('input[name="keyword"]').value.trim();
            if (!keyword) {
                e.preventDefault();
                alert("Please enter a keyword before searching!");
            }
        });
    }

});