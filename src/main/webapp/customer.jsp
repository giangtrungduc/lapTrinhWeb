<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.CustomerDTO"%>
<%
    List<CustomerDTO> customerList = (List<CustomerDTO>) request.getAttribute("customerList");
    if (customerList == null)
        customerList = new ArrayList<>();
    String filter = request.getParameter("filter") != null ? request.getParameter("filter") : "";
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý khách hàng</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/binance-style.css">
        <script>
            function openEditModal(id, name, phone) {
                document.getElementById('editModal').classList.add('is-open');
                document.getElementById('edit-id').value = id;
                document.getElementById('edit-name').value = name;
                document.getElementById('edit-phone').value = phone;
            }

            function closeModal() {
                document.getElementById('editModal').classList.remove('is-open');
            }

            window.onclick = function (event) {
                let modal = document.getElementById('editModal');
                if (event.target == modal) closeModal();
            }

            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') closeModal();
            });
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
                            <i class="fa-solid fa-users-gear" style="color: var(--bn-yellow);"></i>
                            Quản lý khách hàng
                        </h1>
                        <p class="bn-page-header__subtitle">
                            Danh sách <%= customerList.size() %> khách hàng trong hệ thống
                        </p>
                    </div>
                </div>

                <div class="bn-toolbar">
                    <form action="add-customer-form.jsp" method="post" class="bn-inline-form">
                        <button type="submit" class="bn-btn bn-btn--primary">
                            <i class="fa-solid fa-plus"></i>
                            Thêm mới khách hàng
                        </button>
                    </form>

                    <form action="FilterCustomerServlet" method="post" class="bn-search">
                        <i class="fa-solid fa-magnifying-glass bn-search__icon"></i>
                        <input type="text" name="filter"
                               class="bn-search__input"
                               placeholder="Tìm theo tên, CCCD, SĐT..."
                               value="<%= filter %>">
                        <button type="submit" class="bn-search__btn">
                            Tìm kiếm
                        </button>
                    </form>
                </div>

                <div class="bn-table-wrap">
                    <div class="bn-table-scroll">
                        <table class="bn-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Họ tên</th>
                                    <th>CCCD</th>
                                    <th>SĐT</th>
                                    <th>Email</th>
                                    <th>Địa chỉ</th>
                                    <th>Lượt đặt</th>
                                    <th style="text-align: center;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (!customerList.isEmpty()) {
                                    for (CustomerDTO cus : customerList) { %>
                                <tr>
                                    <td><strong style="color: var(--bn-yellow);">#<%= cus.getMakh() %></strong></td>
                                    <td><strong><%= cus.getHoten() %></strong></td>
                                    <td class="num"><%= cus.getCccd() %></td>
                                    <td class="num"><%= cus.getSdt() %></td>
                                    <td><span class="muted" style="font-style: normal;"><%= cus.getEmail() %></span></td>
                                    <td><%= cus.getDiachi() %></td>
                                    <td><span class="bn-count"><%= cus.getSolandat() %> lần</span></td>
                                    <td>
                                        <div class="bn-table__actions">
                                            <button type="button" class="bn-btn bn-btn--icon edit"
                                                    title="Chỉnh sửa"
                                                    onclick="openEditModal('<%= cus.getMakh() %>', '<%= cus.getHoten().replace("'", "\\'") %>', '<%= cus.getSdt() %>')">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </button>
                                            <a href="DeleteCustomerServlet?id=<%= cus.getMakh() %>"
                                               class="bn-btn bn-btn--icon delete"
                                               title="Xoá"
                                               onclick="return confirm('Bạn có chắc muốn xoá khách hàng này?')">
                                                <i class="fa-solid fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                                <% } } else { %>
                                <tr>
                                    <td colspan="8" class="bn-table__empty">
                                        <i class="fa-solid fa-users-slash" style="font-size: 24px; display: block; margin-bottom: 8px; color: var(--bn-slate);"></i>
                                        Không có khách hàng nào
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

        <!-- Modal chỉnh sửa -->
        <div id="editModal" class="bn-modal">
            <div class="bn-modal__content">
                <button type="button" class="bn-modal__close" onclick="closeModal()">
                    <i class="fa-solid fa-xmark"></i>
                </button>

                <div class="bn-modal__header">
                    <h3 class="bn-modal__title">
                        <i class="fa-solid fa-user-pen"></i>
                        Chỉnh sửa khách hàng
                    </h3>
                </div>

                <form action="UpdateCustomerServlet" method="POST" class="bn-form">
                    <input type="hidden" id="edit-id" name="id">

                    <div class="bn-field">
                        <label class="bn-label" for="edit-name">
                            <i class="fa-solid fa-signature"></i>
                            Họ tên
                        </label>
                        <input type="text" id="edit-name" name="name" class="bn-input">
                    </div>

                    <div class="bn-field">
                        <label class="bn-label" for="edit-phone">
                            <i class="fa-solid fa-phone"></i>
                            Số điện thoại
                        </label>
                        <input type="text" id="edit-phone" name="phone" class="bn-input">
                    </div>

                    <div class="bn-form__actions bn-form__actions--right">
                        <button type="button" class="bn-btn bn-btn--ghost" onclick="closeModal()">
                            Huỷ
                        </button>
                        <button type="submit" class="bn-btn bn-btn--primary">
                            <i class="fa-solid fa-check"></i>
                            Cập nhật
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
