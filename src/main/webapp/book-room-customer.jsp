

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="KhachHangServlet" method="post">
            <label for="hoTen">Họ tên:</label><br>
            <input type="text" id="hoTen" name="hoTen" required><br><br>

            <label for="cccd">CCCD:</label><br>
            <input type="text" id="cccd" name="cccd"><br><br>

            <label for="sdt">Số điện thoại:</label><br>
            <input type="text" id="sdt" name="sdt" pattern="[0-9]{10}" title="Nhập đúng 10 chữ số"><br><br>

            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email"><br><br>

            <label for="diaChi">Địa chỉ:</label><br>
            <textarea id="diaChi" name="diaChi"></textarea><br><br>
            <label for="ngayNhan">Ngày nhận phòng:</label><br>
            <input type="date" id="ngayNhan" name="ngayNhan" required><br><br>

            <label for="ngayTra">Ngày trả phòng:</label><br>
            <input type="date" id="ngayTra" name="ngayTra" required><br><br>
            <button type="submit">Gửi thông tin đặt phòng</button>
        </form>
    </body>
</html>
