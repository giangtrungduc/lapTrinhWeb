<%-- 
    Document   : check-in
    Created on : Apr 7, 2026, 12:22:51 AM
    Author     : DELL
--%>

<%@page import="com.mycompany.laptrinhweb.model.dto.CheckedInCustomerDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.CustomerDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    List<CustomerDTO> customerList = (List<CustomerDTO>) request.getAttribute("listCustomers");
    if (customerList == null)
        customerList = new ArrayList<>();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check-in Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #2c3e50;
                --accent-color: #3498db;
                --bg-color: #f4f7f6;
                --success-color: #27ae60;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-color);
                margin: 0;
                padding: 20px;
                color: #333;
            }

            .container {
                max-width: 1100px;
                margin: 0 auto;
                background: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            }

            .header-area {
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 2px solid #eee;
                margin-bottom: 25px;
                padding-bottom: 15px;
            }

            .header-area h2 {
                margin: 0;
                color: var(--primary-color);
                font-size: 22px;
            }

            .btn-home {
                text-decoration: none;
                background: var(--primary-color);
                color: white;
                padding: 10px 18px;
                border-radius: 6px;
                font-size: 14px;
                transition: 0.3s;
            }

            .btn-home:hover {
                background: #1a252f;
            }

            /* Search Form */
            .search-section {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 30px;
            }

            .search-section label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
            }

            .search-section input {
                padding: 10px;
                width: 300px;
                border: 1px solid #ddd;
                border-radius: 5px;
                margin-right: 10px;
            }

            .btn-search {
                background: var(--accent-color);
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-weight: 600;
            }

            /* Table Styles */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 30px;
            }

            th {
                background: #f1f3f5;
                text-align: left;
                padding: 12px;
                font-size: 13px;
                text-transform: uppercase;
                color: #666;
            }

            td {
                padding: 12px;
                border-bottom: 1px solid #eee;
                font-size: 14px;
            }

            tr:hover {
                background: #fafafa;
            }

            .btn-confirm {
                color: var(--accent-color);
                text-decoration: none;
                font-weight: 600;
            }

            .btn-checkin-act {
                background: var(--success-color);
                color: white;
                padding: 6px 12px;
                border-radius: 4px;
                text-decoration: none;
                font-size: 13px;
            }

            .empty-msg {
                color: #e74c3c;
                font-weight: 600;
                padding: 15px;
                background: #fdeaea;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header-area">
                <h2><i class="fa-solid fa-key"></i> Quy trình Check-in</h2>
                <a href="main.jsp" class="btn-home">
                    <i class="fa-solid fa-house"></i> Quay về Dashboard
                </a>
            </div>

            <div class="search-section">
                <form action="FilterCheckedInCustomerServlet" method="post">
                    <label>Tìm kiếm khách hàng đã đặt phòng</label>
                    <input name="customerInformation" placeholder="SĐT hoặc số CCCD..." required>
                    <button type="submit" class="btn-search">
                        <i class="fa-solid fa-magnifying-glass"></i> Tìm khách hàng
                    </button>
                </form>
            </div>

            <h3>1. Chọn khách hàng</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Họ tên</th>
                        <th>CCCD</th>
                        <th>SĐT</th>
                        <th>Địa chỉ</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (CustomerDTO cus : customerList) {%>
                    <tr>
                        <td><strong>#<%=cus.getMakh()%></strong></td>
                        <td><%=cus.getHoten()%></td>
                        <td><%=cus.getCccd()%></td>
                        <td><%=cus.getSdt()%></td>
                        <td><%=cus.getDiachi()%></td>
                        <td>
                            <a href="FilterCheckedInCustomerServlet?makh=<%= cus.getMakh()%>" 
                               class="btn-confirm" 
                               onclick="return confirm('Xác nhận chọn khách hàng này?')">
                                <i class="fa-solid fa-user-check"></i> Xác nhận
                            </a>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>

            <%
                List<CheckedInCustomerDTO> listBooking = (List<CheckedInCustomerDTO>) request.getAttribute("listBooking");
                if (listBooking != null && !listBooking.isEmpty()) {
            %>
            <hr style="border: 1px solid #eee; margin: 40px 0;">
            <h3 style="color: var(--success-color);">2. Danh sách phòng chờ nhận</h3>
            <table>
                <thead>
                    <tr>
                        <th>Mã Đặt</th>
                        <th>ID Phòng</th>
                        <th>Số Phòng</th>
                        <th>Ngày Đặt</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (CheckedInCustomerDTO booking : listBooking) {%>
                    <tr>
                        <td><strong><%= booking.getMaDatPhong()%></strong></td>
                        <td><%= booking.getMaPhong()%></td>
                        <td><strong>Phòng <%= booking.getSoPhong()%></strong></td>
                        <td><%= booking.getNgayDat()%></td>
                        <td>
                            <a href="CheckInServlet?maDP=<%= booking.getMaDatPhong()%>&maP=<%= booking.getMaPhong()%>" 
                               class="btn-checkin-act"
                               onclick="return confirm('Tiến hành giao chìa khóa cho phòng này?')">
                                <i class="fa-solid fa-door-open"></i> Nhận phòng
                            </a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <%
            } else if (request.getAttribute("listBooking") != null) {
            %>
            <div class="empty-msg">
                <i class="fa-solid fa-circle-exclamation"></i> Khách hàng này không có đơn đặt phòng nào đang chờ!
            </div>
            <% }%>
        </div>
    </body>
</html>