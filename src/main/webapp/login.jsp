<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String error=(String) request.getAttribute("failLogin");
    if (error==null) error="";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập hệ thống</title>
    <style>
        * {
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            margin: 0;
            padding: 0;
            background: #f2f4f8;
        }

        .container {
            width: 100%;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-box {
            width: 380px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .login-box h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #444;
        }

        .form-group input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            outline: none;
        }

        .form-group input:focus {
            border-color: #4a90e2;
        }

        .btn-login {
            width: 100%;
            padding: 11px;
            background: #4a90e2;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        .btn-login:hover {
            background: #357bd8;
        }

        .error {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }

        .footer-text {
            text-align: center;
            margin-top: 15px;
            color: #777;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-box">
            <h2>Đăng nhập hệ thống</h2>
            <div style="color:red;">
                <%=error%>
            </div>
            <form action="LoginServlet" method="post">
                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" required>
                </div>

                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <input type="password" id="password" name="password" required>
                </div>

                <button type="submit" class="btn-login">Đăng nhập</button>
            </form>

            <div class="footer-text">
                Hệ thống quản lý khách sạn
            </div>
        </div>
    </div>
</body>
</html>