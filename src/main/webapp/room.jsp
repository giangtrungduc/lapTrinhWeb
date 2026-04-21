<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomDTO" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomStatus" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<RoomDTO> roomList = (List<RoomDTO>) request.getAttribute("roomList");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý phòng</title>
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
                        <span class="bn-nav__welcome">
                            Xin chào, <strong><%= user %></strong>
                        </span>
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
                            <i class="fa-solid fa-bed" style="color: var(--bn-yellow);"></i>
                            Quản lý phòng
                        </h1>
                        <p class="bn-page-header__subtitle">
                            Danh sách <%= roomList != null ? roomList.size() : 0 %> phòng trong hệ thống
                        </p>
                    </div>
                </div>

                <!-- TABS + ACTION -->
                <div class="bn-toolbar">
                    <div class="bn-tabs">
                        <a href="RoomServlet?action=list" class="bn-tabs__item is-active">
                            <i class="fa-solid fa-bed"></i>
                            Phòng
                        </a>
                        <a href="RoomServlet?action=listRoomType" class="bn-tabs__item">
                            <i class="fa-solid fa-layer-group"></i>
                            Loại phòng
                        </a>
                    </div>

                    <a href="RoomServlet?action=showAddRoom" class="bn-btn bn-btn--primary">
                        <i class="fa-solid fa-plus"></i>
                        Thêm phòng mới
                    </a>
                </div>

                <!-- TABLE -->
                <div class="bn-table-wrap">
                    <div class="bn-table-scroll">
                        <table class="bn-table">
                            <thead>
                                <tr>
                                    <th>Mã phòng</th>
                                    <th>Số phòng</th>
                                    <th>Loại phòng</th>
                                    <th>Số người tối đa</th>
                                    <th>Giá cơ bản (VNĐ)</th>
                                    <th>Trạng thái</th>
                                    <th style="text-align: center;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (roomList != null && !roomList.isEmpty()) {
                                    for (RoomDTO room : roomList) {
                                        RoomStatus tt = room.getTrangthai();
                                        String badgeClass = "bn-badge--neutral";
                                        if (tt == RoomStatus.BaoTri) {
                                            badgeClass = "bn-badge--danger";
                                        } else if ("Trống".equalsIgnoreCase(tt.getDisplayName())
                                                || "Available".equalsIgnoreCase(tt.name())) {
                                            badgeClass = "bn-badge--success";
                                        } else {
                                            badgeClass = "bn-badge--warning";
                                        }
                                %>
                                <tr>
                                    <td><strong style="color: var(--bn-yellow);">#<%= room.getMaphong() %></strong></td>
                                    <td><strong><%= room.getSophong() %></strong></td>
                                    <td><%= room.getTenloaiphong() %></td>
                                    <td class="num"><%= room.getSonguoitoida() %></td>
                                    <td class="num"><%= String.format("%,.0f", room.getGia()) %></td>
                                    <td>
                                        <span class="bn-badge <%= badgeClass %>">
                                            <%= tt.getDisplayName() %>
                                        </span>
                                    </td>
                                    <td>
                                        <div class="bn-table__actions">
                                            <a href="RoomServlet?action=showEditRoom&id=<%= room.getMaphong() %>"
                                               class="bn-btn bn-btn--icon edit" title="Sửa">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </a>
                                            <% if (tt != RoomStatus.BaoTri) { %>
                                            <a href="RoomServlet?action=deleteRoom&id=<%= room.getMaphong() %>"
                                               class="bn-btn bn-btn--icon delete"
                                               title="Chuyển về Bảo trì"
                                               onclick="return confirm('Chuyển phòng <%= room.getSophong() %> về trạng thái Bảo Trì?')">
                                                <i class="fa-solid fa-wrench"></i>
                                            </a>
                                            <% } else { %>
                                            <span class="muted" style="font-size: 12px;">Đang bảo trì</span>
                                            <% } %>
                                        </div>
                                    </td>
                                </tr>
                                <% } } else { %>
                                <tr>
                                    <td colspan="7" class="bn-table__empty">
                                        <i class="fa-solid fa-bed" style="font-size: 24px; display: block; margin-bottom: 8px; color: var(--bn-slate);"></i>
                                        Không có phòng nào.
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </main>

            <footer class="bn-footer">
                &copy; 2026 <strong>Hotel Admin</strong> · Hệ thống quản lý nội bộ
            </footer>

        </div>
    </body>
</html>
