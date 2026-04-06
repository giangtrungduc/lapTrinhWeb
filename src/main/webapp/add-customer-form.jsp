<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>THÊM KHÁCH HÀNG MỚI</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        
        <style>
            :root {
                --primary-color: #4361ee;
                --bg-color: #f8f9fa;
                --text-color: #212529;
                --border-color: #dee2e6;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-color);
                color: var(--text-color);
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
            }

            .form-container {
                background: white;
                padding: 40px;
                border-radius: 16px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.08);
                width: 100%;
                max-width: 500px;
            }

            h2 {
                color: var(--primary-color);
                font-weight: 600;
                margin-bottom: 30px;
                text-align: center;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                font-weight: 600;
                margin-bottom: 8px;
                font-size: 14px;
                color: #495057;
            }

            input {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                font-family: inherit;
                font-size: 14px;
                box-sizing: border-box; /* Cực kỳ quan trọng để input không bị tràn */
                transition: all 0.3s ease;
            }

            input:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
            }

            /* Nút bấm chính */
            .btn-submit {
                width: 100%;
                background-color: var(--primary-color);
                color: white;
                border: none;
                padding: 14px;
                border-radius: 8px;
                font-weight: 600;
                font-size: 16px;
                cursor: pointer;
                transition: background 0.3s;
                margin-top: 10px;
            }

            .btn-submit:hover {
                background-color: #3f37c9;
            }

            /* Các nút điều hướng phụ */
            .action-links {
                margin-top: 25px;
                display: flex;
                gap: 10px;
                border-top: 1px solid #eee;
                padding-top: 20px;
            }

            .btn-secondary {
                flex: 1;
                background-color: #e9ecef;
                color: #495057;
                border: none;
                padding: 10px;
                border-radius: 6px;
                font-size: 13px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s;
            }

            .btn-secondary:hover {
                background-color: #dee2e6;
            }

            .fa-icon {
                margin-right: 5px;
            }
        </style>
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

        <div class="form-container">
            <h2><i class="fa-solid fa-user-plus"></i> Thêm Khách Hàng</h2>
            
            <form action="AddCustomer" method="post">
                <div class="form-group">
                    <label><i class="fa-solid fa-signature fa-icon"></i> Tên khách hàng</label>
                    <input type="text" name="name" placeholder="VD: Nguyễn Văn A" required>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-id-card fa-icon"></i> CCCD</label>
                    <input type="text" name="identify" placeholder="Nhập 12 số CCCD" required>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-phone fa-icon"></i> Số điện thoại</label>
                    <input type="text" name="phonenumber" placeholder="VD: 0912345678" required>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-envelope fa-icon"></i> Email</label>
                    <input type="email" name="email" placeholder="example@gmail.com">
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-location-dot fa-icon"></i> Địa chỉ</label>
                    <input type="text" name="address" placeholder="Thành phố, Quận/Huyện">
                </div>

                <button type="submit" class="btn-submit">Xác nhận thêm mới</button>
            </form>

            <div class="action-links">
                <form action="CustomerServlet" method="post" style="flex: 1;">
                    <button type="submit" class="btn-secondary">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại
                    </button>
                </form>
                
                <form action="" method="post" style="flex: 1;">
                    <button type="submit" class="btn-secondary">
                        Đặt phòng <i class="fa-solid fa-calendar-check"></i>
                    </button>
                </form>
            </div>
        </div>
    </body>
</html>