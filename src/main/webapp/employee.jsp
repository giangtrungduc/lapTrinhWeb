<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.EmployeeDTO"%>
<%
    List<EmployeeDTO> list = (List<EmployeeDTO>) request.getAttribute("nhanVienList");
    String message = (String) request.getAttribute("message");
    String keyword = (String) request.getAttribute("keyword");
    if (keyword == null) keyword = "";
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý nhân viên</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/binance-style.css">
        <script>
            function fillForm(maNV, hoTen, sdt, chucVu, tenDangNhap, matKhauHash) {
                document.getElementById("maNV").value = maNV;
                document.getElementById("hoTen").value = hoTen;
                document.getElementById("sdt").value = sdt;
                document.getElementById("chucVu").value = chucVu;
                document.getElementById("tenDangNhap").value = tenDangNhap;
                document.getElementById("matKhauHash").value = matKhauHash;
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }

            function resetForm() {
                document.getElementById("maNV").value = "";
                document.getElementById("hoTen").value = "";
                document.getElementById("sdt").value = "";
                document.getElementById("chucVu").value = "";
                document.getElementById("tenDangNhap").value = "";
                document.getElementById("matKhauHash").value = "";
            }
        </script>
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
                    Quay lại trang chính
                </a>

                <div class="bn-page-header">
                    <div>
                        <h1 class="bn-page-header__title">
                            <i class="fa-solid fa-id-badge" style="color: var(--bn-yellow);"></i>
                            Quản lý nhân viên
                        </h1>
                        <p class="bn-page-header__subtitle">
                            Thêm mới, chỉnh sửa và tìm kiếm thông tin nhân viên
                        </p>
                    </div>
                </div>

                <% if (message != null && !message.trim().isEmpty()) { %>
                    <div class="bn-alert bn-alert--info" style="margin-bottom: 20px;">
                        <i class="fa-solid fa-circle-info"></i>
                        <span><%= message %></span>
                    </div>
                <% } %>

                <!-- FORM PANEL -->
                <div class="bn-panel">
                    <div class="bn-panel__head">
                        <div class="bn-panel__title">
                            <i class="fa-solid fa-user-pen"></i>
                            Thông tin nhân viên
                        </div>
                    </div>

                    <form action="EmployeeServlet" method="post" class="bn-form">
                        <div class="bn-form-grid">

                            <div class="bn-field">
                                <label class="bn-label" for="maNV">
                                    <i class="fa-solid fa-hashtag"></i>
                                    Mã nhân viên
                                </label>
                                <input type="text" id="maNV" name="maNV" class="bn-input" readonly>
                            </div>

                            <div class="bn-field">
                                <label class="bn-label" for="hoTen">
                                    <i class="fa-solid fa-signature"></i>
                                    Họ tên
                                    <span class="bn-label__required">*</span>
                                </label>
                                <input type="text" id="hoTen" name="hoTen" class="bn-input" required>
                            </div>

                            <div class="bn-field">
                                <label class="bn-label" for="sdt">
                                    <i class="fa-solid fa-phone"></i>
                                    Số điện thoại
                                </label>
                                <input type="text" id="sdt" name="sdt" class="bn-input">
                            </div>

                            <div class="bn-field">
                                <label class="bn-label" for="chucVu">
                                    <i class="fa-solid fa-user-tie"></i>
                                    Chức vụ
                                    <span class="bn-label__required">*</span>
                                </label>
                                <input type="text" id="chucVu" name="chucVu" class="bn-input" required>
                            </div>

                            <div class="bn-field">
                                <label class="bn-label" for="tenDangNhap">
                                    <i class="fa-solid fa-user"></i>
                                    Tên đăng nhập
                                    <span class="bn-label__required">*</span>
                                </label>
                                <input type="text" id="tenDangNhap" name="tenDangNhap" class="bn-input" required>
                            </div>

                            <div class="bn-field">
                                <label class="bn-label" for="matKhauHash">
                                    <i class="fa-solid fa-key"></i>
                                    Mật khẩu
                                    <span class="bn-label__required">*</span>
                                </label>
                                <input type="text" id="matKhauHash" name="matKhauHash" class="bn-input" required>
                            </div>
                        </div>

                        <div class="bn-form__actions">
                            <button type="submit" name="action" value="add" class="bn-btn bn-btn--success">
                                <i class="fa-solid fa-plus"></i>
                                Thêm mới
                            </button>
                            <button type="submit" name="action" value="update" class="bn-btn bn-btn--primary">
                                <i class="fa-solid fa-pen-to-square"></i>
                                Cập nhật
                            </button>
                            <a href="EmployeeServlet" class="bn-btn bn-btn--ghost">
                                <i class="fa-solid fa-rotate"></i>
                                Làm mới
                            </a>
                            <button type="button" onclick="resetForm()" class="bn-btn bn-btn--ghost">
                                <i class="fa-solid fa-eraser"></i>
                                Xoá form
                            </button>
                        </div>

                        <div class="bn-note">
                            <i class="fa-solid fa-lightbulb" style="color: var(--bn-yellow);"></i>
                            <span>Bấm vào một dòng trong bảng để nạp dữ liệu lên form và chỉnh sửa.</span>
                        </div>
                    </form>
                </div>

                <!-- SEARCH -->
                <form action="EmployeeServlet" method="get" class="bn-search" style="margin-bottom: 20px;">
                    <i class="fa-solid fa-magnifying-glass bn-search__icon"></i>
                    <input type="text" name="keyword" value="<%= keyword %>"
                           class="bn-search__input"
                           placeholder="Tìm theo mã, họ tên, SĐT, chức vụ hoặc tên đăng nhập...">
                    <button type="submit" name="action" value="search" class="bn-search__btn">
                        Tìm kiếm
                    </button>
                </form>

                <!-- TABLE -->
                <div class="bn-table-wrap">
                    <div class="bn-table-scroll">
                        <table class="bn-table bn-table--clickable">
                            <thead>
                                <tr>
                                    <th>Mã NV</th>
                                    <th>Họ tên</th>
                                    <th>SĐT</th>
                                    <th>Chức vụ</th>
                                    <th>Tên đăng nhập</th>
                                    <th style="text-align: center;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (list != null && !list.isEmpty()) {
                                    for (EmployeeDTO item : list) { %>
                                <tr onclick="fillForm('<%= item.getMaNV() %>', '<%= item.getHoTen() == null ? "" : item.getHoTen().replace("'", "\\'") %>', '<%= item.getSdt() == null ? "" : item.getSdt().replace("'", "\\'") %>', '<%= item.getChucVu() == null ? "" : item.getChucVu().replace("'", "\\'") %>', '<%= item.getTenDangNhap() == null ? "" : item.getTenDangNhap().replace("'", "\\'") %>', '<%= item.getMatKhauHash() == null ? "" : item.getMatKhauHash().replace("'", "\\'") %>')">
                                    <td><strong style="color: var(--bn-yellow);"><%= item.getMaNV() %></strong></td>
                                    <td><strong><%= item.getHoTen() %></strong></td>
                                    <td class="num"><%= item.getSdt() %></td>
                                    <td>
                                        <span class="bn-badge bn-badge--info">
                                            <%= item.getChucVu() %>
                                        </span>
                                    </td>
                                    <td><%= item.getTenDangNhap() %></td>
                                    <td>
                                        <div class="bn-table__actions">
                                            <form action="EmployeeServlet" method="post"
                                                  class="bn-inline-form"
                                                  onsubmit="return confirm('Bạn có chắc muốn xoá nhân viên này không?');"
                                                  onclick="event.stopPropagation();">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="maNV" value="<%= item.getMaNV() %>">
                                                <button type="submit" class="bn-btn bn-btn--icon delete" title="Xoá">
                                                    <i class="fa-solid fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                <% } } else { %>
                                <tr>
                                    <td colspan="6" class="bn-table__empty">
                                        <i class="fa-solid fa-user-slash" style="font-size: 24px; display: block; margin-bottom: 8px; color: var(--bn-slate);"></i>
                                        Không có dữ liệu nhân viên
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
