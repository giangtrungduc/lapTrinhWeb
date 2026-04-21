<%@page import="com.mycompany.laptrinhweb.model.dto.RevenueTopDetailDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    RevenueTopDetailDTO detail = (RevenueTopDetailDTO) request.getAttribute("detail");
    String type = request.getAttribute("type") != null ? request.getAttribute("type").toString() : "";
    String thang = request.getAttribute("thang") != null ? request.getAttribute("thang").toString() : "";
    String nam = request.getAttribute("nam") != null ? request.getAttribute("nam").toString() : "";
    boolean isRoom = "room".equals(type);
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết doanh thu</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/binance-style.css">
    </head>
    <body>
        <div class="bn-auth-shell">
            <div class="bn-form-card bn-form-card--wide">

                <div class="bn-form-card__header">
                    <div class="bn-form-card__badge">
                        <i class="fa-solid fa-<%= isRoom ? "bed" : "concierge-bell" %>"></i>
                    </div>
                    <h1 class="bn-form-card__title">
                        <%= isRoom ? "Chi tiết phòng" : "Chi tiết dịch vụ" %>
                    </h1>
                    <p class="bn-form-card__subtitle">
                        <% if (!thang.isEmpty() || !nam.isEmpty()) { %>
                            Thống kê
                            <% if (!thang.isEmpty()) { %>tháng <strong style="color: var(--bn-text-primary);"><%= thang %></strong><% } %>
                            <% if (!nam.isEmpty()) { %> năm <strong style="color: var(--bn-text-primary);"><%= nam %></strong><% } %>
                        <% } else { %>
                            Thông tin doanh thu chi tiết
                        <% } %>
                    </p>
                </div>

                <% if (detail != null) { %>

                <!-- HIGHLIGHT VALUE -->
                <div class="bn-invoice__grand" style="margin-bottom: 20px;">
                    <span class="bn-invoice__grand-label">Doanh thu</span>
                    <span class="bn-invoice__grand-value"><%= detail.getDoanhThu() %></span>
                </div>

                <!-- DETAIL LIST -->
                <div class="bn-detail-section">
                    <div class="bn-detail-row">
                        <span class="bn-detail-row__label">Tên</span>
                        <span class="bn-detail-row__value"><strong><%= detail.getTen() %></strong></span>
                    </div>
                    <div class="bn-detail-row">
                        <span class="bn-detail-row__label">Số lượng / Số lượt</span>
                        <span class="bn-detail-row__value num"><%= detail.getSoLuong() %></span>
                    </div>
                    <div class="bn-detail-row">
                        <span class="bn-detail-row__label">Ghi chú</span>
                        <span class="bn-detail-row__value">
                            <%= detail.getGhiChu() != null && !detail.getGhiChu().isEmpty() ? detail.getGhiChu() : "<span class=\"muted\">—</span>" %>
                        </span>
                    </div>
                </div>

                <% } else { %>

                <div class="bn-alert bn-alert--warning">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                    <span>Không có dữ liệu chi tiết</span>
                </div>

                <% } %>

                <div class="bn-form__actions bn-form__actions--right">
                    <a href="RevenueDetailServlet?thang=<%= thang %>&nam=<%= nam %>" class="bn-btn bn-btn--primary">
                        <i class="fa-solid fa-arrow-left"></i>
                        Quay lại trang doanh thu
                    </a>
                </div>

            </div>
        </div>
    </body>
</html>
