<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomDTO" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomStatus" %>
<%
    List<RoomDTO> roomList = (List<RoomDTO>) request.getAttribute("roomList");
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách phòng</title>
</head>
<body>
    <h1>Danh sách phòng khách sạn</h1>

    <% if (message != null && !message.isEmpty()) { %>
        <p><b><%= message %></b></p>
    <% } %>

    <hr>

    <table border="1" cellpadding="6" cellspacing="0">
        <tr>
            <th>Số phòng</th>
            <th>Loại phòng</th>
            <th>Số người tối đa</th>
            <th>Giá cơ bản (VNĐ)</th>
            <th>Trạng thái</th>
            <th>Thao tác</th>
        </tr>
        <% if (roomList != null) {
            for (RoomDTO room : roomList) {
                RoomStatus tt = room.getTrangthai();
        %>
        <tr>
            <td><%= room.getSophong() %></td>
            <td><%= room.getTenloaiphong() %></td>
            <td><%= room.getSonguoitoida() %></td>
            <td><%= String.format("%,.0f", room.getGia()) %></td>
            <td><%= tt.getDisplayName() %></td>
            <td>
                <% if (tt == RoomStatus.BaoTri) { %>
                    <i>Không thể đặt (đang bảo trì)</i>

                <% } else { %>
                    <a href="BookingByCustomer?action=showBookingForm&maPhong=<%= room.getMaphong() %>">
                        Đặt phòng
                    </a>
                <% } %>
            </td>
        </tr>
        <% } } %>
    </table>
</body>
</html>
