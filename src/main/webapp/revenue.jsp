<%@page import="java.util.List"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.RevenueDetailDTO"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.TopRoomDTO"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.TopServiceDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String tuNgay = request.getAttribute("tuNgay") != null ? request.getAttribute("tuNgay").toString() : "";
    String denNgay = request.getAttribute("denNgay") != null ? request.getAttribute("denNgay").toString() : "";
    String thang = request.getAttribute("thang") != null ? request.getAttribute("thang").toString() : "";
    String nam = request.getAttribute("nam") != null ? request.getAttribute("nam").toString() : "";

    BigDecimal tongDoanhThu = request.getAttribute("tongDoanhThu") != null
            ? (BigDecimal) request.getAttribute("tongDoanhThu") : BigDecimal.ZERO;
    BigDecimal doanhThuPhong = request.getAttribute("doanhThuPhong") != null
            ? (BigDecimal) request.getAttribute("doanhThuPhong") : BigDecimal.ZERO;
    BigDecimal doanhThuDichVu = request.getAttribute("doanhThuDichVu") != null
            ? (BigDecimal) request.getAttribute("doanhThuDichVu") : BigDecimal.ZERO;

    List<RevenueDetailDTO> hoaDonList = (List<RevenueDetailDTO>) request.getAttribute("hoaDonList");
    List<TopRoomDTO> top3Phong = (List<TopRoomDTO>) request.getAttribute("top3Phong");
    List<TopServiceDTO> top3DichVu = (List<TopServiceDTO>) request.getAttribute("top3DichVu");

    String infoMessage = request.getAttribute("infoMessage") != null
            ? request.getAttribute("infoMessage").toString() : "";
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thống kê doanh thu</title>
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
                        <span>Hotel Admin</span>
                    </div>
                    <div class="bn-nav__user">
                        <a href="main.jsp" class="bn-btn bn-btn--ghost">
                            <i class="fa-solid fa-house"></i>
                            Trang chính
                        </a>
                    </div>
                </div>
            </nav>

            <main class="bn-container">

                <a href="main.jsp" class="bn-back-link">
                    <i class="fa-solid fa-arrow-left"></i>
                    Về trang chủ
                </a>

                <div class="bn-page-header">
                    <div>
                        <h1 class="bn-page-header__title">
                            <i class="fa-solid fa-chart-line" style="color: var(--bn-yellow);"></i>
                            Thống kê doanh thu
                        </h1>
                        <p class="bn-page-header__subtitle">
                            Tổng quan doanh thu, chi tiết hoá đơn và các mục dẫn đầu
                        </p>
                    </div>
                </div>

                <!-- FILTER -->
                <form action="RevenueDetailServlet" method="get" class="bn-filter">
                    <div class="bn-filter__field">
                        <label class="bn-label" for="tuNgay">
                            <i class="fa-solid fa-calendar-day"></i>
                            Từ ngày
                        </label>
                        <input type="date" id="tuNgay" name="tuNgay" class="bn-input" value="<%= tuNgay %>">
                    </div>

                    <div class="bn-filter__field">
                        <label class="bn-label" for="denNgay">
                            <i class="fa-solid fa-calendar-day"></i>
                            Đến ngày
                        </label>
                        <input type="date" id="denNgay" name="denNgay" class="bn-input" value="<%= denNgay %>">
                    </div>

                    <div class="bn-filter__field">
                        <label class="bn-label" for="thang">
                            <i class="fa-solid fa-calendar"></i>
                            Tháng
                        </label>
                        <select name="thang" id="thang" class="bn-select">
                            <option value="">-- Chọn tháng --</option>
                            <% for (int i = 1; i <= 12; i++) { %>
                            <option value="<%= i %>" <%= String.valueOf(i).equals(thang) ? "selected" : "" %>>
                                Tháng <%= i %>
                            </option>
                            <% } %>
                        </select>
                    </div>

                    <div class="bn-filter__field">
                        <label class="bn-label" for="nam">
                            <i class="fa-solid fa-calendar-days"></i>
                            Năm
                        </label>
                        <input type="number" id="nam" name="nam" class="bn-input"
                               value="<%= nam %>" min="2000" max="2100" placeholder="Nhập năm" />
                    </div>

                    <div class="bn-filter__actions">
                        <button type="reset" class="bn-btn bn-btn--ghost">
                            <i class="fa-solid fa-eraser"></i>
                            Xoá
                        </button>
                        <button type="submit" name="action" value="filter" class="bn-btn bn-btn--primary">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            Tìm kiếm
                        </button>
                    </div>
                </form>

                <% if (!infoMessage.isEmpty()) { %>
                <div class="bn-alert bn-alert--info" style="margin-bottom: 20px;">
                    <i class="fa-solid fa-circle-info"></i>
                    <span><%= infoMessage %></span>
                </div>
                <% } %>

                <!-- DASHBOARD -->
                <div class="bn-dashboard">

                    <!-- MAIN: KPI + TABLE -->
                    <div>
                        <!-- KPI CARDS -->
                        <div class="bn-kpi-grid">
                            <div class="bn-kpi">
                                <div class="bn-kpi__head">
                                    <div class="bn-kpi__icon"><i class="fa-solid fa-sack-dollar"></i></div>
                                    <span class="bn-kpi__label">Tổng doanh thu</span>
                                </div>
                                <div class="bn-kpi__value bn-kpi__value--accent">
                                    <%= tongDoanhThu %>
                                </div>
                            </div>

                            <div class="bn-kpi">
                                <div class="bn-kpi__head">
                                    <div class="bn-kpi__icon"><i class="fa-solid fa-bed"></i></div>
                                    <span class="bn-kpi__label">Doanh thu phòng</span>
                                </div>
                                <div class="bn-kpi__value">
                                    <%= doanhThuPhong %>
                                </div>
                            </div>

                            <div class="bn-kpi">
                                <div class="bn-kpi__head">
                                    <div class="bn-kpi__icon"><i class="fa-solid fa-concierge-bell"></i></div>
                                    <span class="bn-kpi__label">Doanh thu dịch vụ</span>
                                </div>
                                <div class="bn-kpi__value">
                                    <%= doanhThuDichVu %>
                                </div>
                            </div>
                        </div>

                        <!-- DETAIL TABLE -->
                        <h2 class="bn-section-title">
                            <i class="fa-solid fa-list-ol" style="color: var(--bn-yellow); margin-right: 8px;"></i>
                            Danh sách hoá đơn chi tiết
                        </h2>

                        <div class="bn-table-wrap">
                            <div class="bn-table-scroll">
                                <table class="bn-table">
                                    <thead>
                                        <tr>
                                            <th>Mã HĐ</th>
                                            <th>Mã NV</th>
                                            <th>Mã KH</th>
                                            <th>Tên nhân viên</th>
                                            <th>Tên khách hàng</th>
                                            <th>Ngày lập</th>
                                            <th style="text-align: right;">Tiền phòng</th>
                                            <th style="text-align: right;">Tiền dịch vụ</th>
                                            <th style="text-align: right;">Tổng</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (hoaDonList != null && !hoaDonList.isEmpty()) {
                                            for (RevenueDetailDTO hd : hoaDonList) { %>
                                        <tr>
                                            <td><strong style="color: var(--bn-yellow);">#<%= hd.getMaHoaDon() %></strong></td>
                                            <td class="num"><%= hd.getMaNV() %></td>
                                            <td class="num"><%= hd.getMaKH() %></td>
                                            <td><%= hd.getTenNV() %></td>
                                            <td><strong><%= hd.getTenKH() %></strong></td>
                                            <td class="num"><%= hd.getNgayLap() %></td>
                                            <td class="num" style="text-align: right;"><%= hd.getTongTienPhong() %></td>
                                            <td class="num" style="text-align: right;"><%= hd.getTongTienDV() %></td>
                                            <td class="num" style="text-align: right; color: var(--bn-yellow); font-weight: 700;">
                                                <%= hd.getTongThanhToan() %>
                                            </td>
                                        </tr>
                                        <% } } else { %>
                                        <tr>
                                            <td colspan="9" class="bn-table__empty">
                                                <i class="fa-solid fa-chart-simple" style="font-size: 24px; display: block; margin-bottom: 8px; color: var(--bn-slate);"></i>
                                                Không có dữ liệu
                                            </td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- SIDEBAR: TOP LISTS -->
                    <aside class="bn-sidebar">

                        <div class="bn-panel" style="margin-bottom: 0;">
                            <div class="bn-panel__head">
                                <div class="bn-panel__title">
                                    <i class="fa-solid fa-trophy"></i>
                                    Top 3 phòng
                                </div>
                            </div>

                            <ul class="bn-top-list">
                                <% if (top3Phong != null && !top3Phong.isEmpty()) {
                                    int idx = 0;
                                    for (TopRoomDTO p : top3Phong) { idx++; %>
                                <li>
                                    <a class="bn-top-list__item"
                                       href="RevenueTopDetailServlet?type=room&id=<%= p.getMaPhong() %>&thang=<%= thang %>&nam=<%= nam %>">
                                        <div class="bn-top-list__rank"><%= idx %></div>
                                        <div class="bn-top-list__body">
                                            <div class="bn-top-list__name"><%= p.getTenPhong() %></div>
                                            <div class="bn-top-list__value"><%= p.getDoanhThu() %></div>
                                        </div>
                                        <i class="fa-solid fa-chevron-right" style="color: var(--bn-slate); font-size: 12px;"></i>
                                    </a>
                                </li>
                                <% } } else { %>
                                <li class="bn-top-list__empty">Không có dữ liệu</li>
                                <% } %>
                            </ul>
                        </div>

                        <div class="bn-panel" style="margin-bottom: 0;">
                            <div class="bn-panel__head">
                                <div class="bn-panel__title">
                                    <i class="fa-solid fa-star"></i>
                                    Top 3 dịch vụ
                                </div>
                            </div>

                            <ul class="bn-top-list">
                                <% if (top3DichVu != null && !top3DichVu.isEmpty()) {
                                    int idx = 0;
                                    for (TopServiceDTO dv : top3DichVu) { idx++; %>
                                <li>
                                    <a class="bn-top-list__item"
                                       href="RevenueTopDetailServlet?type=service&id=<%= dv.getMaDV() %>&thang=<%= thang %>&nam=<%= nam %>">
                                        <div class="bn-top-list__rank"><%= idx %></div>
                                        <div class="bn-top-list__body">
                                            <div class="bn-top-list__name"><%= dv.getTenDichVu() %></div>
                                            <div class="bn-top-list__value"><%= dv.getDoanhThu() %></div>
                                        </div>
                                        <i class="fa-solid fa-chevron-right" style="color: var(--bn-slate); font-size: 12px;"></i>
                                    </a>
                                </li>
                                <% } } else { %>
                                <li class="bn-top-list__empty">Không có dữ liệu</li>
                                <% } %>
                            </ul>
                        </div>

                    </aside>
                </div>

            </main>

            <footer class="bn-footer">
                &copy; 2026 <strong>Hotel Admin</strong> · Hệ thống quản lý nội bộ
            </footer>

        </div>
    </body>
</html>
