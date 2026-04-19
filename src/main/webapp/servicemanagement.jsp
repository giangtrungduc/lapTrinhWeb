<%-- 
    Document   : servicemanagement
    Created on : Apr 7, 2026
    Author     : Admin
--%>

<%@page import="java.util.List"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.ServiceDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<ServiceDTO> list = (List<ServiceDTO>) request.getAttribute("listService");
    String keyword = (String) session.getAttribute("keyword");
    if (keyword == null) {
        keyword = "";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản Lý Dịch Vụ</title>

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f9;
                margin: 0;
                padding: 30px;
            }

            .container {
                max-width: 1000px;
                margin: auto;
            }

            h1 {
                color: #2c3e50;
                margin-bottom: 20px;
            }

            .form-box {
                background: #ffffff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                margin-bottom: 20px;
            }

            .form-row {
                margin-bottom: 12px;
            }

            label {
                display: inline-block;
                width: 110px;
                font-weight: bold;
                color: #333;
            }

            input[type="text"], textarea {
                width: 280px;
                padding: 8px 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
            }

            textarea {
                height: 80px;
                resize: vertical;
            }

            input[readonly] {
                background-color: #e9ecef;
                color: #555;
                cursor: not-allowed;
            }

            .button-group {
                margin-top: 15px;
                margin-bottom: 15px;
            }

            button, .btn-link {
                display: inline-block;
                padding: 8px 14px;
                margin-right: 8px;
                border: none;
                border-radius: 6px;
                background-color: #3498db;
                color: white;
                text-decoration: none;
                cursor: pointer;
                font-size: 14px;
            }

            button:hover, .btn-link:hover {
                background-color: #2980b9;
            }

            .btn-reset {
                background-color: #95a5a6;
            }

            .btn-reset:hover {
                background-color: #7f8c8d;
            }

            .btn-delete {
                background-color: #e74c3c;
            }

            .btn-delete:hover {
                background-color: #c0392b;
            }

            .search-box {
                margin-top: 10px;
            }

            .search-box input[type="text"] {
                width: 360px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            }

            table th, table td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }

            table th {
                background-color: #2c3e50;
                color: white;
            }

            table tr:hover {
                background-color: #f1f9ff;
            }

            .action-form {
                margin: 0;
                padding: 0;
                background: none;
                box-shadow: none;
            }
        </style>

        <script>
            function fillForm(maDV, tenDV, donGia, moTa) {
                document.getElementById("maDV").value = maDV;
                document.getElementById("tenDV").value = tenDV;
                document.getElementById("donGia").value = donGia;
                document.getElementById("moTa").value = moTa;
                window.scrollTo({top: 0, behavior: 'smooth'});
            }

            function resetForm() {
                document.getElementById("maDV").value = "";
                document.getElementById("tenDV").value = "";
                document.getElementById("donGia").value = "";
                document.getElementById("moTa").value = "";
            }
        </script>
    </head>

    <body>
        <div class="container">
            <h1>Quản Lý Dịch Vụ</h1>

            <div class="form-box">
                <form action="ServiceManagementServlet" method="post">
                    <div class="form-row">
                        <label>Mã dịch vụ:</label>
                        <input type="text" id="maDV" name="maDV" readonly>
                    </div>

                    <div class="form-row">
                        <label>Tên dịch vụ:</label>
                        <input type="text" id="tenDV" name="tenDV">
                    </div>

                    <div class="form-row">
                        <label>Giá dịch vụ:</label>
                        <input type="text" id="donGia" name="donGia">
                    </div>

                    <div class="form-row">
                        <label>Mô tả:</label>
                        <textarea id="moTa" name="moTa"></textarea>
                    </div>

                    <div class="button-group">
                        <button type="submit" name="action" value="add">Thêm</button>
                        <button type="submit" name="action" value="update">Sửa</button>
                        <a href="ServiceManagementServlet" class="btn-link btn-reset">Làm mới</a>
                        <button type="button" class="btn-reset" onclick="resetForm()">Xóa form</button>
                    </div>

                    <div class="search-box">
                        <label for="search">Tìm kiếm:</label>
                        <input type="text" id="search" name="search" value="<%= keyword%>" placeholder="Nhập tên dịch vụ, giá dịch vụ hoặc mô tả để tìm kiếm">
                        <button type="submit" name="action" value="search">Tìm kiếm</button>
                    </div>
                </form>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Mã DV</th>
                        <th>Tên dịch vụ</th>
                        <th>Giá dịch vụ</th>
                        <th>Mô tả</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (list != null && !list.isEmpty()) {
                            for (ServiceDTO dv : list) {
                    %>
                    <tr onclick="fillForm('<%= dv.getMaDV()%>', '<%= dv.getTenDV()%>', '<%= dv.getDonGia()%>', '<%= dv.getMoTa()%>')">
                        <td><%= dv.getMaDV()%></td>
                        <td><%= dv.getTenDV()%></td>
                        <td><%= dv.getDonGia()%></td>
                        <td><%= dv.getMoTa()%></td>
                        <td>
                            <form action="serviceManagementServlet" method="post" class="action-form">
                                <input type="hidden" name="maDV" value="<%= dv.getMaDV()%>">
                                <button type="submit" name="action" value="delete" class="btn-delete"
                                        onclick="return confirm('Bạn có chắc muốn xóa dịch vụ này không?');">
                                    Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5">Không có dữ liệu dịch vụ</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <p style="margin-top: 16px;">
                <a href="main.jsp">Quay lại trang main</a>
            </p>
        </div>
    </body>
</html>