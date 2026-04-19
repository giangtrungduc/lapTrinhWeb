<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomDTO" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomBookingStatusDTO" %>
<%
    RoomDTO room = (RoomDTO) request.getAttribute("room");
    List<RoomBookingStatusDTO> existingBookings =
        (List<RoomBookingStatusDTO>) request.getAttribute("existingBookings");
    String error = (String) request.getAttribute("error");

    if (room == null) {
        response.sendRedirect("BookingByCustomer?action=list");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt phòng <%= room.getSophong() %></title>
</head>
<body>
    <h1>Đặt phòng số <%= room.getSophong() %></h1>

    <p>Loại phòng: <b><%= room.getTenloaiphong() %></b></p>
    <p>Số người tối đa: <b><%= room.getSonguoitoida() %></b></p>
    <p>Giá cơ bản: <b><%= String.format("%,.0f", room.getGia()) %> VNĐ/đêm</b></p>
    <p>Trạng thái: <b><%= room.getTrangthai().getDisplayName() %></b></p>

    <hr>

    <%-- Hiển thị các khoảng thời gian đã bị đặt --%>
    <% if (existingBookings != null && !existingBookings.isEmpty()) { %>
        <h3>Các ngày đã có người đặt:</h3>
        <table border="1" cellpadding="4" cellspacing="0">
            <tr>
                <th>Ngày nhận dự kiến</th>
                <th>Ngày trả dự kiến</th>
                <th>Trạng thái</th>
            </tr>
            <% for (RoomBookingStatusDTO b : existingBookings) { %>
            <tr>
                <td><%= b.getNgayNhanDuKien() %></td>
                <td><%= b.getNgayTraDuKien() %></td>
                <td><%= b.getTrangThai() %></td>
            </tr>
            <% } %>
        </table>
        <br>
    <% } %>

    <%-- Thông báo lỗi nếu có --%>
    <% if (error != null && !error.isEmpty()) { %>
        <p style="color:red;"><b><%= error %></b></p>
    <% } %>

    <h3>Thông tin đặt phòng</h3>

    <form action="BookingByCustomer" method="post">
        <input type="hidden" name="action" value="submitBooking" />
        <input type="hidden" name="maPhong" value="<%= room.getMaphong() %>" />

        <table>
            <tr>
                <td>Họ tên:</td>
                <td><input type="text" name="hoTen" required /></td>
            </tr>
            <tr>
                <td>CCCD:</td>
                <td><input type="text" name="cccd" required /></td>
            </tr>
            <tr>
                <td>Số điện thoại:</td>
                <td><input type="text" name="sdt" required /></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type="email" name="email" /></td>
            </tr>
            <tr>
                <td>Địa chỉ:</td>
                <td><input type="text" name="diaChi" /></td>
            </tr>
            <tr>
                <td>Ngày nhận phòng:</td>
                <%-- datetime-local có format yyyy-MM-ddTHH:mm, LocalDateTime.parse() dùng được trực tiếp --%>
                <td><input type="datetime-local" name="ngayNhan" required /></td>
            </tr>
            <tr>
                <td>Ngày trả phòng:</td>
                <td><input type="datetime-local" name="ngayTra" required /></td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">Xác nhận đặt phòng</button>
                    &nbsp;
                    <a href="BookingByCustomer?action=list">Quay lại</a>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
