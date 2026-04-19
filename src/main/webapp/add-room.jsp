<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomTypeDTO" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomStatus" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<RoomTypeDTO> roomTypes = (List<RoomTypeDTO>) request.getAttribute("roomTypes");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm phòng mới</title>
</head>
<body>
    <h1>Thêm phòng mới</h1>
    <hr>

    <form action="RoomServlet?action=addRoom" method="post">
        <table>
            <tr>
                <td>Số phòng:</td>
                <td><input type="number" name="soPhong" required min="1" /></td>
            </tr>
            <tr>
                <td>Loại phòng:</td>
                <td>
                    <select name="maLoaiPhong" required>
                        <option value="">-- Chọn loại phòng --</option>
                        <% if (roomTypes != null) {
                            for (RoomTypeDTO rt : roomTypes) { %>
                        <option value="<%= rt.getMaloaiphong() %>">
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
                        <option value="<%= s.name() %>"><%= s.getDisplayName() %></option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">Thêm phòng</button>
                    &nbsp;
                    <a href="RoomServlet?action=list">Hủy</a>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
