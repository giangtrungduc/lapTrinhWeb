<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.BookingDTO"%>

<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<BookingDTO> dsChoXacNhan = (List<BookingDTO>) request.getAttribute("dsChoXacNhan");
    BookingDTO chiTiet = (BookingDTO) request.getAttribute("chiTiet");
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Xác nhận đặt phòng</title>
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
                    Quay lại trang nhân viên
                </a>

                <div class="bn-page-header">
                    <div>
                        <h1 class="bn-page-header__title">
                            <i class="fa-solid fa-clipboard-check" style="color: var(--bn-yellow);"></i>
                            Xác nhận đặt phòng
                        </h1>
                        <p class="bn-page-header__subtitle">
                            Duyệt các phiếu đặt phòng đang chờ xác nhận hoặc huỷ
                        </p>
                    </div>
                </div>

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
                                <i class="fa-solid fa-list"></i>
                                Danh sách phiếu chờ xác nhận
                            </div>
                            <% if (dsChoXacNhan != null) { %>
                            <span class="bn-count"><%= dsChoXacNhan.size() %> phiếu</span>
                            <% } %>
                        </div>

                        <%
                            if (dsChoXacNhan == null || dsChoXacNhan.isEmpty()) {
                        %>
                        <div class="bn-split__body bn-split__body--empty">
                            <div>
                                <div class="bn-split__empty-icon">
                                    <i class="fa-solid fa-inbox"></i>
                                </div>
                                <p>Không có phiếu đặt phòng nào chờ xác nhận.</p>
                            </div>
                        </div>
                        <%
                            } else {
                        %>
                        <div class="bn-split__body">
                            <div class="bn-table-wrap" style="box-shadow: none;">
                                <div class="bn-table-scroll">
                                    <table class="bn-table bn-table--compact">
                                        <thead>
                                            <tr>
                                                <th>Mã ĐP</th>
                                                <th>Mã KH</th>
                                                <th>Mã phòng</th>
                                                <th>Ngày nhận</th>
                                                <th>Ngày trả</th>
                                                <th style="text-align: center;"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (BookingDTO dp : dsChoXacNhan) {
                                                boolean isActive = chiTiet != null && chiTiet.getMaDatPhong() == dp.getMaDatPhong();
                                            %>
                                            <tr <%= isActive ? "style=\"background: rgba(240,185,11,0.08);\"" : "" %>>
                                                <td><strong style="color: var(--bn-yellow);">#<%= dp.getMaDatPhong() %></strong></td>
                                                <td class="num"><%= dp.getMaKH() %></td>
                                                <td class="num"><%= dp.getMaPhong() %></td>
                                                <td class="num"><%= dp.getNgayNhanDuKien() %></td>
                                                <td class="num"><%= dp.getNgayTraDuKien() %></td>
                                                <td style="text-align: center;">
                                                    <form action="BookingConfirmationServlet" method="get" class="bn-inline-form">
                                                        <input type="hidden" name="action" value="view">
                                                        <input type="hidden" name="maDatPhong" value="<%= dp.getMaDatPhong() %>">
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
                        <%
                            }
                        %>
                    </div>

                    <!-- RIGHT: DETAIL -->
                    <div class="bn-split__col">
                        <div class="bn-split__head">
                            <div class="bn-split__title">
                                <i class="fa-solid fa-file-lines"></i>
                                Chi tiết phiếu đặt phòng
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
                                <p>Chọn một phiếu đặt phòng để xem chi tiết.</p>
                            </div>
                        </div>
                        <% } else { %>
                        <div class="bn-split__body">
                            <div class="bn-detail-list">

                                <!-- BOOKING INFO -->
                                <div class="bn-detail-section">
                                    <div class="bn-detail-section__title">
                                        <i class="fa-solid fa-receipt"></i>
                                        Thông tin phiếu đặt
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Mã đặt phòng</span>
                                        <span class="bn-detail-row__value">#<%= chiTiet.getMaDatPhong() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Mã khách hàng</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getMaKH() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Mã phòng</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getMaPhong() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Ngày đặt</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getNgayDat() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Ngày nhận dự kiến</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getNgayNhanDuKien() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Ngày trả dự kiến</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getNgayTraDuKien() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Trạng thái</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getTrangThai() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Ghi chú</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getGhiChu() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Giá phòng tại thời điểm đặt</span>
                                        <span class="bn-detail-row__value" style="color: var(--bn-yellow);">
                                            <%= chiTiet.getGiaPhongTaiThoiDiemDat() %>
                                        </span>
                                    </div>
                                </div>

                                <!-- CUSTOMER INFO -->
                                <div class="bn-detail-section">
                                    <div class="bn-detail-section__title">
                                        <i class="fa-solid fa-user"></i>
                                        Thông tin khách hàng
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Họ tên</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getTenKhachHang() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">CCCD</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getCccd() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">SĐT</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getSdtKhachHang() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Email</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getEmailKhachHang() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Địa chỉ</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getDiaChiKhachHang() %></span>
                                    </div>
                                </div>

                                <!-- ROOM INFO -->
                                <div class="bn-detail-section">
                                    <div class="bn-detail-section__title">
                                        <i class="fa-solid fa-bed"></i>
                                        Thông tin phòng
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Mã phòng</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getMaPhong() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Số phòng</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getSoPhong() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Loại phòng</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getTenLoaiPhong() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Số người tối đa</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getSoNguoiToiDa() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Giá cơ bản</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getGiaCoBan() %></span>
                                    </div>
                                    <div class="bn-detail-row">
                                        <span class="bn-detail-row__label">Mô tả</span>
                                        <span class="bn-detail-row__value"><%= chiTiet.getMoTaLoaiPhong() %></span>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <% } %>

                        <% if (chiTiet != null) { %>
                        <div class="bn-split__foot">
                            <form action="BookingConfirmationServlet" method="post" class="bn-inline-form">
                                <input type="hidden" name="action" value="confirm">
                                <input type="hidden" name="maDatPhong" value="<%= chiTiet.getMaDatPhong() %>">
                                <button type="submit" class="bn-btn bn-btn--success">
                                    <i class="fa-solid fa-check"></i>
                                    Xác nhận
                                </button>
                            </form>

                            <form action="BookingConfirmationServlet" method="post" class="bn-inline-form">
                                <input type="hidden" name="action" value="cancel">
                                <input type="hidden" name="maDatPhong" value="<%= chiTiet.getMaDatPhong() %>">
                                <button type="submit" class="bn-btn bn-btn--danger">
                                    <i class="fa-solid fa-ban"></i>
                                    Huỷ phiếu
                                </button>
                            </form>

                            <form action="BookingConfirmationServlet" method="get" class="bn-inline-form" style="margin-left: auto;">
                                <input type="hidden" name="action" value="close">
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
