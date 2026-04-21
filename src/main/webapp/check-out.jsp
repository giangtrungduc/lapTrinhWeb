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
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Check-out</title>
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
                            <i class="fa-solid fa-door-open" style="color: var(--bn-yellow);"></i>
                            Quy trình Check-out
                        </h1>
                        <p class="bn-page-header__subtitle">
                            Tìm khách đang ở, kiểm tra dịch vụ và tổng kết thanh toán
                        </p>
                    </div>
                </div>

                <!-- SEARCH -->
                <form action="CheckOutServlet" method="get" class="bn-search" style="margin-bottom: 20px;">
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
                                <i class="fa-solid fa-bed"></i>
                                Phiếu đang ở
                            </div>
                            <% if (dsDangO != null) { %>
                            <span class="bn-count"><%= dsDangO.size() %> phiếu</span>
                            <% } %>
                        </div>

                        <% if (dsDangO == null || dsDangO.isEmpty()) { %>
                        <div class="bn-split__body bn-split__body--empty">
                            <div>
                                <div class="bn-split__empty-icon">
                                    <i class="fa-solid fa-inbox"></i>
                                </div>
                                <p>Không có phiếu đặt nào đang ở để check-out.</p>
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
                                            <% for (BookingDTO dp : dsDangO) {
                                                boolean isActive = chiTiet != null && chiTiet.getMaDatPhong() == dp.getMaDatPhong();
                                            %>
                                            <tr <%= isActive ? "style=\"background: rgba(240,185,11,0.08);\"" : "" %>>
                                                <td><strong style="color: var(--bn-yellow);">#<%= dp.getMaDatPhong() %></strong></td>
                                                <td class="num"><%= dp.getMaKH() %></td>
                                                <td class="num"><%= dp.getMaPhong() %></td>
                                                <td class="num"><%= dp.getNgayNhanDuKien() %></td>
                                                <td class="num"><%= dp.getNgayTraDuKien() %></td>
                                                <td style="text-align: center;">
                                                    <form action="CheckOutServlet" method="get" class="bn-inline-form">
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
                            <span class="bn-badge bn-badge--warning">
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

                                <!-- SERVICES USED -->
                                <div class="bn-detail-section">
                                    <div class="bn-detail-section__title">
                                        <i class="fa-solid fa-concierge-bell"></i>
                                        Dịch vụ đã sử dụng
                                    </div>

                                    <% if (dsDichVuDaThem == null || dsDichVuDaThem.isEmpty()) { %>
                                    <p style="color: var(--bn-slate); font-size: 13px; padding: 8px 0;">
                                        <i class="fa-solid fa-circle-info"></i>
                                        Phiếu đặt này chưa có dịch vụ nào.
                                    </p>
                                    <% } else { %>
                                    <div class="bn-table-wrap" style="box-shadow: none;">
                                        <div class="bn-table-scroll">
                                            <table class="bn-table bn-table--compact">
                                                <thead>
                                                    <tr>
                                                        <th>Tên DV</th>
                                                        <th style="text-align: center;">SL</th>
                                                        <th style="text-align: right;">Đơn giá</th>
                                                        <th style="text-align: right;">Thành tiền</th>
                                                        <th>Thời gian</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% for (UsedServiceDTO item : dsDichVuDaThem) { %>
                                                    <tr>
                                                        <td><strong><%= item.getTenDV() %></strong></td>
                                                        <td class="num" style="text-align: center;"><%= item.getSoLuong() %></td>
                                                        <td class="num" style="text-align: right;"><%= item.getDonGia() %></td>
                                                        <td class="num" style="text-align: right;"><%= item.getThanhTien() %></td>
                                                        <td class="num"><%= item.getThoiGianSuDung() %></td>
                                                    </tr>
                                                    <% } %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <% } %>
                                </div>

                                <!-- SUMMARY -->
                                <div class="bn-detail-section" style="background: linear-gradient(135deg, rgba(240,185,11,0.04), transparent); border-color: rgba(240,185,11,0.3);">
                                    <div class="bn-detail-section__title">
                                        <i class="fa-solid fa-calculator"></i>
                                        Tổng kết hoá đơn tạm tính
                                    </div>
                                    <div class="bn-invoice__total-row" style="margin-bottom: 10px;">
                                        <span class="bn-invoice__total-label">Tiền phòng</span>
                                        <span class="bn-invoice__total-value"><%= tongTienPhong != null ? tongTienPhong : 0 %></span>
                                    </div>
                                    <div class="bn-invoice__total-row" style="margin-bottom: 10px;">
                                        <span class="bn-invoice__total-label">Tiền dịch vụ</span>
                                        <span class="bn-invoice__total-value"><%= tongTienDV != null ? tongTienDV : 0 %></span>
                                    </div>
                                    <div class="bn-invoice__grand">
                                        <span class="bn-invoice__grand-label">Tổng thanh toán</span>
                                        <span class="bn-invoice__grand-value"><%= tongThanhToan != null ? tongThanhToan : 0 %></span>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <% } %>

                        <% if (chiTiet != null) { %>
                        <div class="bn-split__foot">
                            <form action="CheckOutServlet" method="post" class="bn-inline-form"
                                  onsubmit="return confirm('Xác nhận check-out cho khách này?');">
                                <input type="hidden" name="action" value="checkout">
                                <input type="hidden" name="maDatPhong" value="<%= chiTiet.getMaDatPhong() %>">
                                <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
                                <button type="submit" class="bn-btn bn-btn--success">
                                    <i class="fa-solid fa-door-open"></i>
                                    Check-out
                                </button>
                            </form>

                            <form action="CheckOutServlet" method="get" class="bn-inline-form" style="margin-left: auto;">
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
