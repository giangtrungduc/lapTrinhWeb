<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        <title>Trang quản lý</title>
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
                        <span>Hotel Admin</span>
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
                    <div class="bn-hero__eyebrow">Bảng điều khiển quản trị</div>
                    <h1 class="bn-hero__title">
                        Trang <span class="accent">Quản lý</span>
                    </h1>
                    <p class="bn-hero__subtitle">
                        Điều hành toàn bộ hoạt động khách sạn — từ khách hàng, nhân viên,
                        phòng ốc cho đến dịch vụ và doanh thu — tại một nơi duy nhất.
                    </p>
                </div>
            </section>

            <!-- Function Grid -->
            <main class="bn-container bn-container--overlap">
                <h2 class="bn-section-title">Chức năng</h2>
                <p class="bn-section-subtitle">Chọn một module để bắt đầu</p>

                <div class="bn-grid">

                    <!-- Khách hàng -->
                    <article class="bn-card">
                        <div class="bn-card__icon">👥</div>
                        <h3 class="bn-card__title">Quản lý khách hàng</h3>
                        <p class="bn-card__desc">
                            Xem danh sách, thêm mới và cập nhật thông tin khách hàng đã lưu trong hệ thống.
                        </p>
                        <form action="CustomerServlet" method="get" class="bn-card__form">
                            <input type="hidden" name="action" value="list">
                            <button type="submit" class="bn-btn bn-btn--primary bn-btn--block">
                                Truy cập
                            </button>
                        </form>
                    </article>

                    <!-- Nhân viên -->
                    <article class="bn-card">
                        <div class="bn-card__icon">🧑‍💼</div>
                        <h3 class="bn-card__title">Quản lý nhân viên</h3>
                        <p class="bn-card__desc">
                            Phân quyền, theo dõi ca làm và quản lý thông tin đội ngũ nhân viên lễ tân.
                        </p>
                        <form action="EmployeeServlet" method="get" class="bn-card__form">
                            <input type="hidden" name="action" value="list">
                            <button type="submit" class="bn-btn bn-btn--primary bn-btn--block">
                                Truy cập
                            </button>
                        </form>
                    </article>

                    <!-- Phòng & loại phòng -->
                    <article class="bn-card">
                        <div class="bn-card__icon">🏨</div>
                        <h3 class="bn-card__title">Phòng &amp; loại phòng</h3>
                        <p class="bn-card__desc">
                            Cấu hình danh mục phòng, loại phòng, giá tham chiếu và trạng thái sử dụng.
                        </p>
                        <form action="RoomServlet" method="get" class="bn-card__form">
                            <input type="hidden" name="action" value="list">
                            <button type="submit" class="bn-btn bn-btn--primary bn-btn--block">
                                Truy cập
                            </button>
                        </form>
                    </article>

                    <!-- Dịch vụ -->
                    <article class="bn-card">
                        <div class="bn-card__icon">🛎️</div>
                        <h3 class="bn-card__title">Quản lý dịch vụ</h3>
                        <p class="bn-card__desc">
                            Quản lý danh sách dịch vụ đi kèm: spa, giặt ủi, đưa đón, ăn uống…
                        </p>
                        <form action="ServiceManagementServlet" method="get" class="bn-card__form">
                            <input type="hidden" name="action" value="list">
                            <button type="submit" class="bn-btn bn-btn--primary bn-btn--block">
                                Truy cập
                            </button>
                        </form>
                    </article>

                    <!-- Doanh thu -->
                    <article class="bn-card">
                        <div class="bn-card__icon">📊</div>
                        <h3 class="bn-card__title">Thống kê doanh thu</h3>
                        <p class="bn-card__desc">
                            Báo cáo doanh thu theo ngày, tháng, quý — phân tích chi tiết từng nguồn thu.
                        </p>
                        <form action="RevenueDetailServlet" method="get" class="bn-card__form">
                            <input type="hidden" name="action" value="list">
                            <button type="submit" class="bn-btn bn-btn--primary bn-btn--block">
                                Truy cập
                            </button>
                        </form>
                    </article>

                </div>
            </main>

            <!-- Footer -->
            <footer class="bn-footer">
                &copy; 2026 <strong>Hotel Admin</strong> · Hệ thống quản lý nội bộ
            </footer>

        </div>
    </body>
</html>
