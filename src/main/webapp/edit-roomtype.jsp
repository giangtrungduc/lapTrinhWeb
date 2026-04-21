<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.mycompany.laptrinhweb.model.dto.RoomTypeDTO" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    RoomTypeDTO rt = (RoomTypeDTO) request.getAttribute("roomType");
    if (rt == null) {
        response.sendRedirect("RoomServlet?action=listRoomType");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sửa loại phòng</title>
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
                        <i class="fa-solid fa-layer-group"></i>
                    </div>
                    <h1 class="bn-form-card__title">Sửa loại phòng</h1>
                    <p class="bn-form-card__subtitle">
                        Cập nhật thông tin loại phòng <strong style="color: var(--bn-text-primary);"><%= rt.getTenloaiphong() %></strong>
                    </p>
                </div>

                <form action="RoomServlet?action=editRoomType" method="post" class="bn-form">
                    <input type="hidden" name="maLoaiPhong" value="<%= rt.getMaloaiphong() %>" />

                    <div class="bn-field">
                        <label class="bn-label" for="tenLoaiPhong">
                            <i class="fa-solid fa-tag"></i>
                            Tên loại phòng
                            <span class="bn-label__required">*</span>
                        </label>
                        <input type="text" id="tenLoaiPhong" name="tenLoaiPhong"
                               class="bn-input"
                               value="<%= rt.getTenloaiphong() %>" required />
                    </div>

                    <div class="bn-form__row">
                        <div class="bn-field">
                            <label class="bn-label" for="soNguoiToiDa">
                                <i class="fa-solid fa-user-group"></i>
                                Số người tối đa
                                <span class="bn-label__required">*</span>
                            </label>
                            <input type="number" id="soNguoiToiDa" name="soNguoiToiDa"
                                   class="bn-input"
                                   value="<%= rt.getSonguoitoida() %>" required min="1" />
                        </div>

                        <div class="bn-field">
                            <label class="bn-label" for="giaCoBan">
                                <i class="fa-solid fa-sack-dollar"></i>
                                Giá cơ bản (VNĐ)
                                <span class="bn-label__required">*</span>
                            </label>
                            <input type="number" id="giaCoBan" name="giaCoBan"
                                   class="bn-input"
                                   value="<%= (int) rt.getGiacoban() %>" required min="0" step="1000" />
                        </div>
                    </div>

                    <div class="bn-form__actions bn-form__actions--right">
                        <a href="RoomServlet?action=listRoomType" class="bn-btn bn-btn--ghost">
                            <i class="fa-solid fa-xmark"></i>
                            Huỷ
                        </a>
                        <button type="submit" class="bn-btn bn-btn--primary">
                            <i class="fa-solid fa-check"></i>
                            Lưu thay đổi
                        </button>
                    </div>
                </form>

            </div>
        </div>
    </body>
</html>
