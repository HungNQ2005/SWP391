document.addEventListener("DOMContentLoaded", function () {

    const editModal = document.getElementById('editModal');
    editModal.addEventListener('show.bs.modal', event => {
        const button = event.relatedTarget;
        const id = button.getAttribute('data-id');
        const name = button.getAttribute('data-name');
        const dob = button.getAttribute('data-dob');
        const gender = button.getAttribute('data-gender');
        const nation = button.getAttribute('data-nation');
        const desc = button.getAttribute('data-desc');
        const photo = button.getAttribute('data-photo'); 

        document.getElementById('editId').value = id;
        document.getElementById('editName').value = name;
        document.getElementById('editDOB').value = dob;
        document.getElementById('editGender').value = gender;
        document.getElementById('editNation').value = nation;
        document.getElementById('editDesc').value = desc.trim();
        document.getElementById('existingPhoto').value = photo; 
    });

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
