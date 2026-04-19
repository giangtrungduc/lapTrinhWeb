<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomTypeDTO" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<RoomTypeDTO> roomTypeList = (List<RoomTypeDTO>) request.getAttribute("roomTypeList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Loại Phòng</title>
</head>
<body>
    <h1>Quản lý Loại Phòng</h1>
    <p>Xin chào, <b><%= user %></b></p>
    <hr>

    <a href="RoomServlet?action=showAddRoomType">Thêm loại phòng mới</a>
    &nbsp;|&nbsp;
    <a href="RoomServlet?action=list">Quản lý phòng</a>
    &nbsp;|&nbsp;
    <a href="main.jsp">Về trang chủ</a>

    <hr>
    <h2>Danh sách loại phòng</h2>

    <table border="1" cellpadding="6" cellspacing="0">
        <tr>
            <th>Mã loại phòng</th>
            <th>Tên loại phòng</th>
            <th>Số người tối đa</th>
            <th>Giá cơ bản (VNĐ)</th>
            <th>Thao tác</th>
        </tr>
        <% if (roomTypeList != null && !roomTypeList.isEmpty()) {
            for (RoomTypeDTO rt : roomTypeList) { %>
        <tr>
            <td><%= rt.getMaloaiphong() %></td>
            <td><%= rt.getTenloaiphong() %></td>
            <td><%= rt.getSonguoitoida() %></td>
            <td><%= String.format("%,.0f", rt.getGiacoban()) %></td>
            <td>
                <a href="RoomServlet?action=showEditRoomType&id=<%= rt.getMaloaiphong() %>">Sửa</a>
            </td>
        </tr>
        <% } } else { %>
        <tr>
            <td colspan="5">Không có loại phòng nào.</td>
        </tr>
        <% } %>
    </table>
</body>
</html>
