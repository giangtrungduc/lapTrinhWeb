<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.EmployeeDTO"%>
<%
    List<EmployeeDTO> list = (List<EmployeeDTO>) request.getAttribute("nhanVienList");
    String message = (String) request.getAttribute("message");
    String keyword = (String) request.getAttribute("keyword");
    if (keyword == null) keyword = "";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lí nhân viên</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background: #f5f7fa;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            }
            h2 {
                margin-top: 0;
                color: #1f4e79;
            }
            .message {
                padding: 10px 14px;
                background: #e8f4ff;
                border: 1px solid #b6daff;
                color: #0b5394;
                border-radius: 6px;
                margin-bottom: 15px;
            }
            .form-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 12px 20px;
                margin-bottom: 15px;
            }
            .form-group {
                display: flex;
                flex-direction: column;
            }
            .form-group label {
                font-weight: bold;
                margin-bottom: 5px;
            }
            .form-group input {
                padding: 8px 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
            }
            .button-row {
                margin: 10px 0 20px;
            }
            .button-row button,
            .button-row a,
            .search-box button {
                padding: 8px 14px;
                border: none;
                border-radius: 6px;
                text-decoration: none;
                cursor: pointer;
                margin-right: 8px;
            }
            .btn-add { background: #198754; color: white; }
            .btn-update { background: #0d6efd; color: white; }
            .btn-reset { background: #6c757d; color: white; }
            .search-box {
                display: flex;
                gap: 10px;
                margin-bottom: 15px;
            }
            .search-box input {
                flex: 1;
                padding: 8px 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
            }
            .search-box button { background: #fd7e14; color: white; }
            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
            }
            table th, table td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            table th {
                background: #1f4e79;
                color: white;
            }
            tr:hover {
                background: #f1f7ff;
                cursor: pointer;
            }
            .action-inline {
                display: inline;
            }
            .small-btn {
                padding: 6px 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .btn-delete {
                background: #dc3545;
                color: #fff;
            }
            .note {
                color: #666;
                font-size: 13px;
                margin-top: 8px;
            }
        </style>
        <script>
            function fillForm(maNV, hoTen, sdt, chucVu, tenDangNhap, matKhauHash) {
                document.getElementById("maNV").value = maNV;
                document.getElementById("hoTen").value = hoTen;
                document.getElementById("sdt").value = sdt;
                document.getElementById("chucVu").value = chucVu;
                document.getElementById("tenDangNhap").value = tenDangNhap;
                document.getElementById("matKhauHash").value = matKhauHash;
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }

            function resetForm() {
                document.getElementById("maNV").value = "";
                document.getElementById("hoTen").value = "";
                document.getElementById("sdt").value = "";
                document.getElementById("chucVu").value = "";
                document.getElementById("tenDangNhap").value = "";
                document.getElementById("matKhauHash").value = "";
            }
        </script>
    </head>
    <body>
        <div class="container">
            <h2>QUẢN LÍ NHÂN VIÊN</h2>

            <% if (message != null && !message.trim().isEmpty()) { %>
                <div class="message"><%= message %></div>
            <% } %>

            <form action="EmployeeServlet" method="post">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Mã nhân viên</label>
                        <input type="text" id="maNV" name="maNV" readonly>
                    </div>
                    <div class="form-group">
                        <label>Họ tên</label>
                        <input type="text" id="hoTen" name="hoTen" required>
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="text" id="sdt" name="sdt">
                    </div>
                    <div class="form-group">
                        <label>Chức vụ</label>
                        <input type="text" id="chucVu" name="chucVu" required>
                    </div>
                    <div class="form-group">
                        <label>Tên đăng nhập</label>
                        <input type="text" id="tenDangNhap" name="tenDangNhap" required>
                    </div>
                    <div class="form-group">
                        <label>Mật khẩu</label>
                        <input type="text" id="matKhauHash" name="matKhauHash" required>
                    </div>
                </div>

                <div class="button-row">
                    <button type="submit" name="action" value="add" class="btn-add">Thêm</button>
                    <button type="submit" name="action" value="update" class="btn-update">Sửa</button>
                    <a href="EmployeeServlet" class="btn-reset">Làm mới</a>
                    <button type="button" onclick="resetForm()" class="btn-reset">Xóa form</button>
                </div>
                <div class="note">Bấm vào một dòng trong bảng để nạp dữ liệu lên form và sửa.</div>
            </form>

            <form action="EmployeeServlet" method="get" class="search-box">
                <input type="text" name="keyword" value="<%= keyword %>" placeholder="Nhập mã, họ tên, số điện thoại, chức vụ hoặc tên đăng nhập">
                <button type="submit" name="action" value="search">Tìm kiếm</button>
            </form>

            <table>
                <thead>
                    <tr>
                        <th>Mã NV</th>
                        <th>Họ tên</th>
                        <th>SĐT</th>
                        <th>Chức vụ</th>
                        <th>Tên đăng nhập</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (list != null && !list.isEmpty()) { %>
                        <% for (EmployeeDTO item : list) { %>
                            <tr onclick="fillForm('<%= item.getMaNV() %>', '<%= item.getHoTen() == null ? "" : item.getHoTen().replace("'", "\\'") %>', '<%= item.getSdt() == null ? "" : item.getSdt().replace("'", "\\'") %>', '<%= item.getChucVu() == null ? "" : item.getChucVu().replace("'", "\\'") %>', '<%= item.getTenDangNhap() == null ? "" : item.getTenDangNhap().replace("'", "\\'") %>', '<%= item.getMatKhauHash() == null ? "" : item.getMatKhauHash().replace("'", "\\'") %>')">
                                <td><%= item.getMaNV() %></td>
                                <td><%= item.getHoTen() %></td>
                                <td><%= item.getSdt() %></td>
                                <td><%= item.getChucVu() %></td>
                                <td><%= item.getTenDangNhap() %></td>
                                <td>
                                    <form action="EmployeeServlet" method="post" class="action-inline" onsubmit="return confirm('Bạn có chắc muốn xóa nhân viên này không?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="maNV" value="<%= item.getMaNV() %>">
                                        <button type="submit" class="small-btn btn-delete" onclick="event.stopPropagation();">Xóa</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr>
                            <td colspan="6">Không có dữ liệu nhân viên</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>

            <p style="margin-top: 16px;">
                <a href="main.jsp">Quay lại trang main</a>
            </p>
        </div>
    </body>
</html>
