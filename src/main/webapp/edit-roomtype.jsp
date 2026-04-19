<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomTypeDTO" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    RoomTypeDTO rt = (RoomTypeDTO) request.getAttribute("roomType");
    if (rt == null) {
        response.sendRedirect("RoomServlet?action=listRoomType");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa loại phòng</title>
</head>
<body>
    <h1>Sửa loại phòng: <%= rt.getTenloaiphong() %></h1>
    <hr>

    <form action="RoomServlet?action=editRoomType" method="post">
        <input type="hidden" name="maLoaiPhong" value="<%= rt.getMaloaiphong() %>" />

        <table>
            <tr>
                <td>Tên loại phòng:</td>
                <td><input type="text" name="tenLoaiPhong" value="<%= rt.getTenloaiphong() %>" required /></td>
            </tr>
            <tr>
                <td>Số người tối đa:</td>
                <td><input type="number" name="soNguoiToiDa" value="<%= rt.getSonguoitoida() %>" required min="1" /></td>
            </tr>
            <tr>
                <td>Giá cơ bản (VNĐ):</td>
                <td><input type="number" name="giaCoBan" value="<%= (int) rt.getGiacoban() %>" required min="0" step="1000" /></td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">Lưu thay đổi</button>
                    &nbsp;
                    <a href="RoomServlet?action=listRoomType">Hủy</a>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
