<%@page import="com.mycompany.laptrinhweb.model.dto.RevenueTopDetailDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    RevenueTopDetailDTO detail = (RevenueTopDetailDTO) request.getAttribute("detail");
    String type = request.getAttribute("type") != null ? request.getAttribute("type").toString() : "";
    String thang = request.getAttribute("thang") != null ? request.getAttribute("thang").toString() : "";
    String nam = request.getAttribute("nam") != null ? request.getAttribute("nam").toString() : "";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết doanh thu</title>

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f7fa;
                margin: 0;
                padding: 30px;
                color: #333;
            }

            .container {
                max-width: 800px;
                margin: 0 auto;
                background: #ffffff;
                border: 1px solid #dbe3ec;
                border-radius: 12px;
                padding: 24px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            }

            h2 {
                margin-top: 0;
                margin-bottom: 20px;
                color: #1f3b5b;
                border-bottom: 2px solid #e6eef7;
                padding-bottom: 10px;
            }

            .detail-table {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
                margin-bottom: 20px;
            }

            .detail-table td {
                border: 1px solid #d6e0ea;
                padding: 12px;
            }

            .detail-table tr:nth-child(odd) td {
                background: #f8fbff;
            }

            .label-cell {
                width: 30%;
                font-weight: bold;
                color: #1f3b5b;
                background: #eef5fc;
            }

            .value-cell {
                color: #333;
            }

            .empty-box {
                border: 1px solid #d6e0ea;
                background: #fff8f8;
                color: #a33;
                padding: 14px;
                border-radius: 8px;
                margin-bottom: 20px;
            }

            .back-link {
                display: inline-block;
                padding: 10px 16px;
                border: 1px solid #b9c7d6;
                border-radius: 8px;
                background: #eaf2fb;
                color: #0b57d0;
                text-decoration: none;
                font-weight: bold;
            }

            .back-link:hover {
                background: #dcecff;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2><%= "room".equals(type) ? "Chi tiết phòng" : "Chi tiết dịch vụ" %></h2>

            <%
                if (detail != null) {
            %>
            <table class="detail-table">
                <tr>
                    <td class="label-cell">Tên</td>
                    <td class="value-cell"><%= detail.getTen() %></td>
                </tr>
                <tr>
                    <td class="label-cell">Doanh thu</td>
                    <td class="value-cell"><%= detail.getDoanhThu() %></td>
                </tr>
                <tr>
                    <td class="label-cell">Số lượng / số lượt</td>
                    <td class="value-cell"><%= detail.getSoLuong() %></td>
                </tr>
                <tr>
                    <td class="label-cell">Ghi chú</td>
                    <td class="value-cell"><%= detail.getGhiChu() %></td>
                </tr>
            </table>
            <%
                } else {
            %>
            <div class="empty-box">Không có dữ liệu chi tiết</div>
            <%
                }
            %>

            <a class="back-link" href="RevenueDetailServlet?thang=<%= thang %>&nam=<%= nam %>">
                Quay lại trang doanh thu
            </a>
        </div>
    </body>
</html>