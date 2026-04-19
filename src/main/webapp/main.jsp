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
        <title>Trang quản lý</title>
    </head>
    <body>
        <h1>Trang quản lý</h1>
        <p>Xin chào, <b><%= user %></b></p>
        <hr>
        <h2>Chức năng</h2>

        <form action="CustomerServlet" method="get">
            <input type="hidden" name="action" value="list">
            <button type="submit">Quản lý khách hàng</button>
        </form>
        <br>

        <form action="EmployeeServlet" method="get">
            <input type="hidden" name="action" value="list">
            <button type="submit">Quản lý nhân viên</button>
        </form>
        <br>

        <form action="RoomServlet" method="get">
            <input type="hidden" name="action" value="list">
            <button type="submit">Quản lý phòng & loại phòng</button>
        </form>
        <br>

        <form action="ServiceManagementServlet" method="get">
            <input type="hidden" name="action" value="list">
            <button type="submit">Quản lý dịch vụ</button>
        </form>
        <br>

        <form action="RevenueDetailServlet" method="get">
            <input type="hidden" name="action" value="list">
            <button type="submit">Thống kê doanh thu</button>
        </form>

        <hr>
        <form action="LogoutServlet" method="get">
            <button type="submit">Đăng xuất</button>
        </form>
    </body>
</html>