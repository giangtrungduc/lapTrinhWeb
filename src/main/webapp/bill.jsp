<%-- 
    Document   : bill
    Created on : Apr 7, 2026, 9:29:27 AM
    Author     : DELL
--%>

<%@page import="com.mycompany.laptrinhweb.model.dto.ServiceDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.BillDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bill Page</title>
        <style>
            /* Tổng thể trang */
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                line-height: 1.6;
                color: #333;
                max-width: 900px;
                margin: 0 auto;
                padding: 20px;
                background-color: #f4f7f6;
            }

            h1, h2, h3 {
                color: #2c3e50;
                border-bottom: 2px solid #3498db;
                padding-bottom: 10px;
            }

            /* Link quay về */
            a {
                text-decoration: none;
                color: #3498db;
                font-weight: bold;
            }

            /* Form tìm kiếm */
            form[action="FindBookingServlet"] {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            input[name="madp"], input[type="datetime-local"] {
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                width: 200px;
            }

            button {
                cursor: pointer;
                transition: 0.3s;
                border: none;
                border-radius: 4px;
                padding: 10px 20px;
            }

            button:hover {
                opacity: 0.8;
            }

            /* Các bảng dữ liệu */
            table {
                width: 100%;
                background: #fff;
                border-collapse: collapse;
                margin-bottom: 20px;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
                border: none !important; /* Ghi đè border="1" */
            }

            th, td {
                padding: 12px 15px;
                border-bottom: 1px solid #eee;
            }

            th {
                background-color: #3498db;
                color: white;
                text-transform: uppercase;
                font-size: 14px;
            }

            tr:last-child td {
                border-bottom: none;
            }

            /* Thông báo lỗi */
            .error-msg {
                background-color: #fdeaea;
                color: #e74c3c;
                padding: 15px;
                border-left: 5px solid #e74c3c;
                border-radius: 4px;
                margin: 20px 0;
            }

            /* Tổng thanh toán */
            h2[align="right"] {
                background: #2c3e50;
                color: #fff;
                display: inline-block;
                float: right;
                padding: 10px 20px;
                border-radius: 4px;
                border-bottom: none;
            }

            /* Nút hành động */
            .btn-cancel {
                display: inline-block;
                padding: 10px 20px;
                background: #95a5a6;
                color: white !important;
                border-radius: 4px;
                margin-top: 20px;
            }

            .btn-save {
                background-color: #27ae60;
                color: white;
                font-weight: bold;
                font-size: 16px;
                margin-left: 10px;
            }
        </style>
    </head>
    <body>
        <h1>Lập hoá đơn</h1>
        <a href="main.jsp"> Quay về trang chủ </a>
        <h2>Thông tin đặt phòng</h2>
        <form action="FindBookingServlet" method="post">
            <label>Nhập mã đặt phòng</label>
            <input name="madp"> 
            <button>Tìm</button>
        </form>
        <%
            String msgf = (String) request.getAttribute("msgf");
            if (msgf != null) {

        %>
        <h3 style="color:red;"><%=msgf%></h3>
        <%
        } else {

        %>
        <%            BillDTO bill = (BillDTO) request.getAttribute("bill");
            if (bill != null) {
        %>
        <table width="100%">
            <tr>
                <td width="30%"><b>Khách hàng:</b></td>
                <td><%= bill.getHoTen()%></td>
            </tr>
            <tr>
                <td><b>SĐT:</b></td>
                <td><%= bill.getSdt()%></td>
            </tr>
            <tr>
                <td><b>CCCD:</b></td>
                <td><%= bill.getCccd()%></td>
            </tr>
            <tr>
                <td><b>Email:</b></td>
                <td><%= bill.getEmail()%></td>
            </tr>

            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>

            <tr>
                <td><b>Phòng:</b></td>
                <td><%= bill.getSoPhong()%> - Phòng Deluxe</td>
            </tr>
            <tr>
                <td><b>Ngày nhận (dự kiến):</b></td>
                <td><%= bill.getNgayNhanDuKien()%></td>
            </tr>
            <tr>
                <td><b>Ngày trả (dự kiến):</b></td>
                <td><%= bill.getNgayTraDuKien()%></td>
            </tr>

        </table>
        <form action="InvoiceServlet" method="post">
            <input name="madp" type="hidden" value="<%=bill.getMaDatPhong()%>">
            <input name="ngaytra" type="datetime-local">
            <button>Xuat hoa don</button>
        </form>
        <%
            }
        %>


        <%-- Bảng tính tiền phòng (Chỉ hiện sau khi đã tính toán xong ở Servlet) --%>
        <%
            BillDTO bill1 = (BillDTO) request.getAttribute("bill");
            // Kiểm tra bill không null và đã được tính tiền phòng (để phân biệt với bảng tìm kiếm ban đầu)
            if (bill1 != null && bill1.getTongTienPhong() != null) {
        %>
        <h2>TÍNH TIỀN PHÒNG</h2>
        <table width="100%">
            <tr>
                <td width="30%"><b>Giá phòng/đêm:</b></td>
                <td><%= bill1.getGiaPhong()%> đ</td>
            </tr>
            <tr>
                <td><b>Số đêm:</b></td>
                <td><%= bill1.getSoDem()%></td>
            </tr>
            <tr>
                <td><b>Thành tiền phòng:</b></td>
                <td><%= bill1.getTongTienPhong()%> đ</td>
            </tr>

            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>

            <tr style="background-color: #eee;">
                <td><b>Tổng tiền phòng:</b></td>
                <td>
                    <b>
                        <%
                            BigDecimal tongCuoi = bill1.getTongTienPhong();
                            out.print(tongCuoi + " đ");
                        %>
                    </b>
                </td>
            </tr>
        </table>


        <%
            List<ServiceDTO> services = bill1.getServices();
            BigDecimal tongTienDV = BigDecimal.ZERO;
        %>

        <h3>DỊCH VỤ SỬ DỤNG</h3>


        <table width="100%">
            <tr>
                <th align="left">Dịch vụ</th>
                <th align="left">Đơn giá</th>
                <th align="center">Số lượng</th>
                <th align="left">Thành tiền</th>

            </tr>

            <%
                if (services != null && !services.isEmpty()) {
                    for (ServiceDTO svc : services) {
                        // Tính toán thành tiền từng dòng
                        BigDecimal thanhTienRow = svc.getDonGia().multiply(new BigDecimal(svc.getSoLuong()));
                        tongTienDV = tongTienDV.add(thanhTienRow);
            %>
            <tr>
                <td><%= svc.getTenDV()%></td>
                <td><%= svc.getDonGia()%></td>
                <td align="center"><%= svc.getSoLuong()%></td>
                <td><%= thanhTienRow%></td>

            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5" align="center">Chưa có dịch vụ nào.</td>
            </tr>
            <%
                }
            %>
        </table>

        <table>
            <tr>
                <td align="left"><b>Tổng tiền dịch vụ:</b></td>
                <td align="right"><b><%= tongTienDV%> đ</b></td>
            </tr>
        </table>

        <hr>

        <%-- Tính tổng cộng cuối cùng --%>
        <%
            BigDecimal tongCuoiCung = bill1.getTongTienPhong().add(tongTienDV);
        %>
        <h2 align="right">TỔNG THANH TOÁN: <%= tongCuoiCung%> đ</h2>


        <a href="bill.jsp" class="btn-cancel">Hủy</a>
        <form action="SaveInvoiceServlet" method="POST" style="display: inline-block;"> 
            <input name="madp" type="hidden" value="<%= bill1.getMaDatPhong()%>">
            <input name="map" type="hidden" value="<%= bill1.getMaPhong()%>">

            <%-- Gửi tiền phòng --%>
            <input name="tienphong" type="hidden" value="<%= bill1.getTongTienPhong() != null ? bill1.getTongTienPhong() : "0"%>">

            <%-- Gửi tiền dịch vụ (Dùng biến tongTienDV vừa tính ở trên) --%>
            <input name="tiendv" type="hidden" value="<%= tongTienDV != null ? tongTienDV : "0"%>">

            <button type="submit" class="btn-save">
                Lưu hoá đơn & Thanh toán
            </button>
        </form>
        <%            }
            }
        %>

    </body>
</html>
