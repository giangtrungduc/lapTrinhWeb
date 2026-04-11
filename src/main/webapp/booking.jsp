<%@page import="java.util.ArrayList" %>
    <%@page import="java.util.List" %>
        <%@page import="com.mycompany.laptrinhweb.model.dto.RoomDTO" %>
            <%@page import="com.mycompany.laptrinhweb.model.dto.CustomerDTO" %>
                <%@page import="java.text.NumberFormat" %>
                    <%@page import="java.util.Locale" %>
                        <% List<RoomDTO> phongTrongList = (List<RoomDTO>) request.getAttribute("phongTrongList");
                                if (phongTrongList == null) phongTrongList = new ArrayList<>();

                                    List<CustomerDTO> customerList = (List<CustomerDTO>)
                                            request.getAttribute("customerList");
                                            if (customerList == null) customerList = new ArrayList<>();

                                                String message = (String) request.getAttribute("message");
                                                NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
                                                %>
                                                <%@page contentType="text/html" pageEncoding="UTF-8" %>
                                                    <!DOCTYPE html>
                                                    <html>

                                                    <head>
                                                        <meta http-equiv="Content-Type"
                                                            content="text/html; charset=UTF-8">
                                                        <title>Đặt phòng - Khách sạn</title>
                                                        <link
                                                            href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap"
                                                            rel="stylesheet">
                                                        <link rel="stylesheet"
                                                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                                                        <style>
                                                            :root {
                                                                --primary-color: #4361ee;
                                                                --secondary-color: #3f37c9;
                                                                --success-color: #2ecc71;
                                                                --danger-color: #f72585;
                                                                --warning-color: #f9a825;
                                                                --bg-color: #f8f9fa;
                                                                --text-color: #212529;
                                                            }

                                                            body {
                                                                font-family: 'Inter', sans-serif;
                                                                background-color: var(--bg-color);
                                                                color: var(--text-color);
                                                                margin: 0;
                                                                padding: 20px;
                                                            }

                                                            .container {
                                                                max-width: 1200px;
                                                                margin: 0 auto;
                                                                background: white;
                                                                padding: 30px;
                                                                border-radius: 12px;
                                                                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                                                            }

                                                            h2 {
                                                                color: var(--primary-color);
                                                                font-weight: 600;
                                                                margin-top: 0;
                                                                border-bottom: 2px solid #eee;
                                                                padding-bottom: 10px;
                                                            }

                                                            /* Toolbar */
                                                            .toolbar {
                                                                display: flex;
                                                                justify-content: space-between;
                                                                align-items: center;
                                                                margin-bottom: 25px;
                                                                gap: 20px;
                                                                flex-wrap: wrap;
                                                            }

                                                            .btn-back {
                                                                background-color: #6c757d;
                                                                color: white;
                                                                cursor: pointer;
                                                                border: none;
                                                                border-radius: 6px;
                                                                padding: 10px 20px;
                                                                font-weight: 600;
                                                                transition: all 0.3s ease;
                                                                text-decoration: none;
                                                                display: inline-flex;
                                                                align-items: center;
                                                                gap: 8px;
                                                                font-size: 14px;
                                                            }

                                                            .btn-back:hover {
                                                                background-color: #5a6268;
                                                            }

                                                            /* Alert Messages */
                                                            .alert {
                                                                padding: 14px 20px;
                                                                border-radius: 8px;
                                                                margin-bottom: 20px;
                                                                font-weight: 500;
                                                                display: flex;
                                                                align-items: center;
                                                                gap: 10px;
                                                            }

                                                            .alert-success {
                                                                background: #d4edda;
                                                                color: #155724;
                                                                border-left: 4px solid #28a745;
                                                            }

                                                            .alert-error {
                                                                background: #f8d7da;
                                                                color: #721c24;
                                                                border-left: 4px solid #dc3545;
                                                            }

                                                            /* Room Cards Grid */
                                                            .room-grid {
                                                                display: grid;
                                                                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                                                                gap: 20px;
                                                                margin-top: 10px;
                                                            }

                                                            .room-card {
                                                                background: white;
                                                                border-radius: 14px;
                                                                box-shadow: 0 3px 12px rgba(0, 0, 0, 0.08);
                                                                overflow: hidden;
                                                                transition: transform 0.3s ease, box-shadow 0.3s ease;
                                                                border: 1px solid #f0f0f0;
                                                                position: relative;
                                                            }

                                                            .room-card:hover {
                                                                transform: translateY(-4px);
                                                                box-shadow: 0 10px 25px rgba(67, 97, 238, 0.15);
                                                            }

                                                            .room-card-header {
                                                                background: linear-gradient(135deg, #2ecc71, #27ae60);
                                                                color: white;
                                                                padding: 18px 20px;
                                                                display: flex;
                                                                justify-content: space-between;
                                                                align-items: center;
                                                            }

                                                            .room-number {
                                                                font-size: 22px;
                                                                font-weight: 700;
                                                            }

                                                            .room-status {
                                                                background: rgba(255, 255, 255, 0.25);
                                                                padding: 4px 12px;
                                                                border-radius: 20px;
                                                                font-size: 12px;
                                                                font-weight: 600;
                                                            }

                                                            .room-card-body {
                                                                padding: 18px 20px;
                                                            }

                                                            .room-info {
                                                                display: flex;
                                                                align-items: center;
                                                                padding: 8px 0;
                                                                gap: 10px;
                                                                font-size: 14px;
                                                                color: #555;
                                                            }

                                                            .room-info i {
                                                                width: 20px;
                                                                text-align: center;
                                                                color: var(--primary-color);
                                                            }

                                                            .room-info .value {
                                                                font-weight: 600;
                                                                color: var(--text-color);
                                                            }

                                                            .room-price {
                                                                font-size: 18px;
                                                                font-weight: 700;
                                                                color: #f57c00;
                                                                margin-top: 5px;
                                                            }

                                                            .btn-book {
                                                                display: block;
                                                                width: 100%;
                                                                padding: 12px;
                                                                background: var(--primary-color);
                                                                color: white;
                                                                border: none;
                                                                border-radius: 0 0 14px 14px;
                                                                font-size: 15px;
                                                                font-weight: 600;
                                                                cursor: pointer;
                                                                transition: background 0.3s ease;
                                                                font-family: 'Inter', sans-serif;
                                                            }

                                                            .btn-book:hover {
                                                                background: var(--secondary-color);
                                                            }

                                                            /* Modal Đặt Phòng */
                                                            .modal {
                                                                display: none;
                                                                position: fixed;
                                                                z-index: 1000;
                                                                left: 0;
                                                                top: 0;
                                                                width: 100%;
                                                                height: 100%;
                                                                background-color: rgba(0, 0, 0, 0.5);
                                                                backdrop-filter: blur(4px);
                                                            }

                                                            .modal-content {
                                                                background-color: #fff;
                                                                margin: 4% auto;
                                                                padding: 30px;
                                                                border-radius: 16px;
                                                                width: 420px;
                                                                max-width: 90%;
                                                                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
                                                                position: relative;
                                                                animation: slideDown 0.3s ease;
                                                            }

                                                            @keyframes slideDown {
                                                                from {
                                                                    transform: translateY(-30px);
                                                                    opacity: 0;
                                                                }

                                                                to {
                                                                    transform: translateY(0);
                                                                    opacity: 1;
                                                                }
                                                            }

                                                            .modal-content h3 {
                                                                margin-top: 0;
                                                                color: var(--primary-color);
                                                                font-size: 20px;
                                                                display: flex;
                                                                align-items: center;
                                                                gap: 10px;
                                                            }

                                                            .close {
                                                                position: absolute;
                                                                right: 20px;
                                                                top: 15px;
                                                                font-size: 28px;
                                                                color: #aaa;
                                                                cursor: pointer;
                                                                transition: color 0.2s;
                                                            }

                                                            .close:hover {
                                                                color: #333;
                                                            }

                                                            .form-group {
                                                                margin-bottom: 18px;
                                                            }

                                                            .form-group label {
                                                                display: block;
                                                                margin-bottom: 6px;
                                                                font-weight: 600;
                                                                font-size: 13px;
                                                                color: #555;
                                                                text-transform: uppercase;
                                                                letter-spacing: 0.3px;
                                                            }

                                                            .form-group input,
                                                            .form-group select,
                                                            .form-group textarea {
                                                                width: 100%;
                                                                padding: 10px 12px;
                                                                border: 1px solid #ddd;
                                                                border-radius: 8px;
                                                                font-size: 14px;
                                                                font-family: 'Inter', sans-serif;
                                                                box-sizing: border-box;
                                                                transition: border-color 0.3s;
                                                            }

                                                            .form-group input:focus,
                                                            .form-group select:focus,
                                                            .form-group textarea:focus {
                                                                outline: none;
                                                                border-color: var(--primary-color);
                                                                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
                                                            }

                                                            .form-group textarea {
                                                                resize: vertical;
                                                                min-height: 60px;
                                                            }

                                                            .room-selected-info {
                                                                background: #f0f4ff;
                                                                padding: 12px 16px;
                                                                border-radius: 10px;
                                                                margin-bottom: 18px;
                                                                border-left: 4px solid var(--primary-color);
                                                            }

                                                            .room-selected-info span {
                                                                font-weight: 700;
                                                                color: var(--primary-color);
                                                            }

                                                            .btn-submit {
                                                                display: block;
                                                                width: 100%;
                                                                padding: 13px;
                                                                background: var(--success-color);
                                                                color: white;
                                                                border: none;
                                                                border-radius: 8px;
                                                                font-size: 16px;
                                                                font-weight: 700;
                                                                cursor: pointer;
                                                                transition: background 0.3s ease;
                                                                font-family: 'Inter', sans-serif;
                                                            }

                                                            .btn-submit:hover {
                                                                background: #27ae60;
                                                            }

                                                            /* Empty state */
                                                            .empty-state {
                                                                text-align: center;
                                                                padding: 60px 20px;
                                                                color: #999;
                                                            }

                                                            .empty-state i {
                                                                font-size: 60px;
                                                                color: #ddd;
                                                                margin-bottom: 15px;
                                                            }

                                                            .empty-state p {
                                                                font-size: 16px;
                                                            }

                                                            /* Summary */
                                                            .summary-text {
                                                                color: #888;
                                                                font-size: 14px;
                                                            }

                                                            .summary-text strong {
                                                                color: var(--success-color);
                                                            }
                                                        </style>
                                                    </head>

                                                    <body>
                                                        <div class="container">
                                                            <h2><i class="fa-solid fa-calendar-plus"></i> ĐẶT PHÒNG</h2>

                                                            <div class="toolbar">
                                                                <a href="main.jsp" class="btn-back">
                                                                    <i class="fa-solid fa-arrow-left"></i> Quay lại
                                                                    Dashboard
                                                                </a>
                                                            </div>

                                                            <% if (message !=null) { 
                                                                    boolean isSuccess = message.contains("thành công");
                                                                    String alertClass = isSuccess ? "alert-success" : "alert-error";
                                                                    String iconClass = isSuccess ? "fa-circle-check" : "fa-circle-exclamation";
                                                            %>
                                                                <div class="alert <%= alertClass %>">
                                                                    <i class="fa-solid <%= iconClass %>"></i>
                                                                    <%= message %>
                                                                </div>
                                                                <% } %>

                                                                    <% if (phongTrongList.isEmpty()) { %>
                                                                        <div class="empty-state">
                                                                            <i class="fa-solid fa-bed"></i>
                                                                            <p>Hiện tại không có phòng trống nào.</p>
                                                                        </div>
                                                                        <% } else { %>
                                                                            <div class="room-grid">
                                                                                <% for (RoomDTO p : phongTrongList) { %>
                                                                                    <div class="room-card">
                                                                                        <div class="room-card-header">
                                                                                            <span class="room-number">
                                                                                                <i
                                                                                                    class="fa-solid fa-door-open"></i>
                                                                                                Phòng <%= p.getSophong()
                                                                                                    %>
                                                                                            </span>
                                                                                        </div>
                                                                                        <div class="room-card-body">
                                                                                            <div class="room-info">
                                                                                                <i
                                                                                                    class="fa-solid fa-tag"></i>
                                                                                                <span>Loại phòng:</span>
                                                                                                <span class="value">
                                                                                                    <%= p.getTenloaiphong()
                                                                                                        %>
                                                                                                </span>
                                                                                            </div>
                                                                                            <div class="room-info">
                                                                                                <i
                                                                                                    class="fa-solid fa-users"></i>
                                                                                                <span>Sức chứa:</span>
                                                                                                <span class="value">
                                                                                                    <%= p.getSonguoitoida()
                                                                                                        %> người
                                                                                                </span>
                                                                                            </div>
                                                                                            <div class="room-info">
                                                                                                <i
                                                                                                    class="fa-solid fa-money-bill-wave"></i>
                                                                                                <span>Giá/đêm:</span>
                                                                                            </div>
                                                                                            <div class="room-price">
                                                                                                <%= nf.format(p.getGia())
                                                                                                    %> VNĐ
                                                                                            </div>
                                                                                        </div>
                                                                                        <button class="btn-book"
                                                                                            onclick="openBookingModal(<%= p.getMaphong() %>, <%= p.getSophong() %>, '<%= p.getTenloaiphong() %>', '<%= nf.format(p.getGia()) %>')">
                                                                                            <i
                                                                                                class="fa-solid fa-calendar-check"></i>
                                                                                            Đặt phòng này
                                                                                        </button>
                                                                                    </div>
                                                                                    <% } %>
                                                                            </div>
                                                                            <% } %>
                                                        </div>

                                                        <!-- Modal Đặt Phòng -->
                                                        <div id="bookingModal" class="modal">
                                                            <div class="modal-content">
                                                                <span class="close"
                                                                    onclick="closeModal()">&times;</span>
                                                                <h3><i class="fa-solid fa-calendar-plus"></i> Xác nhận
                                                                    đặt phòng</h3>

                                                                <div class="room-selected-info">
                                                                    Phòng: <span id="modalSoPhong"></span> &mdash;
                                                                    Loại: <span id="modalLoaiPhong"></span> &mdash;
                                                                    Giá: <span id="modalGia"></span> VNĐ/đêm
                                                                </div>

                                                                <form action="BookingServlet" method="POST">
                                                                    <input type="hidden" name="action" value="book">
                                                                    <input type="hidden" id="modalMaPhong"
                                                                        name="maPhong">

                                                                    <div class="form-group">
                                                                        <label>Khách hàng</label>
                                                                        <select name="maKH" required>
                                                                            <option value="">-- Chọn khách hàng --
                                                                            </option>
                                                                            <% for (CustomerDTO c : customerList) { %>
                                                                                <option value="<%= c.getMakh() %>">
                                                                                    <%= c.getHoten() %> - CCCD: <%=
                                                                                            c.getCccd() %>
                                                                                </option>
                                                                                <% } %>
                                                                        </select>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label>Ngày nhận phòng</label>
                                                                        <input type="date" name="ngayNhan" required>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label>Ngày trả phòng</label>
                                                                        <input type="date" name="ngayTra" required>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label>Ghi chú</label>
                                                                        <textarea name="ghiChu"
                                                                            placeholder="Ghi chú thêm (không bắt buộc)..."></textarea>
                                                                    </div>

                                                                    <button type="submit" class="btn-submit">
                                                                        <i class="fa-solid fa-check"></i> Xác nhận đặt
                                                                        phòng
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>

                                                        <script>
                                                            function openBookingModal(maPhong, soPhong, loaiPhong, gia) {
                                                                document.getElementById('bookingModal').style.display = 'block';
                                                                document.getElementById('modalMaPhong').value = maPhong;
                                                                document.getElementById('modalSoPhong').textContent = soPhong;
                                                                document.getElementById('modalLoaiPhong').textContent = loaiPhong;
                                                                document.getElementById('modalGia').textContent = gia;

                                                                // Set ngày nhận mặc định là ngày mai
                                                                var tomorrow = new Date();
                                                                tomorrow.setDate(tomorrow.getDate() + 1);
                                                                var tomorrowStr = tomorrow.toISOString().split('T')[0];
                                                                document.querySelector('input[name="ngayNhan"]').min = tomorrowStr;
                                                                document.querySelector('input[name="ngayNhan"]').value = tomorrowStr;

                                                                // Set ngày trả mặc định là 2 ngày sau
                                                                var dayAfter = new Date();
                                                                dayAfter.setDate(dayAfter.getDate() + 2);
                                                                var dayAfterStr = dayAfter.toISOString().split('T')[0];
                                                                document.querySelector('input[name="ngayTra"]').min = dayAfterStr;
                                                                document.querySelector('input[name="ngayTra"]').value = dayAfterStr;
                                                            }

                                                            function closeModal() {
                                                                document.getElementById('bookingModal').style.display = 'none';
                                                            }

                                                            // Đóng modal khi click ra ngoài
                                                            window.onclick = function (event) {
                                                                var modal = document.getElementById('bookingModal');
                                                                if (event.target === modal) closeModal();
                                                            }

                                                            // Auto cập nhật min ngày trả khi đổi ngày nhận
                                                            document.querySelector('input[name="ngayNhan"]').addEventListener('change', function () {
                                                                var ngayNhan = new Date(this.value);
                                                                ngayNhan.setDate(ngayNhan.getDate() + 1);
                                                                var minTra = ngayNhan.toISOString().split('T')[0];
                                                                var inputTra = document.querySelector('input[name="ngayTra"]');
                                                                inputTra.min = minTra;
                                                                if (inputTra.value < minTra) {
                                                                    inputTra.value = minTra;
                                                                }
                                                            });
                                                        </script>
                                                    </body>

                                                    </html>