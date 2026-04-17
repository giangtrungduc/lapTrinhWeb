<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.RoomBookingStatusDTO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
    <head>
        <title>Thông tin phòng</title>
        <script>
            function showBookingForm() {
                document.getElementById("bookingForm").style.display = "block";
            }
        </script>
    </head>
    <body>
        <form action="find-room-customer.jsp">
            <button type="submit">Quay lại trang đặt phòng</button>
        </form>
        <h2>Thông tin phòng</h2>
        <p>Mã phòng: ${room.maphong}</p>
        <p>Số phòng: ${room.sophong}</p>
        <p>Loại phòng: ${room.tenloaiphong}</p>
        <p>Giá: ${room.gia}</p>
        <p>Số người tối đa: ${room.songuoitoida}</p>
        <p>Trạng thái: ${room.trangthai}</p>

        <h2>Lịch sử đặt phòng</h2>
        <%
            List<RoomBookingStatusDTO> listBooking = (List<RoomBookingStatusDTO>) request.getAttribute("listBooking");
            if (listBooking != null && !listBooking.isEmpty()) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm 'giờ, ngày' dd/MM/yyyy");
        %>
        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <th>Mã đặt phòng</th>
                <th>Ngày nhận dự kiến</th>
                <th>Ngày trả dự kiến</th>
                <th>Trạng thái</th>
            </tr>
            <%
                for (RoomBookingStatusDTO booking : listBooking) {
                    LocalDateTime nhan = booking.getNgayNhanDuKien();
                    LocalDateTime tra = booking.getNgayTraDuKien();
                    String formattedNhan = nhan != null ? nhan.format(formatter) : "";
                    String formattedTra = tra != null ? tra.format(formatter) : "";
            %>
            <tr>
                <td><%= booking.getMaDatPhong()%></td>
                <td><%= formattedNhan%></td>
                <td><%= formattedTra%></td>
                <td><%= booking.getTrangThai()%></td>
            </tr>
            <%
                }
            %>
        </table>
        <%
        } else {
        %>
        <p>Không có lịch sử đặt phòng cho phòng này.</p>
        <%
            }
        %>
        <button type="button" onclick="showBookingForm()">Đặt phòng này</button>

        <!-- Form nhập thông tin khách hàng, ban đầu ẩn -->
        <div id="bookingForm" style="display:none; margin-top:20px;">
            <h3>Thông tin khách hàng</h3>
            <form action="BookingFormCustomerServlet" method="post">
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
                <input type="datetime-local" id="ngayNhan" name="ngayNhan" required><br><br>

                <label for="ngayTra">Ngày trả phòng:</label><br>
                <input type="datetime-local" id="ngayTra" name="ngayTra" required><br><br>
                <!-- Truyền mã phòng để biết khách đặt phòng nào -->
                <input type="hidden" name="maPhong" value="${room.maphong}">

                <button type="submit">Xác nhận đặt phòng</button>
            </form>
        </div>
        <script>
            function showBookingForm() {
                // Hiện form
                document.getElementById("bookingForm").style.display = "block";

                
        </script>
    </body>
</html>
