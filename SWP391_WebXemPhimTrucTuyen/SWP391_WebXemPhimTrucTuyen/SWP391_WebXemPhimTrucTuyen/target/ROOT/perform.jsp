<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Performer Management</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <style>
      .performer-table-wrapper {
        max-width: 900px;
        margin: 0 auto;
      }

      .performer-table th,
      .performer-table td {
        padding: 0.4rem;
        font-size: 0.9rem;
      }

      .performer-table .performer-img {
        width: 45px;
        height: 45px;
      }

      .performer-table td:nth-child(6) {
        max-width: 250px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }

      @media (max-width: 576px) {
        .performer-table-wrapper {
          max-width: 100%;
          padding: 0 0.5rem;
        }

        .performer-table th,
        .performer-table td {
          font-size: 0.75rem;
          padding: 0.3rem;
        }

        .performer-table .performer-img {
          width: 35px;
          height: 35px;
        }

        .performer-table td:nth-child(6) {
          max-width: 150px;
        }
      }
    </style>
  </head>
  <body class="bg-dark text-white">
    <div class="table-responsive performer-table-wrapper">
      <table
        class="table table-dark table-hover table-sm align-middle text-center performer-table"
      >
        <thead>
          <tr>
            <th>ID</th>
            <th>Photo</th>
            <th>Name</th>
            <th>DOB</th>
            <th>Country</th>
            <th>Biography</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1</td>
            <td>
              <img
                src="https://images.wallpapersden.com/image/download/tom-holland-as-spiderman-in-far-from-home_65663_6412x4275.jpg"
                alt="photo"
                class="rounded performer-img"
              />
            </td>
            <td>Tom Holland</td>
            <td>1996-10-01</td>
            <td>England</td>
            <td>
              Thomas Stanley Holland (sinh ngày 1 tháng 6 năm 1996) là một nam
              diễn viên, vũ công người Anh.
            </td>
            <td>
              <button class="btn btn-sm btn-warning me-1">Edit</button>
              <button class="btn btn-sm btn-danger">Delete</button>
            </td>
          </tr>
          <tr>
            <td>2</td>
            <td>
              <img
                src="https://images.wallpapersden.com/image/download/tom-holland-as-spiderman-in-far-from-home_65663_6412x4275.jpg"
                alt="photo"
                class="rounded performer-img"
              />
            </td>
            <td>Tom Holland</td>
            <td>1996-10-01</td>
            <td>England</td>
            <td>
              Thomas Stanley Holland (sinh ngày 1 tháng 6 năm 1996) là một nam
              diễn viên, vũ công người Anh.
            </td>
            <td>
              <button class="btn btn-sm btn-warning me-1">Edit</button>
              <button class="btn btn-sm btn-danger">Delete</button>
            </td>
          </tr>
          <tr>
            <td>3</td>
            <td>
              <img
                src="https://images.wallpapersden.com/image/download/tom-holland-as-spiderman-in-far-from-home_65663_6412x4275.jpg"
                alt="photo"
                class="rounded performer-img"
              />
            </td>
            <td>Tom Holland</td>
            <td>1996-10-01</td>
            <td>England</td>
            <td>
              Thomas Stanley Holland (sinh ngày 1 tháng 6 năm 1996) là một nam
              diễn viên, vũ công người Anh.
            </td>
            <td>
              <button class="btn btn-sm btn-warning me-1">Edit</button>
              <button class="btn btn-sm btn-danger">Delete</button>
            </td>
          </tr>
          <tr>
            <td>4</td>
            <td>
              <img
                src="https://images.wallpapersden.com/image/download/tom-holland-as-spiderman-in-far-from-home_65663_6412x4275.jpg"
                alt="photo"
                class="rounded performer-img"
              />
            </td>
            <td>Tom Holland</td>
            <td>1996-10-01</td>
            <td>England</td>
            <td>
              Thomas Stanley Holland (sinh ngày 1 tháng 6 năm 1996) là một nam
              diễn viên, vũ công người Anh.
            </td>
            <td>
              <button class="btn btn-sm btn-warning me-1">Edit</button>
              <button class="btn btn-sm btn-danger">Delete</button>
            </td>
          </tr>
          <tr>
            <td>5</td>
            <td>
              <img
                src="https://images.wallpapersden.com/image/download/tom-holland-as-spiderman-in-far-from-home_65663_6412x4275.jpg"
                alt="photo"
                class="rounded performer-img"
              />
            </td>
            <td>Tom Holland</td>
            <td>1996-10-01</td>
            <td>England</td>
            <td>
              Thomas Stanley Holland (sinh ngày 1 tháng 6 năm 1996) là một nam
              diễn viên, vũ công người Anh.
            </td>
            <td>
              <button class="btn btn-sm btn-warning me-1">Edit</button>
              <button class="btn btn-sm btn-danger">Delete</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
