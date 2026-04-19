<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomDTO" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomTypeDTO" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomStatus" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    RoomDTO room = (RoomDTO) request.getAttribute("room");
    List<RoomTypeDTO> roomTypes = (List<RoomTypeDTO>) request.getAttribute("roomTypes");
    if (room == null) {
        response.sendRedirect("RoomServlet?action=list");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa phòng</title>
</head>
<body>
    <h1>Sửa thông tin phòng <%= room.getSophong() %></h1>
    <hr>

    <form action="RoomServlet?action=editRoom" method="post">
        <input type="hidden" name="maPhong" value="<%= room.getMaphong() %>" />

        <table>
            <tr>
                <td>Số phòng:</td>
                <td><input type="number" name="soPhong" value="<%= room.getSophong() %>" required min="1" /></td>
            </tr>
            <tr>
                <td>Loại phòng:</td>
                <td>
                    <select name="maLoaiPhong" required>
                        <% if (roomTypes != null) {
                            for (RoomTypeDTO rt : roomTypes) { %>
                        <option value="<%= rt.getMaloaiphong() %>"
                            <%= rt.getMaloaiphong() == room.getMaloaiphong() ? "selected" : "" %>>
                            <%= rt.getTenloaiphong() %> (Giá: <%= String.format("%,.0f", rt.getGiacoban()) %> VNĐ)
                        </option>
                        <% } } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Trạng thái:</td>
                <td>
                    <select name="trangThai">
                        <% for (RoomStatus s : RoomStatus.values()) { %>
                        <option value="<%= s.name() %>"
                            <%= s == room.getTrangthai() ? "selected" : "" %>>
                            <%= s.getDisplayName() %>
                        </option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">Lưu thay đổi</button>
                    &nbsp;
                    <a href="RoomServlet?action=list">Hủy</a>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
