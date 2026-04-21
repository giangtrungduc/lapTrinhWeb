<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang nhân viên</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
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
                        <span class="bn-nav__welcome">
                            Xin chào, <strong><%= user %></strong>
                        </span>
                        <form action="LogoutServlet" method="get" class="bn-inline-form">
                            <button type="submit" class="bn-btn bn-btn--ghost">Đăng xuất</button>
                        </form>
                    </div>
                </div>
            </nav>

            <!-- Dark Hero Header -->
            <section class="bn-hero">
                <div class="bn-hero__inner">
                    <div class="bn-hero__eyebrow">Khu vực lễ tân</div>
                    <h1 class="bn-hero__title">
                        Trang <span class="accent">Nhân viên</span>
                    </h1>
                    <p class="bn-hero__subtitle">
                        Xử lý quy trình đặt phòng, check-in, check-out và thanh toán cho khách —
                        nhanh gọn, chính xác, trong một luồng công việc duy nhất.
                    </p>
                </div>
            </section>

            <!-- Function Grid -->
            <main class="bn-container bn-container--overlap">
                <h2 class="bn-section-title">Chức năng</h2>
                <p class="bn-section-subtitle">Các thao tác phục vụ khách hàng</p>

                <div class="bn-grid">

                    <!-- Đặt phòng -->
                    <article class="bn-card">
                        <div class="bn-card__icon">📅</div>
                        <h3 class="bn-card__title">Đặt phòng</h3>
                        <p class="bn-card__desc">
                            Tạo đơn đặt phòng mới cho khách hàng, chọn loại phòng và khoảng thời gian lưu trú.
                        </p>
                        <form action="BookingByStaff" method="get" class="bn-card__form">
                            <input type="hidden" name="action" value="list">
                            <button type="submit" class="bn-btn bn-btn--primary bn-btn--block">
                                Bắt đầu
                            </button>
                        </form>
                    </article>

                    <!-- Xác nhận đặt phòng -->
                    <article class="bn-card">
                        <div class="bn-card__icon">✅</div>
                        <h3 class="bn-card__title">Xác nhận đặt phòng</h3>
                        <p class="bn-card__desc">
                            Duyệt các đơn đặt phòng đang chờ, xác nhận hoặc huỷ theo yêu cầu khách hàng.
                        </p>
                        <form action="BookingConfirmationServlet" method="get" class="bn-card__form">
                            <input type="hidden" name="action" value="list">
                            <button type="submit" class="bn-btn bn-btn--primary bn-btn--block">
                                Mở danh sách
                            </button>
                        </form>
                    </article>

                    <!-- Check-in -->
                    <article class="bn-card">
                        <div class="bn-card__icon">🔑</div>
                        <h3 class="bn-card__title">Check-in</h3>
                        <p class="bn-card__desc">
                            Tiếp nhận khách đến, ghi nhận giấy tờ và bàn giao phòng đúng quy trình.
                        </p>
                        <form action="CheckInServlet" method="get" class="bn-card__form">
                            <input type="hidden" name="action" value="list">
                            <button type="submit" class="bn-btn bn-btn--primary bn-btn--block">
                                Thực hiện
                            </button>
                        </form>
                    </article>

                    <!-- Dịch vụ -->
                    <article class="bn-card">
                        <div class="bn-card__icon">🛎️</div>
                        <h3 class="bn-card__title">Dịch vụ</h3>
                        <p class="bn-card__desc">
                            Ghi nhận các dịch vụ khách sử dụng trong quá trình lưu trú để tính phí.
                        </p>
                        <form action="ServiceServlet" method="get" class="bn-card__form">
                            <input type="hidden" name="action" value="list">
                            <button type="submit" class="bn-btn bn-btn--primary bn-btn--block">
                                Thêm dịch vụ
                            </button>
                        </form>
                    </article>

                    <!-- Check-out -->
                    <article class="bn-card">
                        <div class="bn-card__icon">🚪</div>
                        <h3 class="bn-card__title">Check-out</h3>
                        <p class="bn-card__desc">
                            Kiểm tra phòng khi khách trả, tổng hợp chi phí phát sinh trước khi thanh toán.
                        </p>
                        <form action="CheckOutServlet" method="get" class="bn-card__form">
                            <input type="hidden" name="action" value="list">
                            <button type="submit" class="bn-btn bn-btn--primary bn-btn--block">
                                Thực hiện
                            </button>
                        </form>
                    </article>

                    <!-- Thanh toán -->
                    <article class="bn-card">
                        <div class="bn-card__icon">💳</div>
                        <h3 class="bn-card__title">Thanh toán</h3>
                        <p class="bn-card__desc">
                            Xuất hoá đơn và ghi nhận các giao dịch thanh toán từ khách hàng.
                        </p>
                        <form action="PaymentServlet" method="get" class="bn-card__form">
                            <input type="hidden" name="action" value="list">
                            <button type="submit" class="bn-btn bn-btn--primary bn-btn--block">
                                Mở thanh toán
                            </button>
                        </form>
                    </article>

                </div>
            </main>

            <!-- Footer -->
            <footer class="bn-footer">
                &copy; 2026 <strong>Hotel Staff</strong> · Hệ thống quản lý nội bộ
            </footer>

        </div>
    </body>
</html>
