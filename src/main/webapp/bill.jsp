<%@page import="com.mycompany.laptrinhweb.model.dto.InvoiceServiceDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.BillDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lập hoá đơn</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/binance-style.css">
    </head>
    <body>
        <div class="app-shell">

            <nav class="bn-nav">
                <div class="bn-nav__inner">
                    <div class="bn-nav__brand">
                        <div class="bn-nav__logo-mark"><span>H</span></div>
                        <span>Hotel Staff</span>
                    </div>
                    <div class="bn-nav__user">
                        <a href="main.jsp" class="bn-btn bn-btn--ghost">
                            <i class="fa-solid fa-house"></i>
                            Trang chính
                        </a>
                    </div>
                </div>
            </nav>

            <main class="bn-container">

                <a href="main.jsp" class="bn-back-link">
                    <i class="fa-solid fa-arrow-left"></i>
                    Quay về trang chủ
                </a>

                <div class="bn-page-header">
                    <div>
                        <h1 class="bn-page-header__title">
                            <i class="fa-solid fa-file-invoice-dollar" style="color: var(--bn-yellow);"></i>
                            Lập hoá đơn
                        </h1>
                        <p class="bn-page-header__subtitle">
                            Tìm phiếu đặt phòng và xuất hoá đơn thanh toán cho khách
                        </p>
                    </div>
                </div>

                <!-- SEARCH BAR -->
                <div class="bn-panel">
                    <div class="bn-panel__head">
                        <div class="bn-panel__title">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            Tìm phiếu đặt phòng
                        </div>
                    </div>

                    <form action="FindBookingServlet" method="post" class="bn-search" style="max-width: 500px;">
                        <i class="fa-solid fa-receipt bn-search__icon"></i>
                        <input type="text" name="madp"
                               class="bn-search__input"
                               placeholder="Nhập mã đặt phòng...">
                        <button type="submit" class="bn-search__btn">
                            Tìm
                        </button>
                    </form>
                </div>

                <%
                    String msgf = (String) request.getAttribute("msgf");
                    if (msgf != null) {
                %>
                <div class="bn-alert bn-alert--error" style="margin-bottom: 20px;">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                    <span><%= msgf %></span>
                </div>
                <%
                    } else {
                        BillDTO bill = (BillDTO) request.getAttribute("bill");
                        if (bill != null) {
                %>

                <!-- CUSTOMER + BOOKING INFO -->
                <div class="bn-invoice">
                    <h3 class="bn-invoice__section-title">
                        <i class="fa-solid fa-user"></i>
                        Thông tin đặt phòng
                    </h3>

                    <div class="bn-invoice__info-grid">
                        <div class="bn-invoice__info-row">
                            <span class="bn-invoice__info-label">Khách hàng</span>
                            <span class="bn-invoice__info-value"><%= bill.getHoTen() %></span>
                        </div>
                        <div class="bn-invoice__info-row">
                            <span class="bn-invoice__info-label">SĐT</span>
                            <span class="bn-invoice__info-value"><%= bill.getSdt() %></span>
                        </div>
                        <div class="bn-invoice__info-row">
                            <span class="bn-invoice__info-label">CCCD</span>
                            <span class="bn-invoice__info-value"><%= bill.getCccd() %></span>
                        </div>
                        <div class="bn-invoice__info-row">
                            <span class="bn-invoice__info-label">Email</span>
                            <span class="bn-invoice__info-value"><%= bill.getEmail() %></span>
                        </div>
                    </div>

                    <h3 class="bn-invoice__section-title">
                        <i class="fa-solid fa-bed"></i>
                        Phòng &amp; thời gian
                    </h3>

                    <div class="bn-invoice__info-grid">
                        <div class="bn-invoice__info-row">
                            <span class="bn-invoice__info-label">Phòng</span>
                            <span class="bn-invoice__info-value"><%= bill.getSoPhong() %> — Phòng Deluxe</span>
                        </div>
                        <div class="bn-invoice__info-row">
                            <span class="bn-invoice__info-label">Ngày nhận (dự kiến)</span>
                            <span class="bn-invoice__info-value"><%= bill.getNgayNhanDuKien() %></span>
                        </div>
                        <div class="bn-invoice__info-row">
                            <span class="bn-invoice__info-label">Ngày trả (dự kiến)</span>
                            <span class="bn-invoice__info-value"><%= bill.getNgayTraDuKien() %></span>
                        </div>
                    </div>

                    <!-- ISSUE INVOICE FORM -->
                    <form action="InvoiceServlet" method="post"
                          style="display: flex; gap: 12px; align-items: flex-end; flex-wrap: wrap; padding-top: 16px; border-top: 1px solid var(--bn-border-light);">
                        <input name="madp" type="hidden" value="<%= bill.getMaDatPhong() %>">

                        <div class="bn-field" style="flex: 1; min-width: 220px;">
                            <label class="bn-label" for="ngaytra">
                                <i class="fa-solid fa-calendar-check"></i>
                                Ngày trả thực tế
                            </label>
                            <input type="datetime-local" id="ngaytra" name="ngaytra" class="bn-input">
                        </div>

                        <button type="submit" class="bn-btn bn-btn--primary">
                            <i class="fa-solid fa-file-invoice"></i>
                            Xuất hoá đơn
                        </button>
                    </form>
                </div>

                <%
                    }
                %>

                <%
                    BillDTO bill1 = (BillDTO) request.getAttribute("bill");
                    if (bill1 != null && bill1.getTongTienPhong() != null) {
                %>

                <!-- ROOM CHARGE -->
                <div class="bn-invoice">
                    <h3 class="bn-invoice__section-title">
                        <i class="fa-solid fa-key"></i>
                        Tính tiền phòng
                    </h3>

                    <div class="bn-invoice__info-grid">
                        <div class="bn-invoice__info-row">
                            <span class="bn-invoice__info-label">Giá phòng / đêm</span>
                            <span class="bn-invoice__info-value"><%= bill1.getGiaPhong() %> đ</span>
                        </div>
                        <div class="bn-invoice__info-row">
                            <span class="bn-invoice__info-label">Số đêm</span>
                            <span class="bn-invoice__info-value"><%= bill1.getSoDem() %></span>
                        </div>
                    </div>

                    <div class="bn-invoice__total-row">
                        <span class="bn-invoice__total-label">Tổng tiền phòng</span>
                        <span class="bn-invoice__total-value"><%= bill1.getTongTienPhong() %> đ</span>
                    </div>
                </div>

                <!-- SERVICES -->
                <%
                    List<InvoiceServiceDTO> services = bill1.getServices();
                    BigDecimal tongTienDV = BigDecimal.ZERO;
                %>

                <div class="bn-invoice">
                    <h3 class="bn-invoice__section-title">
                        <i class="fa-solid fa-concierge-bell"></i>
                        Dịch vụ sử dụng
                    </h3>

                    <div class="bn-table-wrap" style="box-shadow: none; margin-bottom: 16px;">
                        <div class="bn-table-scroll">
                            <table class="bn-table bn-table--compact">
                                <thead>
                                    <tr>
                                        <th>Dịch vụ</th>
                                        <th>Đơn giá</th>
                                        <th style="text-align: center;">Số lượng</th>
                                        <th style="text-align: right;">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (services != null && !services.isEmpty()) {
                                            for (InvoiceServiceDTO svc : services) {
                                                BigDecimal thanhTienRow = svc.getDonGia().multiply(new BigDecimal(svc.getSoLuong()));
                                                tongTienDV = tongTienDV.add(thanhTienRow);
                                    %>
                                    <tr>
                                        <td><strong><%= svc.getTenDV() %></strong></td>
                                        <td class="num"><%= svc.getDonGia() %></td>
                                        <td class="num" style="text-align: center;"><%= svc.getSoLuong() %></td>
                                        <td class="num" style="text-align: right;"><%= thanhTienRow %></td>
                                    </tr>
                                    <% } } else { %>
                                    <tr>
                                        <td colspan="4" class="bn-table__empty">
                                            Chưa có dịch vụ nào.
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="bn-invoice__total-row">
                        <span class="bn-invoice__total-label">Tổng tiền dịch vụ</span>
                        <span class="bn-invoice__total-value"><%= tongTienDV %> đ</span>
                    </div>
                </div>

                <!-- GRAND TOTAL -->
                <%
                    BigDecimal tongCuoiCung = bill1.getTongTienPhong().add(tongTienDV);
                %>

                <div class="bn-invoice" style="padding: 24px;">
                    <div class="bn-invoice__grand">
                        <span class="bn-invoice__grand-label">Tổng thanh toán</span>
                        <span class="bn-invoice__grand-value"><%= tongCuoiCung %> đ</span>
                    </div>

                    <div style="display: flex; gap: 12px; justify-content: flex-end; margin-top: 20px; flex-wrap: wrap;">
                        <a href="bill.jsp" class="bn-btn bn-btn--ghost">
                            <i class="fa-solid fa-xmark"></i>
                            Huỷ
                        </a>

                        <form action="SaveInvoiceServlet" method="POST" class="bn-inline-form">
                            <input name="madp" type="hidden" value="<%= bill1.getMaDatPhong() %>">
                            <input name="map" type="hidden" value="<%= bill1.getMaPhong() %>">
                            <input name="tienphong" type="hidden" value="<%= bill1.getTongTienPhong() != null ? bill1.getTongTienPhong() : "0" %>">
                            <input name="tiendv" type="hidden" value="<%= tongTienDV != null ? tongTienDV : "0" %>">

                            <button type="submit" class="bn-btn bn-btn--success">
                                <i class="fa-solid fa-check-double"></i>
                                Lưu hoá đơn &amp; Thanh toán
                            </button>
                        </form>
                    </div>
                </div>

                <%
                        }
                    }
                %>

            </main>

            <footer class="bn-footer">
                &copy; 2026 <strong>Hotel Staff</strong> · Hệ thống quản lý nội bộ
            </footer>

        </div>
    </body>
</html>
