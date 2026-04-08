<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Kiểm tra session để đảm bảo nhân viên đã đăng nhập
    String user = (String) session.getAttribute("user"); 
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Hệ thống Quản lý Khách sạn - Dashboard</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #2c3e50;
                --secondary-color: #34495e;
                --accent-color: #3498db;
                --text-light: #ecf0f1;
                --bg-color: #f4f7f6;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                background-color: var(--bg-color);
                display: flex;
            }

            /* Sidebar bên trái */
            .sidebar {
                width: 260px;
                height: 100vh;
                background-color: var(--primary-color);
                color: var(--text-light);
                position: fixed;
                padding-top: 20px;
            }

            .sidebar h2 {
                text-align: center;
                font-size: 20px;
                border-bottom: 1px solid var(--secondary-color);
                padding-bottom: 20px;
                margin-bottom: 20px;
            }

            .sidebar a {
                display: block;
                padding: 15px 25px;
                color: var(--text-light);
                text-decoration: none;
                transition: 0.3s;
                font-size: 15px;
            }

            .sidebar a:hover {
                background-color: var(--accent-color);
                padding-left: 35px;
            }

            .sidebar i {
                margin-right: 10px;
                width: 20px;
            }

            /* Nội dung chính bên phải */
            .main-content {
                margin-left: 260px;
                padding: 30px;
                width: calc(100% - 260px);
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: white;
                padding: 15px 30px;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            .user-info {
                font-weight: bold;
                color: var(--primary-color);
            }

            /* Grid các chức năng */
            .grid-container {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 25px;
                margin-top: 30px;
            }

            .card {
                background: white;
                padding: 30px;
                border-radius: 12px;
                text-align: center;
                box-shadow: 0 4px 6px rgba(0,0,0,0.05);
                transition: transform 0.3s, box-shadow 0.3s;
                cursor: pointer;
                text-decoration: none;
                color: #333;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 15px rgba(0,0,0,0.1);
            }

            .card i {
                font-size: 40px;
                color: var(--accent-color);
                margin-bottom: 15px;
            }

            .card h3 {
                margin: 10px 0;
                font-size: 18px;
            }
            .card p {
                color: #777;
                font-size: 14px;
            }

            .btn-logout {
                background: #e74c3c;
                color: white;
                padding: 8px 15px;
                border-radius: 5px;
                text-decoration: none;
            }
        </style>
    </head>
    <body>

        <div class="sidebar">
            <h2>HOTEL MANAGER</h2>
            <a href="main.jsp"><i class="fa-solid fa-gauge"> </i> Dashboard</a>
            <a href="CustomerServlet"><i class="fa-solid fa-users"></i> Khách hàng</a>
            <a href="RoomServlet"><i class="fa-solid fa-door-open"></i> Phòng & Loại phòng</a>
            <a href="BookingServlet"><i class="fa-solid fa-calendar-check"></i> Đặt phòng</a>
            <a href="serviceManagementServlet"><i class="fa-solid fa-bell-concierge"></i> Dịch vụ</a>
            <a href="InvoiceServlet"><i class="fa-solid fa-file-invoice-dollar"></i> Hóa đơn</a>
            <a href="ReportServlet"><i class="fa-solid fa-chart-line"></i> Thống kê</a>
            <a href="EmployeeServlet"><i class="fa-solid fa-id-badge"></i> Nhân viên</a>
        </div>

        <div class="main-content">
            <div class="header">
                <div class="user-info">
                    Xin chào, <%=user%><i class="fa-solid fa-user-tie"></i> 
                </div>
                <a href="LogoutServlet" class="btn-logout">Đăng xuất</a>
            </div>

            <h1 style="color: var(--primary-color);">Bảng điều khiển hệ thống</h1>

            <div class="grid-container">
                <a href="CustomerServlet" class="card">
                    <i class="fa-solid fa-user-group"></i>
                    <h3>Quản lý Khách hàng</h3>
                    <p>Thêm, sửa, tìm kiếm thông tin khách hàng.</p>
                </a>

                <a href="RoomServlet" class="card">
                    <i class="fa-solid fa-bed"></i>
                    <h3>Phòng & Loại phòng</h3>
                    <p>Cập nhật trạng thái và giá phòng.</p>
                </a>

                <a href="BookingServlet" class="card">
                    <i class="fa-solid fa-calendar-plus"></i>
                    <h3>Đặt phòng</h3>
                    <p>Tạo mới đơn đặt phòng cho khách.</p>
                </a>

                <a href="check-in.jsp" class="card">
                    <i class="fa-solid fa-key"></i>
                    <h3>Check-in</h3>
                    <p>Giao phòng và nhận trả phòng nhanh.</p>
                </a>

                <a href="serviceManagementServlet" class="card">
                    <i class="fa-solid fa-utensils"></i>
                    <h3>Quản lý Dịch vụ</h3>
                    <p>Danh mục đồ ăn, thức uống, giặt ủi.</p>
                </a>

                <a href="bill.jsp" class="card">
                    <i class="fa-solid fa-file-invoice"></i>
                    <h3>Check-out và Lập hóa đơn</h3>
                    <p>Tính toán tiền phòng và dịch vụ.</p>
                </a>

                <a href="PaymentServlet" class="card">
                    <i class="fa-solid fa-credit-card"></i>
                    <h3>Thanh toán</h3>
                    <p>Xử lý giao dịch và phương thức thanh toán.</p>
                </a>

                <a href="ReportServlet" class="card">
                    <i class="fa-solid fa-chart-pie"></i>
                    <h3>Thống kê doanh thu</h3>
                    <p>Báo cáo doanh số theo ngày/tháng.</p>
                </a>
                <a href="EmployeeServlet" class="card">
                    <i class="fa-solid fa-user-tie"></i>
                    <h3>Quản lý Nhân viên</h3>
                    <p>Thêm, sửa, tìm kiếm và xóa thông tin nhân viên.</p>
                </a>
            </div>
        </div>

    </body>
</html>