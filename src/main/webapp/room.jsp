<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.RoomTypeDTO"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%
    List<RoomTypeDTO> loaiPhongList = (List<RoomTypeDTO>) request.getAttribute("loaiPhongList");
    if (loaiPhongList == null)
        loaiPhongList = new ArrayList<>();
    
    // Format tiền VNĐ
    NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Phòng & Loại phòng - Khách sạn</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            :root {
                --primary-color: #4361ee;
                --secondary-color: #3f37c9;
                --success-color: #4cc9f0;
                --danger-color: #f72585;
                --warning-color: #f9a825;
                --bg-color: #f8f9fa;
                --text-color: #212529;
                --card-shadow: 0 4px 15px rgba(0,0,0,0.08);
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
                box-shadow: 0 4px 6px rgba(0,0,0,0.05);
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

            /* Cards Grid */
            .room-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
                gap: 25px;
                margin-top: 10px;
            }

            .room-card {
                background: white;
                border-radius: 16px;
                box-shadow: var(--card-shadow);
                overflow: hidden;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                border: 1px solid #f0f0f0;
            }

            .room-card:hover {
                transform: translateY(-6px);
                box-shadow: 0 12px 30px rgba(67, 97, 238, 0.15);
            }

            .card-header {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                padding: 20px 25px;
                position: relative;
                overflow: hidden;
            }

            .card-header::after {
                content: '';
                position: absolute;
                top: -50%;
                right: -30px;
                width: 120px;
                height: 120px;
                background: rgba(255,255,255,0.08);
                border-radius: 50%;
            }

            .card-header h3 {
                margin: 0;
                font-size: 20px;
                font-weight: 700;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .card-header .room-id {
                font-size: 12px;
                opacity: 0.75;
                margin-top: 5px;
            }

            .card-body {
                padding: 22px 25px;
            }

            .info-row {
                display: flex;
                align-items: center;
                padding: 10px 0;
                border-bottom: 1px solid #f5f5f5;
                gap: 12px;
            }

            .info-row:last-child {
                border-bottom: none;
            }

            .info-row i {
                width: 36px;
                height: 36px;
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 15px;
                flex-shrink: 0;
            }

            .info-row .icon-people {
                background: #e7f5ff;
                color: #228be6;
            }

            .info-row .icon-price {
                background: #fff3e0;
                color: #f57c00;
            }

            .info-row .icon-desc {
                background: #f3e5f5;
                color: #8e24aa;
            }

            .info-row .icon-count {
                background: #e8f5e9;
                color: #2e7d32;
            }

            .info-label {
                font-size: 12px;
                color: #999;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .info-value {
                font-size: 15px;
                font-weight: 600;
                color: var(--text-color);
            }

            .price-value {
                color: #f57c00;
                font-size: 18px;
                font-weight: 700;
            }

            .info-text {
                display: flex;
                flex-direction: column;
            }

            /* Badge */
            .badge-rooms {
                background: #e8f5e9;
                color: #2e7d32;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 600;
            }

            /* Empty State */
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

            /* Summary bar */
            .summary-bar {
                display: flex;
                gap: 20px;
                margin-bottom: 25px;
                flex-wrap: wrap;
            }

            .summary-item {
                background: white;
                padding: 15px 25px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.06);
                display: flex;
                align-items: center;
                gap: 12px;
                border-left: 4px solid var(--primary-color);
            }

            .summary-item .number {
                font-size: 26px;
                font-weight: 700;
                color: var(--primary-color);
            }

            .summary-item .label {
                font-size: 13px;
                color: #888;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2><i class="fa-solid fa-bed"></i> PHÒNG & LOẠI PHÒNG</h2>

            <div class="toolbar">
                <a href="LoginServlet" class="btn-back">
                    <i class="fa-solid fa-arrow-left"></i> Quay lại Dashboard
                </a>
                <div>
                    <span style="color:#888; font-size: 14px;">
                        Tổng cộng <strong style="color: var(--primary-color);"><%= loaiPhongList.size() %></strong> loại phòng
                    </span>
                </div>
            </div>

            <% if (loaiPhongList.isEmpty()) { %>
                <div class="empty-state">
                    <i class="fa-solid fa-door-open"></i>
                    <p>Chưa có loại phòng nào trong hệ thống.</p>
                </div>
            <% } else { %>
                <div class="room-grid">
                    <% for (RoomTypeDTO lp : loaiPhongList) { %>
                    <div class="room-card">
                        <div class="card-header">
                            <h3>
                                <i class="fa-solid fa-door-open"></i>
                                <%= lp.getTenLoaiPhong() %>
                            </h3>
                            <div class="room-id">Mã loại: #<%= lp.getMaLoaiPhong() %></div>
                        </div>
                        <div class="card-body">
                            <div class="info-row">
                                <i class="fa-solid fa-users icon-people"></i>
                                <div class="info-text">
                                    <span class="info-label">Số người tối đa</span>
                                    <span class="info-value"><%= lp.getSoNguoiToiDa() %> người</span>
                                </div>
                            </div>
                            <div class="info-row">
                                <i class="fa-solid fa-money-bill-wave icon-price"></i>
                                <div class="info-text">
                                    <span class="info-label">Giá cơ bản / đêm</span>
                                    <span class="price-value"><%= nf.format(lp.getGiaCoBan()) %> VNĐ</span>
                                </div>
                            </div>
                            <div class="info-row">
                                <i class="fa-solid fa-align-left icon-desc"></i>
                                <div class="info-text">
                                    <span class="info-label">Mô tả</span>
                                    <span class="info-value"><%= lp.getMoTa() != null ? lp.getMoTa() : "Chưa có mô tả" %></span>
                                </div>
                            </div>
                            <div class="info-row">
                                <i class="fa-solid fa-building icon-count"></i>
                                <div class="info-text">
                                    <span class="info-label">Số phòng hiện có</span>
                                    <span class="badge-rooms"><%= lp.getSoPhongHienCo() %> phòng</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            <% } %>
        </div>
    </body>
</html>
