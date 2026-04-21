<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm khách hàng mới</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/binance-style.css">
    </head>
    <body>
        <%
            String message = (String) request.getAttribute("message");
        %>
        <% if (message != null) { %>
            <script>
                let msg = `<%= message.replace("`", "\\`").replace("\n", " ") %>`;
                alert(msg);
            </script>
        <% } %>

        <div class="bn-auth-shell">
            <div class="bn-form-card">

                <div class="bn-form-card__header">
                    <div class="bn-form-card__badge">
                        <i class="fa-solid fa-user-plus"></i>
                    </div>
                    <h1 class="bn-form-card__title">Thêm khách hàng</h1>
                    <p class="bn-form-card__subtitle">
                        Nhập thông tin khách hàng mới vào hệ thống
                    </p>
                </div>

                <form action="AddCustomer" method="post" class="bn-form">

                    <div class="bn-field">
                        <label class="bn-label" for="name">
                            <i class="fa-solid fa-signature"></i>
                            Tên khách hàng
                            <span class="bn-label__required">*</span>
                        </label>
                        <input type="text" id="name" name="name"
                               class="bn-input"
                               placeholder="VD: Nguyễn Văn A" required>
                    </div>

                    <div class="bn-form__row">
                        <div class="bn-field">
                            <label class="bn-label" for="identify">
                                <i class="fa-solid fa-id-card"></i>
                                CCCD
                                <span class="bn-label__required">*</span>
                            </label>
                            <input type="text" id="identify" name="identify"
                                   class="bn-input"
                                   placeholder="12 số CCCD" required>
                        </div>

                        <div class="bn-field">
                            <label class="bn-label" for="phonenumber">
                                <i class="fa-solid fa-phone"></i>
                                Số điện thoại
                                <span class="bn-label__required">*</span>
                            </label>
                            <input type="text" id="phonenumber" name="phonenumber"
                                   class="bn-input"
                                   placeholder="0912345678" required>
                        </div>
                    </div>

                    <div class="bn-field">
                        <label class="bn-label" for="email">
                            <i class="fa-solid fa-envelope"></i>
                            Email
                        </label>
                        <input type="email" id="email" name="email"
                               class="bn-input"
                               placeholder="example@gmail.com">
                    </div>

                    <div class="bn-field">
                        <label class="bn-label" for="address">
                            <i class="fa-solid fa-location-dot"></i>
                            Địa chỉ
                        </label>
                        <input type="text" id="address" name="address"
                               class="bn-input"
                               placeholder="Thành phố, Quận/Huyện">
                    </div>

                    <button type="submit" class="bn-btn bn-btn--primary bn-btn--block">
                        <i class="fa-solid fa-check"></i>
                        Xác nhận thêm mới
                    </button>
                </form>

                <div class="bn-form__actions">
                    <form action="CustomerServlet" method="post" style="flex: 1;">
                        <button type="submit" class="bn-btn bn-btn--ghost bn-btn--block">
                            <i class="fa-solid fa-arrow-left"></i>
                            Quay lại
                        </button>
                    </form>

                    <form action="" method="post" style="flex: 1;">
                        <button type="submit" class="bn-btn bn-btn--outline bn-btn--block">
                            Đặt phòng
                            <i class="fa-solid fa-calendar-check"></i>
                        </button>
                    </form>
                </div>

            </div>
        </div>
    </body>
</html>
