<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.CustomerDTO"%>
<%
    List<CustomerDTO> customerList = (List<CustomerDTO>) request.getAttribute("customerList");
    if (customerList == null)
        customerList = new ArrayList<>();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>QUẢN LÝ KHÁCH HÀNG</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            :root {
                --primary-color: #4361ee;
                --secondary-color: #3f37c9;
                --success-color: #4cc9f0;
                --danger-color: #f72585;
                --bg-color: #f8f9fa;
                --text-color: #212529;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-color);
                color: var(--text-color);
                margin: 0;
                padding: 20px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            }

            h2 {
                color: var(--primary-color);
                font-weight: 600;
                margin-top: 0;
                border-bottom: 2px solid #eee;
                padding-bottom: 10px;
            }

            /* Toolbar chứa nút thêm và tìm kiếm */
            .toolbar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
                gap: 20px;
                flex-wrap: wrap;
            }

            .search-box {
                display: flex;
                gap: 10px;
                background: #eee;
                padding: 5px;
                border-radius: 8px;
            }

            input[name="filter"] {
                padding: 8px 15px;
                border: 1px solid #ddd;
                border-radius: 6px;
                min-width: 250px;
                outline: none;
            }

            /* Button Styles */
            button {
                cursor: pointer;
                border: none;
                border-radius: 6px;
                padding: 10px 20px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-add {
                background-color: var(--primary-color);
                color: white;
            }

            .btn-add:hover {
                background-color: var(--secondary-color);
            }

            .btn-search {
                background-color: #333;
                color: white;
            }

            /* Table Styles */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
                overflow: hidden;
                border-radius: 8px;
            }

            th {
                background-color: #f1f3f5;
                color: #495057;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 13px;
                letter-spacing: 0.5px;
            }

            th, td {
                padding: 15px;
                text-align: left;
                border-bottom: 1px solid #eee;
            }

            tr:hover {
                background-color: #fcfcfc;
            }

            .action-icons a {
                text-decoration: none;
                font-size: 18px;
                margin: 0 8px;
                transition: transform 0.2s;
                display: inline-block;
            }

            .action-icons a:hover {
                transform: scale(1.2);
            }

            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.4);
                backdrop-filter: blur(4px);
            }

            .modal-content {
                background-color: #fff;
                margin: 5% auto;
                padding: 30px;
                border-radius: 15px;
                width: 350px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.1);
                position: relative;
            }

            .modal-content h3 {
                margin-top: 0;
                color: var(--primary-color);
            }

            .close {
                position: absolute;
                right: 20px;
                top: 15px;
                font-size: 24px;
                color: #aaa;
                cursor: pointer;
            }

            .modal-content input {
                width: 100%;
                padding: 10px;
                margin: 10px 0 20px 0;
                border: 1px solid #ddd;
                border-radius: 6px;
                box-sizing: border-box;
            }

            .btn-save {
                background-color: var(--primary-color);
                color: white;
                width: 100%;
            }

            .badge-count {
                background: #e7f5ff;
                color: #228be6;
                padding: 4px 8px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: bold;
            }
            /* Ép tất cả các thẻ trong td về cùng font Inter */
            table td strong,
            table td code,
            table td small {
                font-family: 'Inter', sans-serif; /* Đảm bảo không bị dùng font mặc định của trình duyệt */
                font-size: 14px; /* Kích thước chuẩn cho nội dung bảng */
                font-style: normal;
                text-decoration: none;
            }

            /* Riêng thẻ code (CCCD) thường có màu nền và border, ta reset nó luôn nếu muốn giống các cột khác */
            table td code {
                background: none;
                padding: 0;
                color: var(--text-color);
            }

            /* Chỉnh lại độ đậm nhạt để nhìn cân đối */
            table td strong {
                font-weight: 600;
                color: var(--primary-color);
            }

            table td small {
                color: #666; /* Email cho nhạt hơn một chút nhưng vẫn cùng size */
            }

            /* Căn giữa nội dung các ô để nhìn ngay ngắn hơn */
            table td {
                vertical-align: middle;
            }
            .header-container {
                display: flex;
                justify-content: space-between; /* Đẩy 2 phần tử về 2 phía */
                align-items: center;           /* Căn giữa theo chiều dọc */
                margin-bottom: 20px;
                border-bottom: 2px solid #eee; /* Đường kẻ dưới tiêu đề */
                padding-bottom: 10px;
            }

            .header-container h2 {
                margin: 0;                     /* Bỏ margin mặc định để không bị lệch */
                border-bottom: none;           /* Bỏ border cũ của h2 nếu có */
            }

            .btn-home {
                text-decoration: none;
                background-color: #6c757d;      /* Màu xám trung tính */
                color: white;
                padding: 8px 15px;
                border-radius: 6px;
                font-size: 14px;
                font-weight: 600;
                transition: background 0.3s;
            }

            .btn-home:hover {
                background-color: #495057;
                color: #fff;
            }
        </style>
    </head>

    <script>
        function openEditModal(id, name, phone) {
            document.getElementById('editModal').style.display = "block";
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-name').value = name;
            document.getElementById('edit-phone').value = phone;
        }

        function closeModal() {
            document.getElementById('editModal').style.display = "none";
        }

        window.onclick = function (event) {
            let modal = document.getElementById('editModal');
            if (event.target == modal)
                closeModal();
        }

    </script>

    <body>
        <div class="container">
            <div class="header-container">
                <h2><i class="fa-solid fa-users-gear"></i> QUẢN LÝ KHÁCH HÀNG</h2>

                <a href="main.jsp" class="btn-home">
                    <i class="fa-solid fa-house"></i> Quay về trang chủ
                </a>
            </div>

            <div class="toolbar">
                <form action="add-customer-form.jsp" method="post">
                    <button type="submit" class="btn-add">
                        <i class="fa-solid fa-plus"></i> Thêm mới khách hàng
                    </button> 
                </form>

                <form action="FilterCustomerServlet" method="post" class="search-box">
                    <input name="filter" placeholder="Tìm theo tên, CCCD, SĐT..." value="<%= request.getParameter("filter") != null ? request.getParameter("filter") : ""%>"> 
                    <button type="submit" class="btn-search">
                        <i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm
                    </button>
                </form>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Họ tên</th>
                        <th>CCCD</th>
                        <th>SĐT</th>
                        <th>Email</th>
                        <th>Địa chỉ</th>
                        <th>Lượt đặt</th>
                        <th style="text-align: center;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (CustomerDTO cus : customerList) {%>
                    <tr>
                        <td><strong>#<%=cus.getMakh()%></strong></td>
                        <td><%=cus.getHoten()%></td>
                        <td><code><%=cus.getCccd()%></code></td>
                        <td><%=cus.getSdt()%></td>
                        <td><small><%=cus.getEmail()%></small></td>
                        <td><%=cus.getDiachi()%></td>
                        <td><span class="badge-count"><%=cus.getSolandat()%> lần</span></td>
                        <td class="action-icons" style="text-align: center;">
                            <a href="javascript:void(0)" title="Chỉnh sửa" 
                               onclick="openEditModal('<%=cus.getMakh()%>', '<%=cus.getHoten()%>', '<%=cus.getSdt()%>')">
                                <i class="fa-solid fa-pen-to-square" style="color: var(--primary-color);"></i>
                            </a>
                            <a href="DeleteCustomerServlet?id=<%=cus.getMakh()%>" title="Xóa"
                               onclick="return confirm('Bạn có chắc muốn xóa khách hàng này?')">
                                <i class="fa-solid fa-trash" style="color: var(--danger-color);"></i>
                            </a>
                        </td>            
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>

        <div id="editModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h3><i class="fa-solid fa-user-pen"></i> Chỉnh sửa</h3>
                <form action="UpdateCustomerServlet" method="POST">
                    <input type="hidden" id="edit-id" name="id">

                    <label>Họ tên:</label>
                    <input type="text" id="edit-name" name="name">

                    <label>Số điện thoại:</label>
                    <input type="text" id="edit-phone" name="phone">

                    <button type="submit" class="btn-save">Cập nhật thông tin</button>
                </form>
            </div>
        </div>
    </body>
</html>