<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomDTO" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomStatus" %>
<%
    List<RoomDTO> roomList = (List<RoomDTO>) request.getAttribute("roomList");
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách phòng · Premium Booking</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/binance-style.css">
        <link rel="stylesheet" href="assets/css/customer-style.css">
    </head>
    <body class="customer-theme">
        <div class="app-shell">

            <!-- Top Navigation (dark premium) -->
            <nav class="bn-nav">
                <div class="bn-nav__inner">
                    <div class="bn-nav__brand">
                        <div class="bn-nav__logo-mark"><span>H</span></div>
                        <div class="bn-nav__brand-text">
                            <span class="bn-nav__brand-main">Hotel</span>
                            <span class="bn-nav__brand-sub">Premium Booking</span>
                        </div>
                    </div>
                    <div class="bn-nav__user">
                        <a href="login.jsp" class="bn-btn bn-btn--ghost">
                            <i class="fa-solid fa-right-to-bracket"></i>
                            Đăng nhập
                        </a>
                    </div>
                </div>
            </nav>

            <!-- HERO -->
            <section class="customer-hero">
                <div class="customer-hero__inner">
                    <a href="login.jsp" class="bn-back-link">
                        <i class="fa-solid fa-arrow-left"></i>
                        Quay lại trang chính
                    </a>

                    <span class="customer-hero__badge">
                        Premium Experience
                    </span>

                    <h1 class="customer-hero__title">
                        Khám phá những <span class="accent">căn phòng</span> dành riêng cho bạn
                    </h1>
                    <p class="customer-hero__subtitle">
                        Lựa chọn một phòng trống, tận hưởng kỳ lưu trú đẳng cấp với dịch vụ tận tâm và không gian tinh tế.
                    </p>
                </div>
            </section>

            
            <main class="bn-container bn-container--after-hero bn-container--overlap">

                <% if (message != null && !message.isEmpty()) { %>
                    <div class="bn-alert bn-alert--info" style="margin-bottom: 20px;">
                        <i class="fa-solid fa-circle-info"></i>
                        <span><%= message %></span>
                    </div>
                <% } %>

                <div class="bn-table-wrap">
                    <div class="bn-table-scroll">
                        <table class="bn-table">
                            <thead>
                                <tr>
                                    <th>Số phòng</th>
                                    <th>Loại phòng</th>
                                    <th>Số người tối đa</th>
                                    <th>Giá cơ bản (VNĐ)</th>
                                    <th>Trạng thái</th>
                                    <th style="text-align: right;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (roomList != null && !roomList.isEmpty()) {
                                        for (RoomDTO room : roomList) {
                                            RoomStatus tt = room.getTrangthai();

                                            // Map trạng thái sang class badge
                                            String badgeClass = "bn-badge--neutral";
                                            if (tt == RoomStatus.BaoTri) {
                                                badgeClass = "bn-badge--danger";
                                            } else if ("Trống".equalsIgnoreCase(tt.getDisplayName())
                                                    || "Available".equalsIgnoreCase(tt.name())) {
                                                badgeClass = "bn-badge--success";
                                            } else {
                                                badgeClass = "bn-badge--warning";
                                            }
                                %>
                                <tr>
                                    <td><strong><%= room.getSophong() %></strong></td>
                                    <td><%= room.getTenloaiphong() %></td>
                                    <td class="num"><%= room.getSonguoitoida() %></td>
                                    <td class="num"><%= String.format("%,.0f", room.getGia()) %></td>
                                    <td>
                                        <span class="bn-badge <%= badgeClass %>">
                                            <%= tt.getDisplayName() %>
                                        </span>
                                    </td>
                                    <td style="text-align: right;">
                                        <% if (tt == RoomStatus.BaoTri) { %>
                                            <span class="muted">Không thể đặt</span>
                                        <% } else { %>
                                            <a class="bn-btn bn-btn--primary"
                                               href="BookingByCustomer?action=showBookingForm&maPhong=<%= room.getMaphong() %>">
                                                <i class="fa-solid fa-calendar-plus"></i>
                                                Đặt phòng
                                            </a>
                                        <% } %>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="6" class="bn-table__empty">
                                        <i class="fa-solid fa-bed" style="font-size: 24px; display: block; margin-bottom: 8px; color: var(--bn-slate);"></i>
                                        Chưa có phòng nào trong hệ thống
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </main>

            <!-- Footer (customer tone) -->
            <footer class="bn-footer">
                <span class="bn-footer__tagline">Premium Booking Experience</span>
                &copy; 2026 <strong>Hotel</strong> · Cảm ơn quý khách đã lựa chọn chúng tôi
            </footer>

        </div>
    </body>
</html>
