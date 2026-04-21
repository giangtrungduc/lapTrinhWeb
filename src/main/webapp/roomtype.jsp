<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomTypeDTO" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<RoomTypeDTO> roomTypeList = (List<RoomTypeDTO>) request.getAttribute("roomTypeList");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý loại phòng</title>
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
                            <i class="fa-solid fa-layer-group" style="color: var(--bn-yellow);"></i>
                            Quản lý loại phòng
                        </h1>
                        <p class="bn-page-header__subtitle">
                            Danh sách <%= roomTypeList != null ? roomTypeList.size() : 0 %> loại phòng đang được cấu hình
                        </p>
                    </div>
                </div>

                <!-- TABS + ACTION -->
                <div class="bn-toolbar">
                    <div class="bn-tabs">
                        <a href="RoomServlet?action=list" class="bn-tabs__item">
                            <i class="fa-solid fa-bed"></i>
                            Phòng
                        </a>
                        <a href="RoomServlet?action=listRoomType" class="bn-tabs__item is-active">
                            <i class="fa-solid fa-layer-group"></i>
                            Loại phòng
                        </a>
                    </div>

                    <a href="RoomServlet?action=showAddRoomType" class="bn-btn bn-btn--primary">
                        <i class="fa-solid fa-plus"></i>
                        Thêm loại phòng mới
                    </a>
                </div>

                <!-- TABLE -->
                <div class="bn-table-wrap">
                    <div class="bn-table-scroll">
                        <table class="bn-table">
                            <thead>
                                <tr>
                                    <th>Mã loại phòng</th>
                                    <th>Tên loại phòng</th>
                                    <th>Số người tối đa</th>
                                    <th>Giá cơ bản (VNĐ)</th>
                                    <th style="text-align: center;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (roomTypeList != null && !roomTypeList.isEmpty()) {
                                    for (RoomTypeDTO rt : roomTypeList) { %>
                                <tr>
                                    <td><strong style="color: var(--bn-yellow);">#<%= rt.getMaloaiphong() %></strong></td>
                                    <td><strong><%= rt.getTenloaiphong() %></strong></td>
                                    <td class="num"><%= rt.getSonguoitoida() %></td>
                                    <td class="num"><%= String.format("%,.0f", rt.getGiacoban()) %></td>
                                    <td>
                                        <div class="bn-table__actions">
                                            <a href="RoomServlet?action=showEditRoomType&id=<%= rt.getMaloaiphong() %>"
                                               class="bn-btn bn-btn--icon edit" title="Sửa">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                                <% } } else { %>
                                <tr>
                                    <td colspan="5" class="bn-table__empty">
                                        <i class="fa-solid fa-layer-group" style="font-size: 24px; display: block; margin-bottom: 8px; color: var(--bn-slate);"></i>
                                        Không có loại phòng nào.
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
