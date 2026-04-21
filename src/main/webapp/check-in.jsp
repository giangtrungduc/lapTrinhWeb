<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.BookingDTO"%>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<BookingDTO> dsDaDat = (List<BookingDTO>) request.getAttribute("dsDaDat");
    BookingDTO chiTiet = (BookingDTO) request.getAttribute("chiTiet");
    String message = (String) request.getAttribute("message");
    String customerInformation = request.getAttribute("customerInformation") != null
            ? request.getAttribute("customerInformation").toString()
            : "";
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Check-in</title>
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
                        <span class="bn-nav__welcome">
                            Xin chào, <strong><%= user %></strong>
                        </span>
                        <a href="main-employee.jsp" class="bn-btn bn-btn--ghost">
                            <i class="fa-solid fa-house"></i>
                            Trang chính
                        </a>
                    </div>
                </div>
            </nav>

            <main class="bn-container">

                <a href="main-employee.jsp" class="bn-back-link">
                    <i class="fa-solid fa-arrow-left"></i>
                    Quay về Dashboard
                </a>

                <div class="bn-page-header">
                    <div>
                        <h1 class="bn-page-header__title">
                            <i class="fa-solid fa-key" style="color: var(--bn-yellow);"></i>
                            Quy trình Check-in
                        </h1>
                        <p class="bn-page-header__subtitle">
                            Tìm khách hàng đã đặt phòng và xác nhận nhận phòng
                        </p>
                    </div>
                </div>

                <!-- SEARCH -->
                <form action="CheckInServlet" method="get" class="bn-search" style="margin-bottom: 20px;">
                    <i class="fa-solid fa-magnifying-glass bn-search__icon"></i>
                    <input type="text" name="customerInformation"
                           class="bn-search__input"
                           placeholder="Nhập SĐT hoặc số CCCD..."
                           value="<%= customerInformation %>">
                    <button type="submit" name="action" value="search" class="bn-search__btn">
                        Tìm khách hàng
                    </button>
                </form>

                <% if (message != null) { %>
                <div class="bn-alert bn-alert--info" style="margin-bottom: 20px;">
                    <i class="fa-solid fa-circle-info"></i>
                    <span><%= message %></span>
                </div>
                <% } %>

                <!-- SPLIT LAYOUT -->
                <div class="bn-split">

                    <!-- LEFT: LIST -->
                    <div class="bn-split__col">
                        <div class="bn-split__head">
                            <div class="bn-split__title">
                                <i class="fa-solid fa-list-check"></i>
                                Phiếu đã xác nhận
                            </div>
                            <% if (dsDaDat != null) { %>
                            <span class="bn-count"><%= dsDaDat.size() %> phiếu</span>
                            <% } %>
                        </div>

                        <% if (dsDaDat == null || dsDaDat.isEmpty()) { %>
                        <div class="bn-split__body bn-split__body--empty">
                            <div>
                                <div class="bn-split__empty-icon">
                                    <i class="fa-solid fa-inbox"></i>
                                </div>
                                <p>Không có phiếu đặt nào đang chờ check-in.</p>
                            </div>
                        </div>
                        <% } else { %>
                        <div class="bn-split__body">
                            <div class="bn-table-wrap" style="box-shadow: none;">
                                <div class="bn-table-scroll">
                                    <table class="bn-table bn-table--compact">
                                        <thead>
                                            <tr>
                                                <th>Mã ĐP</th>
                                                <th>Mã KH</th>
                                                <th>Phòng</th>
                                                <th>Nhận</th>
                                                <th>Trả</th>
                                                <th style="text-align: center;"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (BookingDTO dp : dsDaDat) {
                                                boolean isActive = chiTiet != null && chiTiet.getMaDatPhong() == dp.getMaDatPhong();
                                            %>
                                            <tr <%= isActive ? "style=\"background: rgba(240,185,11,0.08);\"" : "" %>>
                                                <td><strong style="color: var(--bn-yellow);">#<%= dp.getMaDatPhong() %></strong></td>
                                                <td class="num"><%= dp.getMaKH() %></td>
                                                <td class="num"><%= dp.getMaPhong() %></td>
                                                <td class="num"><%= dp.getNgayNhanDuKien() %></td>
                                                <td class="num"><%= dp.getNgayTraDuKien() %></td>
                                                <td style="text-align: center;">
                                                    <form action="CheckInServlet" method="get" class="bn-inline-form">
                                                        <input type="hidden" name="action" value="view">
                                                        <input type="hidden" name="maDatPhong" value="<%= dp.getMaDatPhong() %>">
                                                        <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
                                                        <button type="submit" class="bn-btn bn-btn--icon edit" title="Xem chi tiết">
                                                            <i class="fa-solid fa-eye"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>

                    <!-- RIGHT: DETAIL -->
                    <div class="bn-split__col">
                        <div class="bn-split__head">
                            <div class="bn-split__title">
                                <i class="fa-solid fa-file-lines"></i>
                                Chi tiết phiếu đặt
                            </div>
                            <% if (chiTiet != null) { %>
                            <span class="bn-badge bn-badge--info">
                                <%= chiTiet.getTrangThai() %>
                            </span>
                            <% } %>
                        </div>

                        <% if (chiTiet == null) { %>
                        <div class="bn-split__body bn-split__body--empty">
                            <div>
                                <div class="bn-split__empty-icon">
                                    <i class="fa-solid fa-hand-pointer"></i>
                                </div>
                                <p>Chọn một phiếu đặt để xem chi tiết.</p>
                            </div>
                        </div>
                        <% } else { %>
                        <div class="bn-split__body">
                            <div class="bn-detail-list">

                                <div class="bn-detail-section">
                                    <div class="bn-detail-section__title">
                                        <i class="fa-solid fa-receipt"></i>
                                        Thông tin phiếu đặt
                                    </div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Mã đặt phòng</span><span class="bn-detail-row__value">#<%= chiTiet.getMaDatPhong() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Mã khách hàng</span><span class="bn-detail-row__value"><%= chiTiet.getMaKH() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Mã phòng</span><span class="bn-detail-row__value"><%= chiTiet.getMaPhong() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Ngày đặt</span><span class="bn-detail-row__value"><%= chiTiet.getNgayDat() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Ngày nhận dự kiến</span><span class="bn-detail-row__value"><%= chiTiet.getNgayNhanDuKien() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Ngày trả dự kiến</span><span class="bn-detail-row__value"><%= chiTiet.getNgayTraDuKien() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Trạng thái</span><span class="bn-detail-row__value"><%= chiTiet.getTrangThai() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Ghi chú</span><span class="bn-detail-row__value"><%= chiTiet.getGhiChu() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Giá phòng lúc đặt</span><span class="bn-detail-row__value" style="color: var(--bn-yellow);"><%= chiTiet.getGiaPhongTaiThoiDiemDat() %></span></div>
                                </div>

                                <div class="bn-detail-section">
                                    <div class="bn-detail-section__title">
                                        <i class="fa-solid fa-user"></i>
                                        Thông tin khách hàng
                                    </div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Họ tên</span><span class="bn-detail-row__value"><%= chiTiet.getTenKhachHang() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">CCCD</span><span class="bn-detail-row__value"><%= chiTiet.getCccd() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">SĐT</span><span class="bn-detail-row__value"><%= chiTiet.getSdtKhachHang() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Email</span><span class="bn-detail-row__value"><%= chiTiet.getEmailKhachHang() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Địa chỉ</span><span class="bn-detail-row__value"><%= chiTiet.getDiaChiKhachHang() %></span></div>
                                </div>

                                <div class="bn-detail-section">
                                    <div class="bn-detail-section__title">
                                        <i class="fa-solid fa-bed"></i>
                                        Thông tin phòng
                                    </div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Số phòng</span><span class="bn-detail-row__value"><%= chiTiet.getSoPhong() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Loại phòng</span><span class="bn-detail-row__value"><%= chiTiet.getTenLoaiPhong() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Số người tối đa</span><span class="bn-detail-row__value"><%= chiTiet.getSoNguoiToiDa() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Giá cơ bản</span><span class="bn-detail-row__value"><%= chiTiet.getGiaCoBan() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Mô tả</span><span class="bn-detail-row__value"><%= chiTiet.getMoTaLoaiPhong() %></span></div>
                                </div>

                            </div>
                        </div>
                        <% } %>

                        <% if (chiTiet != null) { %>
                        <div class="bn-split__foot">
                            <form action="CheckInServlet" method="post" class="bn-inline-form">
                                <input type="hidden" name="action" value="checkin">
                                <input type="hidden" name="maDatPhong" value="<%= chiTiet.getMaDatPhong() %>">
                                <input type="hidden" name="maPhong" value="<%= chiTiet.getMaPhong() %>">
                                <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
                                <button type="submit" class="bn-btn bn-btn--success">
                                    <i class="fa-solid fa-key"></i>
                                    Check-in
                                </button>
                            </form>

                            <form action="CheckInServlet" method="post" class="bn-inline-form">
                                <input type="hidden" name="action" value="cancel">
                                <input type="hidden" name="maDatPhong" value="<%= chiTiet.getMaDatPhong() %>">
                                <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
                                <button type="submit" class="bn-btn bn-btn--danger">
                                    <i class="fa-solid fa-ban"></i>
                                    Huỷ phiếu
                                </button>
                            </form>

                            <form action="CheckInServlet" method="get" class="bn-inline-form" style="margin-left: auto;">
                                <input type="hidden" name="action" value="close">
                                <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
                                <button type="submit" class="bn-btn bn-btn--ghost">
                                    <i class="fa-solid fa-xmark"></i>
                                    Đóng
                                </button>
                            </form>
                        </div>
                        <% } %>
                    </div>
                </div>

            </main>

            <footer class="bn-footer">
                &copy; 2026 <strong>Hotel Staff</strong> · Hệ thống quản lý nội bộ
            </footer>

        </div>
    </body>
</html>
