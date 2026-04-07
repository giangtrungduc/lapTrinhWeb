<%@page import="com.mycompany.laptrinhweb.model.dto.RoomStatus"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomDTO" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomStatus" %>
<%
    List<RoomDTO> roomList = (List<RoomDTO>) request.getAttribute("roomList");
    String role = (String) session.getAttribute("role"); // "Quản lý" hoặc "Nhân viên"
    String user = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Phòng - Hotel System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --available-color: #27ae60; /* Màu xanh cho phòng trống */
            --occupied-color: #e74c3c;  /* Màu đỏ cho phòng đã có khách */
            --bg-color: #f4f7f6;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            background-color: var(--bg-color);
            display: flex;
        }

        /* Sidebar kế thừa từ main.jsp */
        .sidebar {
            width: 260px;
            height: 100vh;
            background-color: var(--primary-color);
            color: white;
            position: fixed;
            padding-top: 20px;
        }

        .sidebar a {
            display: block;
            padding: 15px 25px;
            color: #ecf0f1;
            text-decoration: none;
            transition: 0.3s;
        }

        .sidebar a:hover {
            background-color: #3498db;
        }

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
            margin-bottom: 30px;
        }

        /* Grid hiển thị thẻ phòng */
        .room-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }

        .room-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            transition: transform 0.3s;
            position: relative;
            border-top: 5px solid #ccc;
        }

        /* Màu sắc dựa trên trạng thái */
        .room-card.available { border-top-color: var(--available-color); }
        .room-card.occupied { border-top-color: var(--occupied-color); }

        .room-card:hover { transform: translateY(-5px); }

        .room-info {
            padding: 20px;
            text-align: center;
        }

        .room-number {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .room-type { color: #777; font-size: 14px; margin-bottom: 10px; }

        .room-status {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            color: white;
            margin-bottom: 15px;
        }

        .status-available { background-color: var(--available-color); }
        .status-occupied { background-color: var(--occupied-color); }

        .room-actions {
            border-top: 1px solid #eee;
            padding: 10px;
            display: flex;
            justify-content: space-around;
            background: #f9f9f9;
        }

        .btn {
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
            text-decoration: none;
            color: white;
        }

        .btn-booking { background-color: #3498db; width: 80%; }
        .btn-edit { background-color: #f39c12; }
        .btn-delete { background-color: #e74c3c; }
        .btn-add { background-color: #27ae60; padding: 10px 20px; font-weight: bold; }
    </style>
</head>
<body>

    <div class="sidebar">
        <h2 style="text-align: center;">HOTEL MANAGER</h2>
        <a href="main.jsp"><i class="fa-solid fa-gauge"></i> Dashboard</a>
        <a href="RoomServlet"><i class="fa-solid fa-door-open"></i> Phòng & Loại phòng</a>
        <a href="CustomerServlet"><i class="fa-solid fa-users"></i> Khách hàng</a>
        </div>

    <div class="main-content">
        <div class="header">
            <div>
                <h2 style="margin:0;">Danh sách phòng</h2>
                <small>Vai trò: <strong><%=role%></strong></small>
            </div>
            <% if ("Quản lý".equals(role)) { %>
                <a href="add-room.jsp" class="btn btn-add"><i class="fa-solid fa-plus"></i> Thêm phòng mới</a>
            <% } %>
        </div>

        <div class="room-grid">
            <% if (roomList != null) { 
                for (RoomDTO room : roomList) { 
                    boolean isAvailable = room.getTrangthai() == RoomStatus.Trong;
            %>
                <div class="room-card <%= isAvailable ? "available" : "occupied" %>">
                    <div class="room-info">
                        <div class="room-number">Phòng <%= room.getSophong() %></div>
                        <div class="room-type"><%= room.getTenloaiphong() %></div>
                        <div class="room-status <%= isAvailable ? "status-available" : "status-occupied" %>">
                            <%= isAvailable ? "SẴN SÀNG" : "ĐANG CÓ KHÁCH" %>
                        </div>
                        <div style="font-weight: bold; color: var(--primary-color);">
                            <%= String.format("%,.0f", room.getGia()) %> VNĐ
                        </div>
                    </div>

                    <div class="room-actions">
                        <% if ("Nhân viên".equals(role)) { %>
                            <% if (isAvailable) { %>
                                <a href="BookingServlet?maPhong=<%=room.getMaphong()%>" class="btn btn-booking">
                                    <i class="fa-solid fa-calendar-check"></i> Đặt phòng
                                </a>
                            <% } else { %>
                                <span style="color: #999; font-size: 12px;">Không thể chọn</span>
                            <% } %>
                        <% } else if ("Quản lý".equals(role)) { %>
                            <a href="edit-room.jsp?id=<%=room.getMaphong()%>" class="btn btn-edit" title="Sửa">
                                <i class="fa-solid fa-pen"></i>
                            </a>
                            <a href="RoomServlet?action=delete&id=<%=room.getMaphong()%>" 
                               class="btn btn-delete" 
                               onclick="return confirm('Xóa phòng này?')" title="Xóa">
                                <i class="fa-solid fa-trash"></i>
                            </a>
                        <% } %>
                    </div>
                </div>
            <% } } %>
        </div>
    </div>

</body>
</html>