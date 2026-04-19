<%@page import="java.util.List"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.RevenueDetailDTO"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.TopRoomDTO"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.TopServiceDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // =========================
    // Dữ liệu cũ của trang doanh thu
    // =========================
    String tuNgay = request.getAttribute("tuNgay") != null ? request.getAttribute("tuNgay").toString() : "";
    String denNgay = request.getAttribute("denNgay") != null ? request.getAttribute("denNgay").toString() : "";
    String thang = request.getAttribute("thang") != null ? request.getAttribute("thang").toString() : "";
    String nam = request.getAttribute("nam") != null ? request.getAttribute("nam").toString() : "";

    BigDecimal tongDoanhThu = request.getAttribute("tongDoanhThu") != null
            ? (BigDecimal) request.getAttribute("tongDoanhThu")
            : BigDecimal.ZERO;

    BigDecimal doanhThuPhong = request.getAttribute("doanhThuPhong") != null
            ? (BigDecimal) request.getAttribute("doanhThuPhong")
            : BigDecimal.ZERO;

    BigDecimal doanhThuDichVu = request.getAttribute("doanhThuDichVu") != null
            ? (BigDecimal) request.getAttribute("doanhThuDichVu")
            : BigDecimal.ZERO;

    List<RevenueDetailDTO> hoaDonList = (List<RevenueDetailDTO>) request.getAttribute("hoaDonList");

    // =========================
    // Dữ liệu mới: top 3 phòng / top 3 dịch vụ
    // =========================
    List<TopRoomDTO> top3Phong = (List<TopRoomDTO>) request.getAttribute("top3Phong");
    List<TopServiceDTO> top3DichVu = (List<TopServiceDTO>) request.getAttribute("top3DichVu");

    // =========================
    // Thông báo từ server
    // Ghi chú:
    // Dùng để hiển thị thông báo kiểu:
    // "Hệ thống đã ưu tiên lọc theo Từ ngày - Đến ngày, nên Tháng/Năm đã được bỏ qua."
    // =========================
    String infoMessage = request.getAttribute("infoMessage") != null
            ? request.getAttribute("infoMessage").toString()
            : "";
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thống kê doanh thu</title>

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f7fa;
                margin: 0;
                padding: 20px;
                color: #333;
            }

            h1, h2, h3 {
                margin-top: 0;
                color: #1f3b5b;
            }

            a {
                text-decoration: none;
                color: #0b57d0;
            }

            a:hover {
                text-decoration: underline;
            }

            .page-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 16px 0;
            }

            .left-panel,
            .right-panel {
                vertical-align: top;
                background: #ffffff;
                border: 1px solid #dbe3ec;
                border-radius: 10px;
                padding: 16px;
            }

            .left-panel {
                width: 75%;
            }

            .right-panel {
                width: 25%;
            }

            .top-link {
                margin-bottom: 16px;
                display: inline-block;
                font-weight: bold;
            }

            .filter-form {
                background: #f8fbff;
                border: 1px solid #d6e4f0;
                padding: 14px;
                border-radius: 8px;
                margin-bottom: 12px;
            }

            .filter-form label {
                font-weight: bold;
                margin-right: 6px;
            }

            .filter-form input,
            .filter-form select {
                padding: 6px 8px;
                margin-right: 10px;
                margin-bottom: 8px;
                border: 1px solid #c8d4e0;
                border-radius: 6px;
            }

            .filter-form button {
                padding: 7px 14px;
                border: 1px solid #b9c7d6;
                border-radius: 6px;
                background: #eaf2fb;
                cursor: pointer;
                font-weight: bold;
                margin-right: 6px;
            }

            .filter-form button:hover {
                background: #dcecff;
            }

            .info-box {
                margin-top: 0;
                margin-bottom: 16px;
                padding: 12px 14px;
                border: 1px solid #b7d7f7;
                background: #eef7ff;
                color: #0b4f8a;
                border-radius: 8px;
                font-weight: bold;
            }

            .summary-table,
            .detail-table {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
            }

            .summary-table td,
            .detail-table th,
            .detail-table td {
                border: 1px solid #d6e0ea;
                padding: 10px;
            }

            .summary-table {
                margin-bottom: 20px;
            }

            .summary-table td {
                text-align: center;
                background: #f9fcff;
            }

            .summary-title {
                display: block;
                font-weight: bold;
                margin-bottom: 6px;
                color: #234;
            }

            .summary-value {
                font-size: 18px;
                font-weight: bold;
                color: #0d4f8b;
            }

            .detail-table thead th {
                background: #eaf2fb;
                color: #1f3b5b;
                text-align: center;
            }

            .detail-table tbody tr:nth-child(even) {
                background: #fafcff;
            }

            .detail-table tbody tr:hover {
                background: #f1f7ff;
            }

            .right-box {
                border: 1px solid #d6e4f0;
                border-radius: 8px;
                padding: 12px;
                background: #f8fbff;
                margin-bottom: 20px;
            }

            .right-box h3 {
                margin-bottom: 12px;
                border-bottom: 1px solid #d6e4f0;
                padding-bottom: 8px;
            }

            .top-list {
                list-style: none;
                padding-left: 0;
                margin: 0;
            }

            .top-list li {
                padding: 10px 8px;
                border-bottom: 1px solid #e1e8ef;
                line-height: 1.6;
            }

            .top-list li:last-child {
                border-bottom: none;
            }

            .item-name {
                font-weight: bold;
            }

            .item-value {
                color: #0d4f8b;
                font-weight: bold;
            }

            .empty-data {
                color: #888;
                font-style: italic;
                text-align: center;
            }

            .section-title {
                margin-top: 10px;
                margin-bottom: 12px;
            }
        </style>
    </head>

    <body>
        <table class="page-table">
            <tr>
                <!-- CỘT BÊN TRÁI -->
                <td class="left-panel">

                    <h1>Thông kê doanh thu</h1>

                    <div>
                        <a class="top-link" href="main.jsp">Trang chủ</a>
                    </div>

                    <form class="filter-form" action="RevenueDetailServlet" method="get">
                        <label for="tuNgay">Từ ngày:</label>
                        <input type="date" id="tuNgay" name="tuNgay" value="<%= tuNgay %>">

                        <label for="denNgay">Đến ngày:</label>
                        <input type="date" id="denNgay" name="denNgay" value="<%= denNgay %>">

                        <label for="thang">Tháng:</label>
                        <select name="thang" id="thang">
                            <option value="">--Chọn tháng--</option>
                            <%
                                for (int i = 1; i <= 12; i++) {
                            %>
                            <option value="<%= i %>" <%= String.valueOf(i).equals(thang) ? "selected" : "" %>>
                                <%= i %>
                            </option>
                            <%
                                }
                            %>
                        </select>

                        <label for="nam">Năm</label>
                        <input type="number" id="nam" name="nam" value="<%= nam %>" min="2000" max="2100" placeholder="Nhập năm"/>

                        <button type="submit" name="action" value="filter">Tìm kiếm</button>
                        <button type="reset">Clear</button>
                    </form>

                    <%
                        if (!infoMessage.isEmpty()) {
                    %>
                    <div class="info-box"><%= infoMessage %></div>
                    <%
                        }
                    %>

                    <table class="summary-table">
                        <tr>
                            <td>
                                <span class="summary-title">Tổng doanh thu</span>
                                <span class="summary-value"><%= tongDoanhThu %></span>
                            </td>
                            <td>
                                <span class="summary-title">Doanh thu phòng</span>
                                <span class="summary-value"><%= doanhThuPhong %></span>
                            </td>
                            <td>
                                <span class="summary-title">Doanh thu dịch vụ</span>
                                <span class="summary-value"><%= doanhThuDichVu %></span>
                            </td>
                        </tr>
                    </table>

                    <h2 class="section-title">Danh sách hóa đơn chi tiết</h2>

                    <table class="detail-table">
                        <thead>
                            <tr>
                                <th>Mã hóa đơn</th>
                                <th>Mã nhân viên</th>
                                <th>Mã khách hàng</th>
                                <th>Tên nhân viên</th>
                                <th>Tên khách hàng</th>
                                <th>Ngày lập</th>
                                <th>Tiền phòng</th>
                                <th>Tiền dịch vụ</th>
                                <th>Tổng thanh toán</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (hoaDonList != null && !hoaDonList.isEmpty()) {
                                    for (RevenueDetailDTO hd : hoaDonList) {
                            %>
                            <tr>
                                <td><%= hd.getMaHoaDon() %></td>
                                <td><%= hd.getMaNV() %></td>
                                <td><%= hd.getMaKH() %></td>
                                <td><%= hd.getTenNV() %></td>
                                <td><%= hd.getTenKH() %></td>
                                <td><%= hd.getNgayLap() %></td>
                                <td><%= hd.getTongTienPhong() %></td>
                                <td><%= hd.getTongTienDV() %></td>
                                <td><%= hd.getTongThanhToan() %></td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="9" class="empty-data">Không có dữ liệu</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </td>

                <!-- CỘT BÊN PHẢI -->
                <td class="right-panel">
                    <div class="right-box">
                        <h3>Top 3 phòng doanh thu cao nhất</h3>
                        <ul class="top-list">
                            <%
                                if (top3Phong != null && !top3Phong.isEmpty()) {
                                    for (TopRoomDTO p : top3Phong) {
                            %>
                            <li>
                                <a class="item-name" href="RevenueTopDetailServlet?type=room&id=<%= p.getMaPhong() %>&thang=<%= thang %>&nam=<%= nam %>">
                                    <%= p.getTenPhong() %>
                                </a>
                                <br>
                                <span class="item-value"><%= p.getDoanhThu() %></span>
                            </li>
                            <%
                                    }
                                } else {
                            %>
                            <li class="empty-data">Không có dữ liệu</li>
                            <%
                                }
                            %>
                        </ul>
                    </div>

                    <div class="right-box">
                        <h3>Top 3 dịch vụ doanh thu cao nhất</h3>
                        <ul class="top-list">
                            <%
                                if (top3DichVu != null && !top3DichVu.isEmpty()) {
                                    for (TopServiceDTO dv : top3DichVu) {
                            %>
                            <li>
                                <a class="item-name" href="RevenueTopDetailServlet?type=service&id=<%= dv.getMaDV() %>&thang=<%= thang %>&nam=<%= nam %>">
                                    <%= dv.getTenDichVu() %>
                                </a>
                                <br>
                                <span class="item-value"><%= dv.getDoanhThu() %></span>
                            </li>
                            <%
                                    }
                                } else {
                            %>
                            <li class="empty-data">Không có dữ liệu</li>
                            <%
                                }
                            %>
                        </ul>
                    </div>
                </td>
            </tr>
        </table>
    </body>
</html>