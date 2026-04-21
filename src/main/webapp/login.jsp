<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String error = (String) request.getAttribute("failLogin");
    if (error == null) error = "";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập hệ thống</title>
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
                    <i class="fa-solid fa-hotel"></i>
                </div>
                <h1 class="bn-form-card__title">Đăng nhập hệ thống</h1>
                <p class="bn-form-card__subtitle">
                    Truy cập khu vực quản trị khách sạn với tài khoản của bạn
                </p>
            </div>

            <% if (!error.trim().isEmpty()) { %>
            <div class="bn-alert bn-alert--error" style="margin-bottom: 20px;">
                <i class="fa-solid fa-circle-exclamation"></i>
                <span><%= error %></span>
            </div>
            <% } %>

            <form action="LoginServlet" method="post" class="bn-form">
                <div class="bn-field">
                    <label class="bn-label" for="username">
                        <i class="fa-solid fa-user"></i>
                        Tên đăng nhập
                    </label>
                    <input
                        type="text"
                        id="username"
                        name="username"
                        class="bn-input"
                        placeholder="Nhập tên đăng nhập"
                        autocomplete="username"
                        required>
                </div>

                <div class="bn-field">
                    <label class="bn-label" for="password">
                        <i class="fa-solid fa-lock"></i>
                        Mật khẩu
                    </label>
                    <input
                        type="password"
                        id="password"
                        name="password"
                        class="bn-input"
                        placeholder="Nhập mật khẩu"
                        autocomplete="current-password"
                        required>
                </div>

                <div class="bn-form__actions" style="border-top: none; margin-top: 0; padding-top: 8px; flex-direction: column;">
                    <button type="submit" class="bn-btn bn-btn--primary bn-btn--block">
                        <i class="fa-solid fa-right-to-bracket"></i>
                        Đăng nhập
                    </button>

                    <a href="BookingByCustomer" class="bn-btn bn-btn--outline bn-btn--block" style="text-align: center;">
                        <i class="fa-solid fa-user-check"></i>
                        Vào với tư cách khách
                    </a>
                </div>
            </form>

            <div class="bn-note" style="margin-top: 20px;">
                <i class="fa-solid fa-shield-halved"></i>
                Hệ thống quản lý khách sạn · Giao diện nội bộ dành cho nhân viên và quản trị viên
            </div>
        </div>
    </div>
</body>
</html>
