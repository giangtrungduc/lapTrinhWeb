<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomDTO" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomStatus" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<RoomDTO> roomList = (List<RoomDTO>) request.getAttribute("roomList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Phòng</title>
</head>
<body>
    <h1>Quản lý Phòng</h1>
    <p>Xin chào, <b><%= user %></b></p>
    <hr>

    <a href="RoomServlet?action=showAddRoom">Thêm phòng mới</a>
    &nbsp;|&nbsp;
    <a href="RoomServlet?action=listRoomType">Quản lý loại phòng</a>
    &nbsp;|&nbsp;
    <a href="main.jsp">Về trang chủ</a>

    <hr>
    <h2>Danh sách phòng</h2>

    <table border="1" cellpadding="6" cellspacing="0">
        <tr>
            <th>Mã phòng</th>
            <th>Số phòng</th>
            <th>Loại phòng</th>
            <th>Số người tối đa</th>
            <th>Giá cơ bản (VNĐ)</th>
            <th>Trạng thái</th>
            <th>Thao tác</th>
        </tr>
        <% if (roomList != null && !roomList.isEmpty()) {
            for (RoomDTO room : roomList) { %>
        <tr>
            <td><%= room.getMaphong() %></td>
            <td><%= room.getSophong() %></td>
            <td><%= room.getTenloaiphong() %></td>
            <td><%= room.getSonguoitoida() %></td>
            <td><%= String.format("%,.0f", room.getGia()) %></td>
            <td><%= room.getTrangthai().getDisplayName() %></td>
            <td>
                <a href="RoomServlet?action=showEditRoom&id=<%= room.getMaphong() %>">Sửa</a>
                &nbsp;
                <% if (room.getTrangthai() != RoomStatus.BaoTri) { %>
                    <a href="RoomServlet?action=deleteRoom&id=<%= room.getMaphong() %>"
                       onclick="return confirm('Chuyển phòng <%= room.getSophong() %> về trạng thái Bảo Trì?')">
                        Xóa (Bảo Trì)
                    </a>
                <% } else { %>
                    <i>Đang bảo trì</i>
                <% } %>
            </td>
        </tr>
        <% } } else { %>
        <tr>
            <td colspan="7">Không có phòng nào.</td>
        </tr>
        <% } %>
    </table>
</body>
</html>
