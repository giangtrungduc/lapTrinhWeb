<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.BookingDTO"%>

<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<BookingDTO> dsChoXacNhan = (List<BookingDTO>) request.getAttribute("dsChoXacNhan");
    BookingDTO chiTiet = (BookingDTO) request.getAttribute("chiTiet");
    String message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Xác nhận đặt phòng</title>
        <style>
            .booking-layout {
                width: 100%;
                border-collapse: collapse;
            }

            .booking-layout td {
                vertical-align: top;
                border: 1px solid black;
                padding: 10px;
            }

            .left-panel {
                height: 600px;
            }

            .right-panel {
                height: 600px;
            }

            .scroll-box {
                height: 500px;
                overflow-y: auto;
                overflow-x: auto;
                border: 1px solid gray;
                padding: 10px;
            }

            .action-box {
                height: 70px;
                padding-top: 10px;
                border-top: 1px solid gray;
            }

            .action-box form {
                display: inline;
                margin-right: 10px;
            }
        </style>
    </head>
    <body>
        <h1>Xác nhận đặt phòng</h1>
        <p>Xin chào, <b><%= user %></b></p>

        <a href="main-employee.jsp">Quay lại trang nhân viên</a>
        <hr>

        <% if (message != null) { %>
            <p><b><%= message %></b></p>
            <hr>
        <% } %>

        <table class="booking-layout">
            <tr>
                <td width="40%" class="left-panel">
                    <h2>Danh sách phiếu chờ xác nhận</h2>

                    <div class="scroll-box">
                        <%
                            if (dsChoXacNhan == null || dsChoXacNhan.isEmpty()) {
                        %>
                            <p>Không có phiếu đặt phòng nào chờ xác nhận.</p>
                        <%
                            } else {
                        %>
                            <table border="1" cellpadding="5" cellspacing="0" width="100%">
                                <tr>
                                    <th>Mã đặt phòng</th>
                                    <th>Mã khách hàng</th>
                                    <th>Mã phòng</th>
                                    <th>Ngày nhận</th>
                                    <th>Ngày trả</th>
                                    <th>Xem</th>
                                </tr>
                                <%
                                    for (BookingDTO dp : dsChoXacNhan) {
                                %>
                                <tr>
                                    <td><%= dp.getMaDatPhong() %></td>
                                    <td><%= dp.getMaKH() %></td>
                                    <td><%= dp.getMaPhong() %></td>
                                    <td><%= dp.getNgayNhanDuKien() %></td>
                                    <td><%= dp.getNgayTraDuKien() %></td>
                                    <td>
                                        <form action="BookingConfirmationServlet" method="get">
                                            <input type="hidden" name="action" value="view">
                                            <input type="hidden" name="maDatPhong" value="<%= dp.getMaDatPhong() %>">
                                            <input type="submit" value="Xem chi tiết">
                                        </form>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </table>
                        <%
                            }
                        %>
                    </div>
                </td>

                <td width="60%" class="right-panel">
                    <h2>Chi tiết phiếu đặt phòng</h2>

                    <div class="scroll-box">
                        <% if (chiTiet == null) { %>
                            <p>Chọn một phiếu đặt phòng để xem chi tiết.</p>
                        <% } else { %>

                            <h3>Thông tin phiếu đặt</h3>
                            <p>Mã đặt phòng: <%= chiTiet.getMaDatPhong() %></p>
                            <p>Mã khách hàng: <%= chiTiet.getMaKH() %></p>
                            <p>Mã phòng: <%= chiTiet.getMaPhong() %></p>
                            <p>Ngày đặt: <%= chiTiet.getNgayDat() %></p>
                            <p>Ngày nhận dự kiến: <%= chiTiet.getNgayNhanDuKien() %></p>
                            <p>Ngày trả dự kiến: <%= chiTiet.getNgayTraDuKien() %></p>
                            <p>Trạng thái: <%= chiTiet.getTrangThai() %></p>
                            <p>Ghi chú: <%= chiTiet.getGhiChu() %></p>
                            <p>Giá phòng tại thời điểm đặt: <%= chiTiet.getGiaPhongTaiThoiDiemDat() %></p>

                            <hr>

                            <h3>Thông tin khách hàng</h3>
                            <p>Họ tên: <%= chiTiet.getTenKhachHang() %></p>
                            <p>CCCD: <%= chiTiet.getCccd() %></p>
                            <p>SĐT: <%= chiTiet.getSdtKhachHang() %></p>
                            <p>Email: <%= chiTiet.getEmailKhachHang() %></p>
                            <p>Địa chỉ: <%= chiTiet.getDiaChiKhachHang() %></p>

                            <hr>

                            <h3>Thông tin phòng</h3>
                            <p>Mã phòng: <%= chiTiet.getMaPhong() %></p>
                            <p>Số phòng: <%= chiTiet.getSoPhong() %></p>
                            <p>Loại phòng: <%= chiTiet.getTenLoaiPhong() %></p>
                            <p>Số người tối đa: <%= chiTiet.getSoNguoiToiDa() %></p>
                            <p>Giá cơ bản: <%= chiTiet.getGiaCoBan() %></p>
                            <p>Mô tả: <%= chiTiet.getMoTaLoaiPhong() %></p>

                        <% } %>
                    </div>

                    <div class="action-box">
                        <% if (chiTiet != null) { %>
                            <form action="BookingConfirmationServlet" method="post">
                                <input type="hidden" name="action" value="confirm">
                                <input type="hidden" name="maDatPhong" value="<%= chiTiet.getMaDatPhong() %>">
                                <input type="submit" value="Xác nhận">
                            </form>

                            <form action="BookingConfirmationServlet" method="post">
                                <input type="hidden" name="action" value="cancel">
                                <input type="hidden" name="maDatPhong" value="<%= chiTiet.getMaDatPhong() %>">
                                <input type="submit" value="Hủy">
                            </form>

                            <form action="BookingConfirmationServlet" method="get">
                                <input type="hidden" name="action" value="close">
                                <input type="submit" value="Đóng">
                            </form>
                        <% } %>
                    </div>
                </td>
            </tr>
        </table>
    </body>
</html>