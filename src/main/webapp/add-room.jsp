<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomTypeDTO" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomStatus" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<RoomTypeDTO> roomTypes = (List<RoomTypeDTO>) request.getAttribute("roomTypes");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm phòng mới</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/binance-style.css">
    </head>
    <body>
        <div class="bn-auth-shell">
            <div class="bn-form-card">

                <div class="bn-form-card__header">
                    <div class="bn-form-card__badge">
                        <i class="fa-solid fa-bed"></i>
                    </div>
                    <h1 class="bn-form-card__title">Thêm phòng mới</h1>
                    <p class="bn-form-card__subtitle">
                        Nhập thông tin phòng mới vào hệ thống
                    </p>
                </div>

                <form action="RoomServlet?action=addRoom" method="post" class="bn-form">

                    <div class="bn-field">
                        <label class="bn-label" for="soPhong">
                            <i class="fa-solid fa-hashtag"></i>
                            Số phòng
                            <span class="bn-label__required">*</span>
                        </label>
                        <input type="number" id="soPhong" name="soPhong"
                               class="bn-input"
                               placeholder="VD: 101" required min="1" />
                    </div>

                    <div class="bn-field">
                        <label class="bn-label" for="maLoaiPhong">
                            <i class="fa-solid fa-layer-group"></i>
                            Loại phòng
                            <span class="bn-label__required">*</span>
                        </label>
                        <select name="maLoaiPhong" id="maLoaiPhong" class="bn-select" required>
                            <option value="">-- Chọn loại phòng --</option>
                            <% if (roomTypes != null) {
                                for (RoomTypeDTO rt : roomTypes) { %>
                            <option value="<%= rt.getMaloaiphong() %>">
                                <%= rt.getTenloaiphong() %> — <%= String.format("%,.0f", rt.getGiacoban()) %> VNĐ
                            </option>
                            <% } } %>
                        </select>
                    </div>

                    <div class="bn-field">
                        <label class="bn-label" for="trangThai">
                            <i class="fa-solid fa-circle-info"></i>
                            Trạng thái
                        </label>
                        <select name="trangThai" id="trangThai" class="bn-select">
                            <% for (RoomStatus s : RoomStatus.values()) { %>
                            <option value="<%= s.name() %>"><%= s.getDisplayName() %></option>
                            <% } %>
                        </select>
                    </div>

                    <div class="bn-form__actions bn-form__actions--right">
                        <a href="RoomServlet?action=list" class="bn-btn bn-btn--ghost">
                            <i class="fa-solid fa-xmark"></i>
                            Huỷ
                        </a>
                        <button type="submit" class="bn-btn bn-btn--primary">
                            <i class="fa-solid fa-plus"></i>
                            Thêm phòng
                        </button>
                    </div>
                </form>

            </div>
        </div>
    </body>
</html>
