<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.RoomBookingStatusDTO"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.RoomDTO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #fafafa;
    }
    .room-container {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        gap: 16px;
        padding: 20px;
    }
    .room-card {
        border-radius: 8px;
        padding: 16px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        transition: transform 0.2s ease, box-shadow 0.2s ease;

    }
    .room-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    }
    .room-card h3 {
        margin-top: 0;
        margin-bottom: 8px;
        font-size: 18px;
    }
    .room-card p {
        margin: 4px 0;
        font-size: 14px;
    }
</style>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tìm Kiếm Phòng Khách Sạn</title>

    </head>
    <body>
        <form action="FindRoomCustomerServlet">
            <label>Số phòng</label>
            <input name="soPhong">
            <label>Giá phòng</label>
            <input name="giaPhong"> 
            <label>Loại phòng</label>
            <input name="tenLoaiPhong">
            <label>Số người tối đa</label>
            <input name="soNguoiToiDa">
            <button type="submit">Tim kiem</button>
        </form>
        <%
            List<RoomDTO> listRoom = (List<RoomDTO>) session.getAttribute("listRoom");
            if (listRoom != null) {
        %>
        <div class="room-container">

            <% for (RoomDTO room : listRoom) {
                    String bgColor;
                    switch (room.getTrangthai().toString()) {
                        case "Trong":
                            bgColor = "#e0ffe0";
                            break;
                        case "DaDat":
                            bgColor = "#fff0e0";
                            break;
                        case "DangO":
                            bgColor = "#e0f0ff";
                            break;
                        case "BaoTri":
                            bgColor = "#f0f0f0";
                            break;
                        default:
                            bgColor = "#ffffff";
                    }
            %>
            <div class="room-card" style="background-color:<%= bgColor%>;">
                <h3>Phòng số <%= room.getSophong()%></h3>
                <p><strong>Loại phòng:</strong> <%= room.getTenloaiphong()%></p>
                <p><strong>Giá cơ bản:</strong> <%= room.getGia()%> VND</p>
                <p><strong>Số người tối đa:</strong> <%= room.getSonguoitoida()%></p>
                <p><strong>Trạng thái:</strong> <%= room.getTrangthai()%></p>
                <form action="PhongInfoServlet" method="get">
                    <button type="submit">Xem phòng này</button>
                    <input name="maPhong" type="hidden" value="<%=room.getMaphong()%>">
                    <input name="soPhong" type="hidden" value="<%=room.getSophong()%>">
                    <input name="giaPhong" type="hidden" value="<%=room.getGia()%>">
                    <input name="tenLoaiPhong" type="hidden" value="<%=room.getTenloaiphong()%>">
                    <input name="soNguoiToiDa" type="hidden" value="<%=room.getSonguoitoida()%>">
                </form>
                </div>
                <% } %>
                <%
                    }
                %>
            </div>
            <%
                List<RoomBookingStatusDTO> listBooking = (List<RoomBookingStatusDTO>) request.getAttribute("listBooking");
                if (listBooking != null) {
                    for (RoomBookingStatusDTO booking : listBooking) {
                        LocalDateTime nhan = booking.getNgayNhanDuKien();
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm 'giờ, ngày' dd/MM/yyyy");
                        String formatted = nhan.format(formatter);
                        LocalDateTime tra = booking.getNgayTraDuKien();
                        String formatted1 = tra.format(formatter);
            %>
            
        
        <h3>Thông tin đặt phòng</h3>
        <div>
            Từ: <%=formatted%> --- Đến: <%=formatted1%>
        </div>
        <%
                }
            }
        %>

    </body>
</html>