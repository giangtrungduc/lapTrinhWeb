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
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thanh toán</title>
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
                            <i class="fa-solid fa-credit-card" style="color: var(--bn-yellow);"></i>
                            Thanh toán
                        </h1>
                        <p class="bn-page-header__subtitle">
                            Tìm khách đã check-out và xử lý thanh toán hoá đơn
                        </p>
                    </div>
                </div>

                <!-- SEARCH -->
                <form action="PaymentServlet" method="get" class="bn-search" style="margin-bottom: 20px;">
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

                    <!-- LEFT: INVOICE LIST -->
                    <div class="bn-split__col">
                        <div class="bn-split__head">
                            <div class="bn-split__title">
                                <i class="fa-solid fa-file-invoice"></i>
                                Danh sách hoá đơn
                            </div>
                            <% if (dsHoaDon != null) { %>
                            <span class="bn-count"><%= dsHoaDon.size() %> hoá đơn</span>
                            <% } %>
                        </div>

                        <% if (dsHoaDon == null || dsHoaDon.isEmpty()) { %>
                        <div class="bn-split__body bn-split__body--empty">
                            <div>
                                <div class="bn-split__empty-icon">
                                    <i class="fa-solid fa-inbox"></i>
                                </div>
                                <p>Không có hoá đơn nào cần thanh toán.</p>
                            </div>
                        </div>
                        <% } else { %>
                        <div class="bn-split__body">
                            <div class="bn-table-wrap" style="box-shadow: none;">
                                <div class="bn-table-scroll">
                                    <table class="bn-table bn-table--compact">
                                        <thead>
                                            <tr>
                                                <th>Mã HĐ</th>
                                                <th>Mã ĐP</th>
                                                <th>Khách</th>
                                                <th>Phòng</th>
                                                <th>Tổng tiền</th>
                                                <th>TT</th>
                                                <th style="text-align: center;"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (PaymentViewDTO item : dsHoaDon) {
                                                boolean isActive = chiTiet != null && chiTiet.getMaHoaDon() == item.getMaHoaDon();
                                                String stClass = "DaThanhToan".equals(item.getTrangThaiThanhToan())
                                                    ? "bn-badge--success" : "bn-badge--warning";
                                            %>
                                            <tr <%= isActive ? "style=\"background: rgba(240,185,11,0.08);\"" : "" %>>
                                                <td><strong style="color: var(--bn-yellow);">#<%= item.getMaHoaDon() %></strong></td>
                                                <td class="num"><%= item.getMaDatPhong() %></td>
                                                <td><%= item.getTenKhachHang() %></td>
                                                <td class="num"><%= item.getSoPhong() %></td>
                                                <td class="num"><%= item.getTongThanhToan() %></td>
                                                <td>
                                                    <span class="bn-badge <%= stClass %>">
                                                        <%= item.getTrangThaiThanhToan() %>
                                                    </span>
                                                </td>
                                                <td style="text-align: center;">
                                                    <form action="PaymentServlet" method="get" class="bn-inline-form">
                                                        <input type="hidden" name="action" value="view">
                                                        <input type="hidden" name="maHoaDon" value="<%= item.getMaHoaDon() %>">
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

                    <!-- RIGHT: INVOICE DETAIL -->
                    <div class="bn-split__col">
                        <div class="bn-split__head">
                            <div class="bn-split__title">
                                <i class="fa-solid fa-receipt"></i>
                                Chi tiết thanh toán
                            </div>
                            <% if (chiTiet != null) {
                                String stClass = "DaThanhToan".equals(chiTiet.getTrangThaiThanhToan())
                                    ? "bn-badge--success" : "bn-badge--warning";
                            %>
                            <span class="bn-badge <%= stClass %>">
                                <%= chiTiet.getTrangThaiThanhToan() %>
                            </span>
                            <% } %>
                        </div>

                        <% if (chiTiet == null) { %>
                        <div class="bn-split__body bn-split__body--empty">
                            <div>
                                <div class="bn-split__empty-icon">
                                    <i class="fa-solid fa-hand-pointer"></i>
                                </div>
                                <p>Chọn một hoá đơn để xem chi tiết.</p>
                            </div>
                        </div>
                        <% } else { %>
                        <div class="bn-split__body">
                            <div class="bn-detail-list">

                                <div class="bn-detail-section">
                                    <div class="bn-detail-section__title">
                                        <i class="fa-solid fa-file-invoice"></i>
                                        Thông tin hoá đơn
                                    </div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Mã hoá đơn</span><span class="bn-detail-row__value">#<%= chiTiet.getMaHoaDon() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Mã đặt phòng</span><span class="bn-detail-row__value"><%= chiTiet.getMaDatPhong() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Ngày đặt</span><span class="bn-detail-row__value"><%= chiTiet.getNgayDat() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Ngày nhận dự kiến</span><span class="bn-detail-row__value"><%= chiTiet.getNgayNhanDuKien() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Ngày trả dự kiến</span><span class="bn-detail-row__value"><%= chiTiet.getNgayTraDuKien() %></span></div>
                                    <div class="bn-detail-row"><span class="bn-detail-row__label">Ngày trả thực tế</span><span class="bn-detail-row__value"><%= chiTiet.getNgayTraThucTe() %></span></div>
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
                                </div>

                                <!-- PAYMENT SUMMARY -->
                                <div class="bn-detail-section" style="background: linear-gradient(135deg, rgba(240,185,11,0.04), transparent); border-color: rgba(240,185,11,0.3);">
                                    <div class="bn-detail-section__title">
                                        <i class="fa-solid fa-money-bill-wave"></i>
                                        Thông tin thanh toán
                                    </div>
                                    <div class="bn-invoice__total-row" style="margin-bottom: 10px;">
                                        <span class="bn-invoice__total-label">Tiền phòng</span>
                                        <span class="bn-invoice__total-value"><%= chiTiet.getTongTienPhong() %></span>
                                    </div>
                                    <div class="bn-invoice__total-row" style="margin-bottom: 10px;">
                                        <span class="bn-invoice__total-label">Tiền dịch vụ</span>
                                        <span class="bn-invoice__total-value"><%= chiTiet.getTongTienDV() %></span>
                                    </div>
                                    <div class="bn-invoice__grand">
                                        <span class="bn-invoice__grand-label">Tổng thanh toán</span>
                                        <span class="bn-invoice__grand-value"><%= chiTiet.getTongThanhToan() %></span>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <% } %>

                        <% if (chiTiet != null) { %>
                        <div class="bn-split__foot">
                            <% if (!"DaThanhToan".equals(chiTiet.getTrangThaiThanhToan())) { %>
                            <form action="PaymentServlet" method="post" class="bn-inline-form"
                                  onsubmit="return confirm('Xác nhận thanh toán hoá đơn này?');">
                                <input type="hidden" name="action" value="pay">
                                <input type="hidden" name="maHoaDon" value="<%= chiTiet.getMaHoaDon() %>">
                                <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
                                <button type="submit" class="bn-btn bn-btn--success">
                                    <i class="fa-solid fa-check-double"></i>
                                    Xác nhận thanh toán
                                </button>
                            </form>
                            <% } else { %>
                            <div class="bn-alert bn-alert--success" style="flex: 1; margin: 0;">
                                <i class="fa-solid fa-circle-check"></i>
                                <span>Hoá đơn này đã được thanh toán.</span>
                            </div>
                            <% } %>

                            <form action="PaymentServlet" method="get" class="bn-inline-form" style="margin-left: auto;">
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
