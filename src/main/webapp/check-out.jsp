<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.BookingDTO"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.UsedServiceDTO"%>

<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<BookingDTO> dsDangO = (List<BookingDTO>) request.getAttribute("dsDangO");
    BookingDTO chiTiet = (BookingDTO) request.getAttribute("chiTiet");
    List<UsedServiceDTO> dsDichVuDaThem = (List<UsedServiceDTO>) request.getAttribute("dsDichVuDaThem");

    Double tongTienPhong = (Double) request.getAttribute("tongTienPhong");
    Double tongTienDV = (Double) request.getAttribute("tongTienDV");
    Double tongThanhToan = (Double) request.getAttribute("tongThanhToan");

    String message = (String) request.getAttribute("message");
    String customerInformation = request.getAttribute("customerInformation") != null
            ? request.getAttribute("customerInformation").toString()
            : "";
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Check-out</title>
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

            .summary-box {
                border: 1px solid #ccc;
                padding: 10px;
                margin-top: 10px;
                background: #fafafa;
            }
        </style>
    </head>
    <body>
        <h1>Quy trình Check-out</h1>

        <p>Xin chào, <b><%= user %></b></p>
        <a href="main-employee.jsp">Quay về Dashboard</a>

        <hr>

        <form action="CheckOutServlet" method="get">
            <label>Tìm kiếm khách hàng đang ở</label>
            <input type="text" name="customerInformation" placeholder="SĐT hoặc số CCCD..." value="<%= customerInformation %>">
            <button type="submit" name="action" value="search">Tìm khách hàng</button>
        </form>

        <hr>

        <% if (message != null) { %>
            <p><b><%= message %></b></p>
            <hr>
        <% } %>

        <table class="booking-layout">
            <tr>
                <td width="45%" class="left-panel">
                    <h2>Danh sách phiếu đặt đang ở</h2>

                    <div class="scroll-box">
                        <%
                            if (dsDangO == null || dsDangO.isEmpty()) {
                        %>
                            <p>Không có phiếu đặt nào đang ở để check-out.</p>
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
                                    <th>Thao tác</th>
                                </tr>

                                <%
                                    for (BookingDTO dp : dsDangO) {
                                %>
                                <tr>
                                    <td><%= dp.getMaDatPhong() %></td>
                                    <td><%= dp.getMaKH() %></td>
                                    <td><%= dp.getMaPhong() %></td>
                                    <td><%= dp.getNgayNhanDuKien() %></td>
                                    <td><%= dp.getNgayTraDuKien() %></td>
                                    <td>
                                        <form action="CheckOutServlet" method="get">
                                            <input type="hidden" name="action" value="view">
                                            <input type="hidden" name="maDatPhong" value="<%= dp.getMaDatPhong() %>">
                                            <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
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

                <td width="55%" class="right-panel">
                    <h2>Chi tiết phiếu đặt</h2>

                    <div class="scroll-box">
                        <% if (chiTiet == null) { %>
                            <p>Chọn một phiếu đặt để xem chi tiết.</p>
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
                            <p>Số phòng: <%= chiTiet.getSoPhong() %></p>
                            <p>Loại phòng: <%= chiTiet.getTenLoaiPhong() %></p>
                            <p>Số người tối đa: <%= chiTiet.getSoNguoiToiDa() %></p>
                            <p>Giá cơ bản: <%= chiTiet.getGiaCoBan() %></p>
                            <p>Mô tả: <%= chiTiet.getMoTaLoaiPhong() %></p>

                            <hr>

                            <h3>Dịch vụ đã sử dụng</h3>
                            <%
                                if (dsDichVuDaThem == null || dsDichVuDaThem.isEmpty()) {
                            %>
                                <p>Phiếu đặt này chưa có dịch vụ nào.</p>
                            <%
                                } else {
                            %>
                                <table border="1" cellpadding="5" cellspacing="0" width="100%">
                                    <tr>
                                        <th>Tên dịch vụ</th>
                                        <th>Số lượng</th>
                                        <th>Đơn giá</th>
                                        <th>Thành tiền</th>
                                        <th>Thời gian sử dụng</th>
                                    </tr>
                                    <%
                                        for (UsedServiceDTO item : dsDichVuDaThem) {
                                    %>
                                    <tr>
                                        <td><%= item.getTenDV() %></td>
                                        <td><%= item.getSoLuong() %></td>
                                        <td><%= item.getDonGia() %></td>
                                        <td><%= item.getThanhTien() %></td>
                                        <td><%= item.getThoiGianSuDung() %></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </table>
                            <%
                                }
                            %>

                            <div class="summary-box">
                                <h3>Tổng kết hóa đơn tạm tính</h3>
                                <p>Tiền phòng: <b><%= tongTienPhong != null ? tongTienPhong : 0 %></b></p>
                                <p>Tiền dịch vụ: <b><%= tongTienDV != null ? tongTienDV : 0 %></b></p>
                                <p>Tổng thanh toán: <b><%= tongThanhToan != null ? tongThanhToan : 0 %></b></p>
                            </div>

                        <% } %>
                    </div>

                    <div class="action-box">
                        <% if (chiTiet != null) { %>
                            <form action="CheckOutServlet" method="post">
                                <input type="hidden" name="action" value="checkout">
                                <input type="hidden" name="maDatPhong" value="<%= chiTiet.getMaDatPhong() %>">
                                <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
                                <input type="submit" value="Check-out"
                                       onclick="return confirm('Xác nhận check-out cho khách này?');">
                            </form>

                            <form action="CheckOutServlet" method="get">
                                <input type="hidden" name="action" value="close">
                                <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
                                <input type="submit" value="Đóng">
                            </form>
                        <% } %>
                    </div>
                </td>
            </tr>
        </table>
    </body>
</html>