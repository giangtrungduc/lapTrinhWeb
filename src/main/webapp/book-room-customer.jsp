<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomDTO" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomBookingStatusDTO" %>
<%
    RoomDTO room = (RoomDTO) request.getAttribute("room");
    List<RoomBookingStatusDTO> existingBookings =
        (List<RoomBookingStatusDTO>) request.getAttribute("existingBookings");
    String error = (String) request.getAttribute("error");

    if (room == null) {
        response.sendRedirect("BookingByCustomer?action=list");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đặt phòng <%= room.getSophong() %> · Premium Booking</title>
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
                    <a href="BookingByCustomer?action=list" class="bn-back-link">
                        <i class="fa-solid fa-arrow-left"></i>
                        Quay lại danh sách phòng
                    </a>

                    <span class="customer-hero__badge">
                        Hoàn tất đặt phòng
                    </span>

                    <h1 class="customer-hero__title">
                        Đặt phòng số <span class="accent"><%= room.getSophong() %></span>
                    </h1>
                    <p class="customer-hero__subtitle">
                        Kiểm tra thông tin phòng và điền thông tin cá nhân để xác nhận kỳ lưu trú của bạn. Chúng tôi sẽ sớm liên hệ lại.
                    </p>
                </div>
            </section>

            <!-- Content -->
            <main class="bn-container bn-container--after-hero bn-container--overlap">

                <!-- ROOM INFO PANEL -->
                <div class="bn-info-panel" style="margin-bottom: 24px;">
                    <div class="bn-info-panel__head">
                        <div class="bn-info-panel__title">
                            <i class="fa-solid fa-bed"></i>
                            Thông tin phòng
                        </div>
                        <%
                            String stDisplay = room.getTrangthai().getDisplayName();
                            String stClass = "bn-badge--success";
                            if ("Đang sử dụng".equalsIgnoreCase(stDisplay)
                                || "Đã đặt".equalsIgnoreCase(stDisplay)) {
                                stClass = "bn-badge--warning";
                            } else if ("Bảo trì".equalsIgnoreCase(stDisplay)) {
                                stClass = "bn-badge--danger";
                            }
                        %>
                        <span class="bn-badge <%= stClass %>"><%= stDisplay %></span>
                    </div>

                    <div class="bn-info-grid">
                        <div class="bn-info-grid__item">
                            <span class="bn-info-grid__label">Số phòng</span>
                            <span class="bn-info-grid__value"><%= room.getSophong() %></span>
                        </div>
                        <div class="bn-info-grid__item">
                            <span class="bn-info-grid__label">Loại phòng</span>
                            <span class="bn-info-grid__value"><%= room.getTenloaiphong() %></span>
                        </div>
                        <div class="bn-info-grid__item">
                            <span class="bn-info-grid__label">Số người tối đa</span>
                            <span class="bn-info-grid__value"><%= room.getSonguoitoida() %></span>
                        </div>
                        <div class="bn-info-grid__item">
                            <span class="bn-info-grid__label">Giá / đêm</span>
                            <span class="bn-info-grid__value bn-info-grid__value--accent">
                                <%= String.format("%,.0f", room.getGia()) %> <small style="font-size:12px; color:var(--bn-slate); font-weight:500;">VNĐ</small>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- EXISTING BOOKINGS -->
                <% if (existingBookings != null && !existingBookings.isEmpty()) { %>
                <div class="bn-info-panel" style="margin-bottom: 24px;">
                    <div class="bn-info-panel__head">
                        <div class="bn-info-panel__title">
                            <i class="fa-solid fa-calendar-xmark" style="color: var(--bn-red);"></i>
                            Khoảng thời gian đã có người đặt
                        </div>
                    </div>

                    <div class="bn-table-scroll">
                        <table class="bn-table" style="border-radius: 8px; overflow: hidden;">
                            <thead>
                                <tr>
                                    <th>Ngày nhận dự kiến</th>
                                    <th>Ngày trả dự kiến</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (RoomBookingStatusDTO b : existingBookings) { %>
                                <tr>
                                    <td class="num"><%= b.getNgayNhanDuKien() %></td>
                                    <td class="num"><%= b.getNgayTraDuKien() %></td>
                                    <td>
                                        <span class="bn-badge bn-badge--warning">
                                            <%= b.getTrangThai() %>
                                        </span>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <% } %>

                <!-- ERROR ALERT -->
                <% if (error != null && !error.isEmpty()) { %>
                <div class="bn-alert bn-alert--error" style="margin-bottom: 24px;">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                    <span><%= error %></span>
                </div>
                <% } %>

                <!-- BOOKING FORM -->
                <div class="bn-form-card bn-form-card--wide" style="max-width: none; margin: 0;">
                    <div style="margin-bottom: 24px;">
                        <h2 style="font-size: 20px; font-weight: 700; color: var(--bn-text-primary); margin-bottom: 4px;">
                            <i class="fa-solid fa-pen-to-square" style="color: var(--bn-yellow); margin-right: 8px;"></i>
                            Thông tin đặt phòng
                        </h2>
                        <p style="font-size: 14px; color: var(--bn-slate);">
                            Điền đầy đủ thông tin khách hàng và thời gian lưu trú
                        </p>
                    </div>

                    <form action="BookingByCustomer" method="post" class="bn-form">
                        <input type="hidden" name="action" value="submitBooking" />
                        <input type="hidden" name="maPhong" value="<%= room.getMaphong() %>" />

                        <div class="bn-field">
                            <label class="bn-label" for="hoTen">
                                <i class="fa-solid fa-signature"></i>
                                Họ tên
                                <span class="bn-label__required">*</span>
                            </label>
                            <input type="text" id="hoTen" name="hoTen"
                                   class="bn-input"
                                   placeholder="VD: Nguyễn Văn A" required>
                        </div>

                        <div class="bn-form__row">
                            <div class="bn-field">
                                <label class="bn-label" for="cccd">
                                    <i class="fa-solid fa-id-card"></i>
                                    CCCD
                                    <span class="bn-label__required">*</span>
                                </label>
                                <input type="text" id="cccd" name="cccd"
                                       class="bn-input"
                                       placeholder="12 số CCCD" required>
                            </div>

                            <div class="bn-field">
                                <label class="bn-label" for="sdt">
                                    <i class="fa-solid fa-phone"></i>
                                    Số điện thoại
                                    <span class="bn-label__required">*</span>
                                </label>
                                <input type="text" id="sdt" name="sdt"
                                       class="bn-input"
                                       placeholder="0912345678" required>
                            </div>
                        </div>

                        <div class="bn-form__row">
                            <div class="bn-field">
                                <label class="bn-label" for="email">
                                    <i class="fa-solid fa-envelope"></i>
                                    Email
                                </label>
                                <input type="email" id="email" name="email"
                                       class="bn-input"
                                       placeholder="example@gmail.com">
                            </div>

                            <div class="bn-field">
                                <label class="bn-label" for="diaChi">
                                    <i class="fa-solid fa-location-dot"></i>
                                    Địa chỉ
                                </label>
                                <input type="text" id="diaChi" name="diaChi"
                                       class="bn-input"
                                       placeholder="Thành phố, Quận/Huyện">
                            </div>
                        </div>

                        <div class="bn-form__row">
                            <div class="bn-field">
                                <label class="bn-label" for="ngayNhan">
                                    <i class="fa-solid fa-calendar-plus"></i>
                                    Ngày nhận phòng
                                    <span class="bn-label__required">*</span>
                                </label>
                                <input type="datetime-local" id="ngayNhan" name="ngayNhan"
                                       class="bn-input" required>
                            </div>

                            <div class="bn-field">
                                <label class="bn-label" for="ngayTra">
                                    <i class="fa-solid fa-calendar-xmark"></i>
                                    Ngày trả phòng
                                    <span class="bn-label__required">*</span>
                                </label>
                                <input type="datetime-local" id="ngayTra" name="ngayTra"
                                       class="bn-input" required>
                            </div>
                        </div>

                        <div class="bn-form__actions bn-form__actions--right">
                            <a href="BookingByCustomer?action=list" class="bn-btn bn-btn--ghost">
                                <i class="fa-solid fa-xmark"></i>
                                Huỷ
                            </a>
                            <button type="submit" class="bn-btn bn-btn--primary">                              
                                <i class="fa-solid fa-check"></i>
                                Xác nhận đặt phòng
                            </button>
                        </div>
                    </form>
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
