<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.BookingDTO"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.ServiceDTO"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.UsedServiceDTO"%>

<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<BookingDTO> dsDaNhanPhong = (List<BookingDTO>) request.getAttribute("dsDaNhanPhong");
    BookingDTO chiTiet = (BookingDTO) request.getAttribute("chiTiet");
    List<ServiceDTO> dsDichVu = (List<ServiceDTO>) request.getAttribute("dsDichVu");
    List<UsedServiceDTO> dsDichVuDaThem = (List<UsedServiceDTO>) request.getAttribute("dsDichVuDaThem");

    String message = (String) request.getAttribute("message");
    String customerInformation = request.getAttribute("customerInformation") != null
            ? request.getAttribute("customerInformation").toString()
            : "";

    Boolean showServicePanel = (Boolean) request.getAttribute("showServicePanel");
    if (showServicePanel == null) {
        showServicePanel = false;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý dịch vụ</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }

            table {
                border-collapse: collapse;
                width: 100%;
            }

            table, th, td {
                border: 1px solid #ccc;
            }

            th, td {
                padding: 8px;
                text-align: left;
            }

            .btn {
                padding: 6px 12px;
                cursor: pointer;
            }

            .btn-add {
                background-color: #4CAF50;
                color: white;
                border: none;
            }

            .btn-delete {
                background-color: #d9534f;
                color: white;
                border: none;
            }

            .btn-action {
                background-color: #0275d8;
                color: white;
                border: none;
            }

            .btn-close {
                background-color: #777;
                color: white;
                border: none;
            }

            .message {
                margin: 10px 0;
                padding: 10px;
                background: #f5f5f5;
                border: 1px solid #ddd;
            }

            .overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.45);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 999;
            }

            .modal {
                width: 92%;
                height: 85vh;
                background: white;
                border-radius: 8px;
                padding: 15px;
                box-shadow: 0 0 10px rgba(0,0,0,0.3);
                display: flex;
                flex-direction: column;
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 10px;
            }

            .modal-content {
                display: flex;
                gap: 15px;
                flex: 1;
                min-height: 0;
            }

            .panel {
                flex: 1;
                border: 1px solid #ccc;
                padding: 10px;
                overflow-y: auto;
                min-height: 0;
            }

            .quantity-box {
                display: none;
                margin-top: 8px;
                padding: 8px;
                border: 1px solid #ccc;
                background: #f9f9f9;
            }

            .quantity-box input[type="number"] {
                width: 80px;
            }

            .top-actions {
                margin-bottom: 15px;
            }
        </style>

        <script>
            function openQuantityBox(id) {
                var box = document.getElementById("quantity-box-" + id);
                if (box) {
                    box.style.display = "block";
                }
            }

            function closeQuantityBox(id) {
                var box = document.getElementById("quantity-box-" + id);
                if (box) {
                    box.style.display = "none";
                }
            }
        </script>
    </head>
    <body>
        <h1>Quản lý dịch vụ</h1>

        <p>Xin chào, <b><%= user %></b></p>
        <a href="main-employee.jsp">Quay về Dashboard</a>

        <hr>

        <form action="ServiceServlet" method="get" class="top-actions">
            <label>Tìm kiếm khách hàng đang nhận phòng</label>
            <input type="text" name="customerInformation" placeholder="SĐT hoặc CCCD..." value="<%= customerInformation %>">
            <button type="submit" name="action" value="search">Tìm khách hàng</button>
        </form>

        <% if (message != null) { %>
            <div class="message">
                <b><%= message %></b>
            </div>
        <% } %>

        <h2>Danh sách phiếu đặt đang nhận phòng</h2>

        <%
            if (dsDaNhanPhong == null || dsDaNhanPhong.isEmpty()) {
        %>
            <p>Không có phiếu đặt nào đang ở trạng thái đã nhận phòng.</p>
        <%
            } else {
        %>
            <table>
                <tr>
                    <th>Mã đặt phòng</th>
                    <th>Mã khách hàng</th>
                    <th>Mã phòng</th>
                    <th>Ngày nhận dự kiến</th>
                    <th>Ngày trả dự kiến</th>
                    <th>Thao tác</th>
                </tr>

                <%
                    for (BookingDTO dp : dsDaNhanPhong) {
                %>
                    <tr>
                        <td><%= dp.getMaDatPhong() %></td>
                        <td><%= dp.getMaKH() %></td>
                        <td><%= dp.getMaPhong() %></td>
                        <td><%= dp.getNgayNhanDuKien() %></td>
                        <td><%= dp.getNgayTraDuKien() %></td>
                        <td>
                            <form action="ServiceServlet" method="get">
                                <input type="hidden" name="action" value="view">
                                <input type="hidden" name="maDatPhong" value="<%= dp.getMaDatPhong() %>">
                                <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
                                <input class="btn btn-action" type="submit" value="Thao tác">
                            </form>
                        </td>
                    </tr>
                <%
                    }
                %>
            </table>
        <%
            }
        %>

        <% if (showServicePanel && chiTiet != null) { %>
            <div class="overlay">
                <div class="modal">
                    <div class="modal-header">
                        <div>
                            <h2>Quản lý dịch vụ cho phiếu đặt: <%= chiTiet.getMaDatPhong() %></h2>
                            <p>
                                <b>Khách hàng:</b> <%= chiTiet.getTenKhachHang() %> |
                                <b>Phòng:</b> <%= chiTiet.getSoPhong() %> |
                                <b>CCCD:</b> <%= chiTiet.getCccd() %> |
                                <b>SĐT:</b> <%= chiTiet.getSdtKhachHang() %>
                            </p>
                        </div>

                        <form action="ServiceServlet" method="get">
                            <input type="hidden" name="action" value="close">
                            <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
                            <input class="btn btn-close" type="submit" value="Đóng">
                        </form>
                    </div>

                    <div class="modal-content">
                        <!-- Panel trái -->
                        <div class="panel">
                            <h3>Danh sách dịch vụ khách sạn</h3>

                            <%
                                if (dsDichVu == null || dsDichVu.isEmpty()) {
                            %>
                                <p>Không có dịch vụ nào.</p>
                            <%
                                } else {
                            %>
                                <table>
                                    <tr>
                                        <th>Mã DV</th>
                                        <th>Tên dịch vụ</th>
                                        <th>Đơn giá</th>
                                        <th>Mô tả</th>
                                        <th>Thêm</th>
                                    </tr>

                                    <%
                                        for (ServiceDTO dv : dsDichVu) {
                                    %>
                                        <tr>
                                            <td><%= dv.getMaDV() %></td>
                                            <td><%= dv.getTenDV() %></td>
                                            <td><%= dv.getDonGia() %></td>
                                            <td><%= dv.getMoTa() %></td>
                                            <td>
                                                <button type="button" class="btn btn-add"
                                                        onclick="openQuantityBox('<%= dv.getMaDV() %>')">
                                                    Thêm
                                                </button>

                                                <div class="quantity-box" id="quantity-box-<%= dv.getMaDV() %>">
                                                    <form action="ServiceServlet" method="post">
                                                        <input type="hidden" name="action" value="add">
                                                        <input type="hidden" name="maDatPhong" value="<%= chiTiet.getMaDatPhong() %>">
                                                        <input type="hidden" name="maDV" value="<%= dv.getMaDV() %>">
                                                        <input type="hidden" name="customerInformation" value="<%= customerInformation %>">

                                                        <label>Số lượng:</label>
                                                        <input type="number" name="soLuong" min="1" required>

                                                        <input class="btn btn-add" type="submit" value="Xác nhận">
                                                        <button type="button" class="btn btn-close"
                                                                onclick="closeQuantityBox('<%= dv.getMaDV() %>')">
                                                            Hủy
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    <%
                                        }
                                    %>
                                </table>
                            <%
                                }
                            %>
                        </div>

                        <!-- Panel phải -->
                        <div class="panel">
                            <h3>Dịch vụ hiện có của phiếu đặt</h3>

                            <%
                                if (dsDichVuDaThem == null || dsDichVuDaThem.isEmpty()) {
                            %>
                                <p>Phiếu đặt này chưa có dịch vụ nào.</p>
                            <%
                                } else {
                            %>
                                <table>
                                    <tr>
                                        <th>Mã SDDV</th>
                                        <th>Tên dịch vụ</th>
                                        <th>Số lượng</th>
                                        <th>Đơn giá</th>
                                        <th>Thành tiền</th>
                                        <th>Thời gian sử dụng</th>
                                        <th>Xóa</th>
                                    </tr>

                                    <%
                                        for (UsedServiceDTO item : dsDichVuDaThem) {
                                    %>
                                        <tr>
                                            <td><%= item.getMaSDDV() %></td>
                                            <td><%= item.getTenDV() %></td>
                                            <td><%= item.getSoLuong() %></td>
                                            <td><%= item.getDonGia() %></td>
                                            <td><%= item.getThanhTien() %></td>
                                            <td><%= item.getThoiGianSuDung() %></td>
                                            <td>
                                                <form action="ServiceServlet" method="post"
                                                      onsubmit="return confirm('Bạn có chắc muốn xóa dịch vụ này?');">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="maDatPhong" value="<%= chiTiet.getMaDatPhong() %>">
                                                    <input type="hidden" name="maSDDV" value="<%= item.getMaSDDV() %>">
                                                    <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
                                                    <input class="btn btn-delete" type="submit" value="Xóa">
                                                </form>
                                            </td>
                                        </tr>
                                    <%
                                        }
                                    %>
                                </table>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        <% } %>
    </body>
</html>