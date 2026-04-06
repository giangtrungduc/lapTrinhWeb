<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hệ thống Quản lý Khách sạn - Dashboard</title>
    
    
</head>
<body>

    <div class="sidebar">
        <h2>HOTEL MANAGER</h2>
        <a href="main.jsp"></i> Dashboard</a>
        <a href="CustomerServlet"></i> Khách hàng</a>
        <a href="RoomServlet"></i> Phòng & Loại phòng</a>
        <a href="BookingServlet"></i> Đặt phòng</a>
        <a href="ServiceServlet"></i> Dịch vụ</a>
        <a href="InvoiceServlet"></i> Hóa đơn</a>
        <a href="ReportServlet"></i> Thống kê</a>
    </div>

    <div class="main-content">
        <div class="header">
            <div class="user-info">
                Xin chào
            </div>
            <a href="LogoutServlet" class="btn-logout">Đăng xuất</a>
        </div>

        <h1 style="color: var(--primary-color);">Bảng điều khiển hệ thống</h1>

        <div class="grid-container">
            <a href="CustomerServlet" class="card">
                
                <h3>Quản lý Khách hàng</h3>
                <p>Thêm, sửa, tìm kiếm thông tin khách hàng.</p>
            </a>

            <a href="RoomServlet" class="card">
               
                <h3>Phòng & Loại phòng</h3>
                <p>Cập nhật trạng thái và giá phòng.</p>
            </a>

            <a href="BookingServlet" class="card">
                
                <h3>Đặt phòng</h3>
                <p>Tạo mới đơn đặt phòng cho khách.</p>
            </a>

            <a href="CheckInServlet" class="card">
               
                <h3>Check-in / Out</h3>
                <p>Giao phòng và nhận trả phòng nhanh.</p>
            </a>

            <a href="ServiceServlet" class="card">
               
                <h3>Quản lý Dịch vụ</h3>
                <p>Danh mục đồ ăn, thức uống, giặt ủi.</p>
            </a>

            <a href="InvoiceServlet" class="card">
               
                <h3>Lập hóa đơn</h3>
                <p>Tính toán tiền phòng và dịch vụ.</p>
            </a>

            <a href="PaymentServlet" class="card">
                
                <h3>Thanh toán</h3>
                <p>Xử lý giao dịch và phương thức thanh toán.</p>
            </a>

            <a href="ReportServlet" class="card">
               
                <h3>Thống kê doanh thu</h3>
                <p>Báo cáo doanh số theo ngày/tháng.</p>
            </a>
        </div>
    </div>

</body>
</html>