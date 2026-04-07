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
            BillDTO bill = (BillDTO) request.getAttribute("bill");
            if (bill != null) {
        %>
        <table border="1" cellpadding="10" cellspacing="0" width="100%">
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
        <table border="1" cellpadding="10" cellspacing="0" width="100%">
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
        

        <table border="1" cellpadding="10" cellspacing="0" width="100%">
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

        <table width="100%" border="0" cellpadding="10">
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
        <%            }
        %>

    </body>
</html>
