<%@page import="com.mycompany.laptrinhweb.model.dto.RoomStatus"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.RoomDTO"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.RoomTypeDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Lấy dữ liệu từ cả 2 nhánh
    List<RoomDTO> roomList = (List<RoomDTO>) request.getAttribute("roomList");
    List<RoomTypeDTO> loaiPhongList = (List<RoomTypeDTO>) request.getAttribute("loaiPhongList");
    
    String role = (String) session.getAttribute("role");
    String user = (String) session.getAttribute("user");
    
    // Format tiền VNĐ
    NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Phòng & Loại phòng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --available-color: #27ae60;
            --occupied-color: #e74c3c;
            --bg-color: #f8f9fa;
            --sidebar-color: #2c3e50;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            background-color: var(--bg-color);
            display: flex;
        }

        /* Sidebar */
        .sidebar {
            width: 260px;
            height: 100vh;
            background-color: var(--sidebar-color);
            color: white;
            position: fixed;
            padding-top: 20px;
        }

        .sidebar h2 { text-align: center; font-size: 20px; margin-bottom: 30px; color: #4cc9f0; }
        .sidebar a {
            display: block;
            padding: 15px 25px;
            color: #ecf0f1;
            text-decoration: none;
            transition: 0.3s;
        }
        .sidebar a:hover { background-color: var(--primary-color); }

        /* Main Content */
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
            padding: 20px 30px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }

        /* Room Grid */
        .room-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 20px;
        }

        .room-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            transition: 0.3s;
            border-top: 5px solid #ccc;
        }

        .room-card.available { border-top-color: var(--available-color); }
        .room-card.occupied { border-top-color: var(--occupied-color); }
        .room-card:hover { transform: translateY(-5px); }

        .room-info { padding: 20px; text-align: center; }
        .room-number { font-size: 22px; font-weight: bold; margin-bottom: 5px; }
        .room-status {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: bold;
            color: white;
            margin: 10px 0;
        }
        .status-available { background-color: var(--available-color); }
        .status-occupied { background-color: var(--occupied-color); }

        .btn {
            border: none;
            padding: 10px 15px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            text-decoration: none;
            color: white;
            display: inline-block;
        }
        .btn-booking { background-color: var(--primary-color); width: 80%; }
        .btn-add { background-color: var(--available-color); font-weight: bold; }
        .room-actions {
            border-top: 1px solid #eee;
            padding: 15px;
            display: flex;
            justify-content: space-around;
            background: #fafafa;
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <h2><i class="fa-solid fa-hotel"></i> HOTEL PRO</h2>
        <a href="main.jsp"><i class="fa-solid fa-gauge"></i> Dashboard</a>
        <a href="RoomServlet"><i class="fa-solid fa-door-open"></i> Phòng & Loại phòng</a>
        <a href="CustomerServlet"><i class="fa-solid fa-users"></i> Khách hàng</a>
        <a href="bill.jsp"><i class="fa-solid fa-file-invoice-dollar"></i> Hóa đơn</a>
    </div>

    <div class="main-content">
        <div class="header">
            <div>
                <h2 style="margin:0;">Sơ đồ phòng thực tế</h2>
                <small>Xin chào, <strong><%=user%></strong> (<%=role%>)</small>
            </div>
            <% if ("Quản lý".equals(role)) { %>
                <a href="add-room.jsp" class="btn btn-add"><i class="fa-solid fa-plus"></i> Thêm phòng mới</a>
            <% } %>
        </div>

        <div class="room-grid">
            <% if (roomList != null) { 
                for (RoomDTO room : roomList) { 
                    boolean isAvailable = room.getTrangThai()== RoomStatus.Trong;
            %>
                <div class="room-card <%= isAvailable ? "available" : "occupied" %>">
                    <div class="room-info">
                        <div class="room-number">Phòng <%= room.getSoPhong() %></div>
                        <div style="color: #7f8c8d; font-size: 14px;"><%= room.getTenLoaiPhong() %></div>
                        <div class="room-status <%= isAvailable ? "status-available" : "status-occupied" %>">
                            <%= isAvailable ? "TRỐNG" : "ĐÃ CÓ KHÁCH" %>
                        </div>
                        <div style="font-weight: bold; color: #2c3e50; font-size: 18px;">
                            <%= nf.format(room.getGia()) %> đ
                        </div>
                    </div>

                    <div class="room-actions">
                        <% if ("Nhân viên".equals(role)) { %>
                            <% if (isAvailable) { %>
                                <a href="BookingServlet?maPhong=<%=room.getMaPhong()%>" class="btn btn-booking">
                                    <i class="fa-solid fa-calendar-check"></i> Đặt ngay
                                </a>
                            <% } else { %>
                                <span style="color: #bdc3c7; font-size: 12px;">Đang sử dụng</span>
                            <% } %>
                        <% } else if ("Quản lý".equals(role)) { %>
                            <a href="edit-room.jsp?id=<%=room.getMaPhong()%>" style="color: #f39c12;"><i class="fa-solid fa-pen"></i></a>
                            <a href="RoomServlet?action=delete&id=<%=room.getMaPhong()%>" 
                               style="color: #e74c3c;" onclick="return confirm('Xóa phòng?')">
                                <i class="fa-solid fa-trash"></i>
                            </a>
                        <% } %>
                    </div>
                </div>
            <% } } else { %>
                <p>Không có dữ liệu phòng để hiển thị.</p>
            <% } %>
        </div>
    </div>

</body>
</html>