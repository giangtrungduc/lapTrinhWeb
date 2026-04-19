<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.PaymentViewDTO"%>

<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<PaymentViewDTO> dsHoaDon = (List<PaymentViewDTO>) request.getAttribute("dsHoaDon");
    PaymentViewDTO chiTiet = (PaymentViewDTO) request.getAttribute("chiTiet");
    String message = (String) request.getAttribute("message");
    String customerInformation = request.getAttribute("customerInformation") != null
            ? request.getAttribute("customerInformation").toString()
            : "";
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thanh toán</title>
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
        <h1>Thanh toán</h1>

        <p>Xin chào, <b><%= user %></b></p>
        <a href="main-employee.jsp">Quay về Dashboard</a>

        <hr>

        <form action="PaymentServlet" method="get">
            <label>Tìm kiếm khách hàng đã check-out</label>
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
                    <h2>Danh sách hóa đơn</h2>

                    <div class="scroll-box">
                        <%
                            if (dsHoaDon == null || dsHoaDon.isEmpty()) {
                        %>
                            <p>Không có hóa đơn nào cần thanh toán.</p>
                        <%
                            } else {
                        %>
                            <table border="1" cellpadding="5" cellspacing="0" width="100%">
                                <tr>
                                    <th>Mã hóa đơn</th>
                                    <th>Mã đặt phòng</th>
                                    <th>Khách hàng</th>
                                    <th>Số phòng</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                    <th>Xem</th>
                                </tr>
                                <%
                                    for (PaymentViewDTO item : dsHoaDon) {
                                %>
                                <tr>
                                    <td><%= item.getMaHoaDon() %></td>
                                    <td><%= item.getMaDatPhong() %></td>
                                    <td><%= item.getTenKhachHang() %></td>
                                    <td><%= item.getSoPhong() %></td>
                                    <td><%= item.getTongThanhToan() %></td>
                                    <td><%= item.getTrangThaiThanhToan() %></td>
                                    <td>
                                        <form action="PaymentServlet" method="get">
                                            <input type="hidden" name="action" value="view">
                                            <input type="hidden" name="maHoaDon" value="<%= item.getMaHoaDon() %>">
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
                    <h2>Chi tiết thanh toán</h2>

                    <div class="scroll-box">
                        <% if (chiTiet == null) { %>
                            <p>Chọn một hóa đơn để xem chi tiết.</p>
                        <% } else { %>

                            <h3>Thông tin hóa đơn</h3>
                            <p>Mã hóa đơn: <%= chiTiet.getMaHoaDon() %></p>
                            <p>Mã đặt phòng: <%= chiTiet.getMaDatPhong() %></p>
                            <p>Ngày đặt: <%= chiTiet.getNgayDat() %></p>
                            <p>Ngày nhận dự kiến: <%= chiTiet.getNgayNhanDuKien() %></p>
                            <p>Ngày trả dự kiến: <%= chiTiet.getNgayTraDuKien() %></p>
                            <p>Ngày trả thực tế: <%= chiTiet.getNgayTraThucTe() %></p>

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

                            <hr>

                            <h3>Thông tin thanh toán</h3>
                            <p>Tiền phòng: <%= chiTiet.getTongTienPhong() %></p>
                            <p>Tiền dịch vụ: <%= chiTiet.getTongTienDV() %></p>
                            <p>Tổng thanh toán: <b><%= chiTiet.getTongThanhToan() %></b></p>
                            <p>Trạng thái: <%= chiTiet.getTrangThaiThanhToan() %></p>

                        <% } %>
                    </div>

                    <div class="action-box">
                        <% if (chiTiet != null) { %>
                            <% if (!"DaThanhToan".equals(chiTiet.getTrangThaiThanhToan())) { %>
                                <form action="PaymentServlet" method="post">
                                    <input type="hidden" name="action" value="pay">
                                    <input type="hidden" name="maHoaDon" value="<%= chiTiet.getMaHoaDon() %>">
                                    <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
                                    <input type="submit" value="Thanh toán"
                                           onclick="return confirm('Xác nhận thanh toán hóa đơn này?');">
                                </form>
                            <% } %>

                            <form action="PaymentServlet" method="get">
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