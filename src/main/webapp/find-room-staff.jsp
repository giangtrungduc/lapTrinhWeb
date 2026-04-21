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
        <title>Danh sách phòng</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/binance-style.css">
    </head>
    <body>
        <div class="app-shell">

            <!-- Top Navigation -->
            <nav class="bn-nav">
                <div class="bn-nav__inner">
                    <div class="bn-nav__brand">
                        <div class="bn-nav__logo-mark"><span>H</span></div>
                        <span>Hotel Staff</span>
                    </div>
                    <div class="bn-nav__user">
                        <a href="main-employee.jsp" class="bn-btn bn-btn--ghost">
                            <i class="fa-solid fa-house"></i>
                            Trang chính
                        </a>
                    </div>
                </div>
            </nav>

            <!-- Content -->
            <main class="bn-container">

                <a href="main-employee.jsp" class="bn-back-link">
                    <i class="fa-solid fa-arrow-left"></i>
                    Quay lại trang chính
                </a>

                <div class="bn-page-header">
                    <div>
                        <h1 class="bn-page-header__title">Danh sách phòng khách sạn</h1>
                        <p class="bn-page-header__subtitle">
                            Chọn một phòng trống để tạo đơn đặt phòng cho khách hàng
                        </p>
                    </div>
                </div>

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
                                               href="BookingByStaff?action=showBookingForm&maPhong=<%= room.getMaphong() %>">
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

            <!-- Footer -->
            <footer class="bn-footer">
                &copy; 2026 <strong>Hotel Staff</strong> · Hệ thống quản lý nội bộ
            </footer>

        </div>
    </body>
</html>
