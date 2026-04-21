<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.BookingDTO"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.ServiceDTO"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.UsedServiceDTO"%>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<BookingDTO> dsDaNhanPhong = (List<BookingDTO>) request.getAttribute("dsDaNhanPhong");
    BookingDTO chiTiet = (BookingDTO) request.getAttribute("chiTiet");
    List<ServiceDTO> dsDichVu = (List<ServiceDTO>) request.getAttribute("dsDichVu");
    List<UsedServiceDTO> dsDichVuDaThem = (List<UsedServiceDTO>) request.getAttribute("dsDichVuDaThem");

    String message = (String) request.getAttribute("message");
    String customerInformation = request.getAttribute("customerInformation") != null
            ? request.getAttribute("customerInformation").toString() : "";

    Boolean showServicePanel = (Boolean) request.getAttribute("showServicePanel");
    if (showServicePanel == null) showServicePanel = false;
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý dịch vụ</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/binance-style.css">
        <script>
            function openQuantityBox(id) {
                document.querySelectorAll('.bn-qty-box.is-open').forEach(function (b) {
                    if (b.id !== "quantity-box-" + id) b.classList.remove('is-open');
                });
                var box = document.getElementById("quantity-box-" + id);
                if (box) box.classList.add('is-open');
            }

            function closeQuantityBox(id) {
                var box = document.getElementById("quantity-box-" + id);
                if (box) box.classList.remove('is-open');
            }
        </script>
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
                            <i class="fa-solid fa-concierge-bell" style="color: var(--bn-yellow);"></i>
                            Quản lý dịch vụ
                        </h1>
                        <p class="bn-page-header__subtitle">
                            Thêm hoặc xoá dịch vụ cho khách đang lưu trú
                        </p>
                    </div>
                </div>

                <!-- SEARCH -->
                <form action="ServiceServlet" method="get" class="bn-search" style="margin-bottom: 20px;">
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

                <!-- BOOKING LIST -->
                <div class="bn-panel">
                    <div class="bn-panel__head">
                        <div class="bn-panel__title">
                            <i class="fa-solid fa-bed"></i>
                            Phiếu đặt đang nhận phòng
                        </div>
                        <% if (dsDaNhanPhong != null) { %>
                        <span class="bn-count"><%= dsDaNhanPhong.size() %> phiếu</span>
                        <% } %>
                    </div>

                    <% if (dsDaNhanPhong == null || dsDaNhanPhong.isEmpty()) { %>
                    <div class="bn-table__empty" style="padding: 40px 20px;">
                        <i class="fa-solid fa-inbox" style="font-size: 28px; display: block; margin-bottom: 10px; color: var(--bn-slate);"></i>
                        Không có phiếu đặt nào ở trạng thái đã nhận phòng.
                    </div>
                    <% } else { %>
                    <div class="bn-table-wrap" style="box-shadow: none;">
                        <div class="bn-table-scroll">
                            <table class="bn-table">
                                <thead>
                                    <tr>
                                        <th>Mã ĐP</th>
                                        <th>Mã KH</th>
                                        <th>Mã phòng</th>
                                        <th>Ngày nhận dự kiến</th>
                                        <th>Ngày trả dự kiến</th>
                                        <th style="text-align: center;">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (BookingDTO dp : dsDaNhanPhong) { %>
                                    <tr>
                                        <td><strong style="color: var(--bn-yellow);">#<%= dp.getMaDatPhong() %></strong></td>
                                        <td class="num"><%= dp.getMaKH() %></td>
                                        <td class="num"><%= dp.getMaPhong() %></td>
                                        <td class="num"><%= dp.getNgayNhanDuKien() %></td>
                                        <td class="num"><%= dp.getNgayTraDuKien() %></td>
                                        <td style="text-align: center;">
                                            <form action="ServiceServlet" method="get" class="bn-inline-form">
                                                <input type="hidden" name="action" value="view">
                                                <input type="hidden" name="maDatPhong" value="<%= dp.getMaDatPhong() %>">
                                                <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
                                                <button type="submit" class="bn-btn bn-btn--primary bn-btn--sm">
                                                    <i class="fa-solid fa-gear"></i>
                                                    Quản lý DV
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <% } %>
                </div>

            </main>

            <footer class="bn-footer">
                &copy; 2026 <strong>Hotel Staff</strong> · Hệ thống quản lý nội bộ
            </footer>

        </div>

        <!-- FULLSCREEN MODAL: SERVICE PANEL -->
        <% if (showServicePanel && chiTiet != null) { %>
        <div class="bn-fullmodal">
            <div class="bn-fullmodal__content">
                <div class="bn-fullmodal__header">
                    <div>
                        <div class="bn-fullmodal__title">
                            <i class="fa-solid fa-concierge-bell"></i>
                            Quản lý dịch vụ · Phiếu đặt #<%= chiTiet.getMaDatPhong() %>
                        </div>
                        <div class="bn-fullmodal__meta">
                            <span><i class="fa-solid fa-user" style="color: var(--bn-yellow);"></i> <strong><%= chiTiet.getTenKhachHang() %></strong></span>
                            <span><i class="fa-solid fa-bed" style="color: var(--bn-yellow);"></i> Phòng <strong><%= chiTiet.getSoPhong() %></strong></span>
                            <span><i class="fa-solid fa-id-card" style="color: var(--bn-yellow);"></i> <strong><%= chiTiet.getCccd() %></strong></span>
                            <span><i class="fa-solid fa-phone" style="color: var(--bn-yellow);"></i> <strong><%= chiTiet.getSdtKhachHang() %></strong></span>
                        </div>
                    </div>

                    <form action="ServiceServlet" method="get" class="bn-inline-form">
                        <input type="hidden" name="action" value="close">
                        <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
                        <button type="submit" class="bn-btn bn-btn--ghost">
                            <i class="fa-solid fa-xmark"></i>
                            Đóng
                        </button>
                    </form>
                </div>

                <div class="bn-fullmodal__body">

                    <!-- LEFT PANEL: AVAILABLE SERVICES -->
                    <div class="bn-fullmodal__panel">
                        <div class="bn-fullmodal__panel-title">
                            <i class="fa-solid fa-list"></i>
                            Danh sách dịch vụ khách sạn
                        </div>

                        <% if (dsDichVu == null || dsDichVu.isEmpty()) { %>
                        <div class="bn-table__empty" style="padding: 40px 20px;">
                            <i class="fa-solid fa-circle-info" style="font-size: 24px; display: block; margin-bottom: 8px; color: var(--bn-slate);"></i>
                            Không có dịch vụ nào.
                        </div>
                        <% } else { %>
                        <div class="bn-table-wrap" style="box-shadow: none; border: none;">
                            <table class="bn-table bn-table--compact">
                                <thead>
                                    <tr>
                                        <th>Mã</th>
                                        <th>Tên dịch vụ</th>
                                        <th style="text-align: right;">Đơn giá</th>
                                        <th>Mô tả</th>
                                        <th style="text-align: center;">Thêm</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (ServiceDTO dv : dsDichVu) { %>
                                    <tr>
                                        <td class="num"><%= dv.getMaDV() %></td>
                                        <td><strong><%= dv.getTenDV() %></strong></td>
                                        <td class="num" style="text-align: right; color: var(--bn-yellow); font-weight: 700;">
                                            <%= dv.getDonGia() %>
                                        </td>
                                        <td><span class="muted" style="font-style: normal; font-size: 12px;"><%= dv.getMoTa() %></span></td>
                                        <td style="text-align: center;">
                                            <button type="button" class="bn-btn bn-btn--primary bn-btn--sm"
                                                    onclick="openQuantityBox('<%= dv.getMaDV() %>')">
                                                <i class="fa-solid fa-plus"></i>
                                                Thêm
                                            </button>

                                            <div class="bn-qty-box" id="quantity-box-<%= dv.getMaDV() %>">
                                                <form action="ServiceServlet" method="post" class="bn-qty-box__row">
                                                    <input type="hidden" name="action" value="add">
                                                    <input type="hidden" name="maDatPhong" value="<%= chiTiet.getMaDatPhong() %>">
                                                    <input type="hidden" name="maDV" value="<%= dv.getMaDV() %>">
                                                    <input type="hidden" name="customerInformation" value="<%= customerInformation %>">

                                                    <input type="number" name="soLuong" min="1" required
                                                           class="bn-qty-box__input" placeholder="SL">
                                                    <button type="submit" class="bn-btn bn-btn--success bn-btn--sm">
                                                        <i class="fa-solid fa-check"></i>
                                                    </button>
                                                    <button type="button" class="bn-btn bn-btn--ghost bn-btn--sm"
                                                            onclick="closeQuantityBox('<%= dv.getMaDV() %>')">
                                                        <i class="fa-solid fa-xmark"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                        <% } %>
                    </div>

                    <!-- RIGHT PANEL: USED SERVICES -->
                    <div class="bn-fullmodal__panel">
                        <div class="bn-fullmodal__panel-title">
                            <i class="fa-solid fa-clipboard-list"></i>
                            Dịch vụ đã thêm
                            <% if (dsDichVuDaThem != null && !dsDichVuDaThem.isEmpty()) { %>
                            <span class="bn-count" style="margin-left: auto;"><%= dsDichVuDaThem.size() %> mục</span>
                            <% } %>
                        </div>

                        <% if (dsDichVuDaThem == null || dsDichVuDaThem.isEmpty()) { %>
                        <div class="bn-table__empty" style="padding: 40px 20px;">
                            <i class="fa-solid fa-circle-info" style="font-size: 24px; display: block; margin-bottom: 8px; color: var(--bn-slate);"></i>
                            Phiếu đặt này chưa có dịch vụ nào.
                        </div>
                        <% } else { %>
                        <div class="bn-table-wrap" style="box-shadow: none; border: none;">
                            <table class="bn-table bn-table--compact">
                                <thead>
                                    <tr>
                                        <th>Mã SDDV</th>
                                        <th>Tên DV</th>
                                        <th style="text-align: center;">SL</th>
                                        <th style="text-align: right;">Đơn giá</th>
                                        <th style="text-align: right;">Thành tiền</th>
                                        <th>Thời gian</th>
                                        <th style="text-align: center;"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (UsedServiceDTO item : dsDichVuDaThem) { %>
                                    <tr>
                                        <td class="num"><%= item.getMaSDDV() %></td>
                                        <td><strong><%= item.getTenDV() %></strong></td>
                                        <td class="num" style="text-align: center;"><%= item.getSoLuong() %></td>
                                        <td class="num" style="text-align: right;"><%= item.getDonGia() %></td>
                                        <td class="num" style="text-align: right; color: var(--bn-yellow); font-weight: 700;">
                                            <%= item.getThanhTien() %>
                                        </td>
                                        <td class="num" style="font-size: 12px;"><%= item.getThoiGianSuDung() %></td>
                                        <td style="text-align: center;">
                                            <form action="ServiceServlet" method="post" class="bn-inline-form"
                                                  onsubmit="return confirm('Bạn có chắc muốn xoá dịch vụ này?');">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="maDatPhong" value="<%= chiTiet.getMaDatPhong() %>">
                                                <input type="hidden" name="maSDDV" value="<%= item.getMaSDDV() %>">
                                                <input type="hidden" name="customerInformation" value="<%= customerInformation %>">
                                                <button type="submit" class="bn-btn bn-btn--icon delete" title="Xoá">
                                                    <i class="fa-solid fa-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                        <% } %>
                    </div>

                </div>
            </div>
        </div>
        <% } %>
    </body>
</html>
