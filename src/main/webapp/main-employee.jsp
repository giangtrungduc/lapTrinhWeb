<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
        <title>Trang nhân viên</title>
    </head>
    <body>
        <h1>Trang nhân viên</h1>

        <p>Xin chào, <b><%= user %></b></p>

        <hr>

        <h2>Chức năng</h2>
        
        <form action="BookingByCustomer" method="get">
            <input type="hidden" name="action" value="list">
            <button type="submit">Đặt phòng</button>
        </form>
        
        <br>

        <form action="BookingConfirmationServlet" method="get">
            <input type="hidden" name="action" value="list">
            <button type="submit">Xác nhận đặt phòng</button>
        </form>

        <br>

        <form action="CheckInServlet" method="get">
            <input type="hidden" name="action" value="list">
            <button type="submit">Check-in</button>
        </form>

        <br>
        
        <form action="ServiceServlet" method="get">
            <input type="hidden" name="action" value="list">
            <button type="submit">Dịch vụ</button>
        </form>
        
        <br>

        <form action="CheckOutServlet" method="get">
            <input type="hidden" name="action" value="list">
            <button type="submit">Check-out</button>
        </form>

        <br>

        <form action="PaymentServlet" method="get">
            <input type="hidden" name="action" value="list">
            <button type="submit">Thanh toán</button>
        </form>

        <hr>

        <form action="LogoutServlet" method="get">
            <button type="submit">Đăng xuất</button>
        </form>
    </body>
</html>