<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm loại phòng mới</title>
</head>
<body>
    <h1>Thêm loại phòng mới</h1>
    <hr>

    <form action="RoomServlet?action=addRoomType" method="post">
        <table>
            <tr>
                <td>Tên loại phòng:</td>
                <td><input type="text" name="tenLoaiPhong" required /></td>
            </tr>
            <tr>
                <td>Số người tối đa:</td>
                <td><input type="number" name="soNguoiToiDa" required min="1" /></td>
            </tr>
            <tr>
                <td>Giá cơ bản (VNĐ):</td>
                <td><input type="number" name="giaCoBan" required min="0" step="1000" /></td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">Thêm loại phòng</button>
                    &nbsp;
                    <a href="RoomServlet?action=listRoomType">Hủy</a>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
