<%@page import="java.util.List"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.ServiceDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    private String escHtml(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>
<%
    List<ServiceDTO> list = (List<ServiceDTO>) request.getAttribute("listService");
    String keyword = (String) session.getAttribute("keyword");
    if (keyword == null) keyword = "";
    String user = (String) session.getAttribute("user");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý dịch vụ</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/binance-style.css">
    <style>
        .service-grid {
            display: grid;
            grid-template-columns: minmax(320px, 420px) minmax(0, 1fr);
            gap: 20px;
            align-items: start;
        }
        .service-form-sticky {
            position: sticky;
            top: 92px;
        }
        .service-price {
            font-variant-numeric: tabular-nums;
            font-weight: 700;
            color: var(--bn-yellow);
        }
        .service-desc {
            color: var(--bn-slate);
            line-height: 1.5;
            max-width: 420px;
            word-break: break-word;
        }
        @media (max-width: 960px) {
            .service-grid { grid-template-columns: 1fr; }
            .service-form-sticky { position: static; }
        }
    </style>
    <script>
        function fillFormFromRow(row) {
            document.getElementById("maDV").value = row.dataset.madv || "";
            document.getElementById("tenDV").value = row.dataset.tendv || "";
            document.getElementById("donGia").value = row.dataset.dongia || "";
            document.getElementById("moTa").value = row.dataset.mota || "";
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        function resetForm() {
            document.getElementById("maDV").value = "";
            document.getElementById("tenDV").value = "";
            document.getElementById("donGia").value = "";
            document.getElementById("moTa").value = "";
            document.getElementById("tenDV").focus();
        }

        function validateUpdate() {
            var maDV = document.getElementById("maDV").value;
            if (!maDV || !maDV.trim()) {
                alert("Vui long chon dich vu trong bang de do vao form truoc khi sua.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
    <script>
        alert("<%= escHtml(errorMessage) %>");
    </script>
    <% } %>
    <div class="app-shell">
        <nav class="bn-nav">
            <div class="bn-nav__inner">
                <div class="bn-nav__brand">
                    <div class="bn-nav__logo-mark"><span>H</span></div>
                    <span>Hotel Admin</span>
                </div>
                <div class="bn-nav__user">
                    <% if (user != null) { %>
                    <span class="bn-nav__welcome">Xin chào, <strong><%= user %></strong></span>
                    <% } %>
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
                        <i class="fa-solid fa-concierge-bell" style="color: var(--bn-yellow);"></i>
                        Quản lý dịch vụ
                    </h1>
                    <p class="bn-page-header__subtitle">
                        Thêm, cập nhật, tìm kiếm và quản lý danh mục dịch vụ trong hệ thống
                    </p>
                </div>
                <div class="bn-count">
                    <i class="fa-solid fa-layer-group"></i>
                    <span><%= list != null ? list.size() : 0 %> dịch vụ</span>
                </div>
            </div>

            <div class="service-grid">
                <div class="service-form-sticky">
                    <div class="bn-panel">
                        <div class="bn-panel__head">
                            <div class="bn-panel__title">
                                <i class="fa-solid fa-pen-to-square"></i>
                                Biểu mẫu dịch vụ
                            </div>
                        </div>

                        <form action="ServiceManagementServlet" method="post" class="bn-form">
                            <div class="bn-field">
                                <label class="bn-label" for="maDV">
                                    <i class="fa-solid fa-hashtag"></i>
                                    Mã dịch vụ
                                </label>
                                <input type="text" id="maDV" name="maDV" class="bn-input" readonly placeholder="Tự động tạo khi thêm mới">
                            </div>

                            <div class="bn-field">
                                <label class="bn-label" for="tenDV">
                                    <i class="fa-solid fa-tag"></i>
                                    Tên dịch vụ
                                </label>
                                <input type="text" id="tenDV" name="tenDV" class="bn-input" placeholder="Ví dụ: Giặt là, Buffet sáng...">
                            </div>

                            <div class="bn-field">
                                <label class="bn-label" for="donGia">
                                    <i class="fa-solid fa-money-bill-wave"></i>
                                    Giá dịch vụ
                                </label>
                                <input type="text" id="donGia" name="donGia" class="bn-input" placeholder="Nhập đơn giá">
                            </div>

                            <div class="bn-field">
                                <label class="bn-label" for="moTa">
                                    <i class="fa-solid fa-align-left"></i>
                                    Mô tả
                                </label>
                                <textarea id="moTa" name="moTa" class="bn-textarea" placeholder="Mô tả ngắn về dịch vụ"></textarea>
                            </div>

                            <div class="bn-form__actions">
                                <button type="submit" name="action" value="add" class="bn-btn bn-btn--success">
                                    <i class="fa-solid fa-plus"></i>
                                    Thêm
                                </button>
                                <button type="submit" name="action" value="update" class="bn-btn bn-btn--primary" onclick="return validateUpdate()">
                                    <i class="fa-solid fa-floppy-disk"></i>
                                    Cập nhật
                                </button>
                            </div>

                            <div class="bn-form__actions" style="padding-top: 12px; margin-top: -8px; border-top: none;">
                                <a href="ServiceManagementServlet" class="bn-btn bn-btn--ghost">
                                    <i class="fa-solid fa-rotate"></i>
                                    Làm mới
                                </a>
                                <button type="button" class="bn-btn bn-btn--outline" onclick="resetForm()">
                                    <i class="fa-solid fa-eraser"></i>
                                    Xoá form
                                </button>
                            </div>
                        </form>

                        <div class="bn-note">
                            <i class="fa-solid fa-circle-info"></i>
                            Chọn một dòng trong bảng để tự động đổ dữ liệu lên biểu mẫu sửa.
                        </div>
                    </div>
                </div>

                <div>
                    <form action="ServiceManagementServlet" method="post" class="bn-filter">
                        <div class="bn-filter__field bn-filter__field--grow">
                            <label class="bn-label" for="search">
                                <i class="fa-solid fa-magnifying-glass"></i>
                                Tìm kiếm dịch vụ
                            </label>
                            <input
                                type="text"
                                id="search"
                                name="search"
                                class="bn-input"
                                value="<%= escHtml(keyword) %>"
                                placeholder="Nhập tên dịch vụ, giá dịch vụ hoặc mô tả để tìm kiếm">
                        </div>

                        <div class="bn-filter__actions">
                            <button type="submit" name="action" value="search" class="bn-btn bn-btn--primary">
                                <i class="fa-solid fa-magnifying-glass"></i>
                                Tìm kiếm
                            </button>
                            <a href="ServiceManagementServlet" class="bn-btn bn-btn--ghost">
                                <i class="fa-solid fa-xmark"></i>
                                Xoá lọc
                            </a>
                        </div>
                    </form>

                    <div class="bn-table-wrap">
                        <div class="bn-table-scroll">
                            <table class="bn-table bn-table--clickable">
                                <thead>
                                    <tr>
                                        <th>Mã DV</th>
                                        <th>Tên dịch vụ</th>
                                        <th>Giá dịch vụ</th>
                                        <th>Mô tả</th>
                                        <th style="text-align: center;">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (list != null && !list.isEmpty()) {
                                        for (ServiceDTO dv : list) { %>
                                    <tr
                                        onclick="fillFormFromRow(this)"
                                        data-madv="<%= escHtml(String.valueOf(dv.getMaDV())) %>"
                                        data-tendv="<%= escHtml(dv.getTenDV()) %>"
                                        data-dongia="<%= escHtml(String.valueOf(dv.getDonGia())) %>"
                                        data-mota="<%= escHtml(dv.getMoTa()) %>">
                                        <td><strong style="color: var(--bn-yellow);">#<%= dv.getMaDV() %></strong></td>
                                        <td><strong><%= dv.getTenDV() %></strong></td>
                                        <td class="service-price"><%= dv.getDonGia() %></td>
                                        <td class="service-desc"><%= dv.getMoTa() %></td>
                                        <td>
                                            <div class="bn-table__actions">
                                                <button type="button" class="bn-btn bn-btn--icon edit" title="Đổ dữ liệu lên form" onclick="event.stopPropagation(); fillFormFromRow(this.closest('tr'));">
                                                    <i class="fa-solid fa-pen"></i>
                                                </button>
                                                <form action="ServiceManagementServlet" method="post" class="bn-inline-form" onclick="event.stopPropagation();">
                                                    <input type="hidden" name="maDV" value="<%= dv.getMaDV() %>">
                                                    <button
                                                        type="submit"
                                                        name="action"
                                                        value="delete"
                                                        class="bn-btn bn-btn--icon delete"
                                                        title="Xoá dịch vụ"
                                                        onclick="return confirm('Bạn có chắc muốn xóa dịch vụ này không?');">
                                                        <i class="fa-solid fa-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } } else { %>
                                    <tr>
                                        <td colspan="5" class="bn-table__empty">
                                            <i class="fa-solid fa-concierge-bell" style="font-size: 24px; display: block; margin-bottom: 8px; color: var(--bn-slate);"></i>
                                            Không có dữ liệu dịch vụ
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <footer class="bn-footer">
            &copy; 2026 <strong>Hotel Admin</strong> · Quản lý dịch vụ nội bộ
        </footer>
    </div>
</body>
</html>
