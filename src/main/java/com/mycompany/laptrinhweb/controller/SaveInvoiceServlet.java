package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.BookingDAO;
import com.mycompany.laptrinhweb.model.dao.InvoiceDAO;
import com.mycompany.laptrinhweb.model.dao.RoomDAO;
import java.io.IOException;
import java.math.BigDecimal;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SaveInvoiceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Nhận giá trị từ các thẻ <input> của form
            String maDatPhongStr = request.getParameter("madp");
            String tienPhongStr = request.getParameter("tienphong");
            String tienDVStr = request.getParameter("tiendv");
            String maPhongStr = request.getParameter("map");
            System.out.println(maDatPhongStr + " " + tienPhongStr + " " + tienDVStr + " " + maPhongStr);

            // 2. Chuyển đổi kiểu dữ liệu (với tiền tệ nên dùng BigDecimal)
            int maDatPhong = Integer.parseInt(maDatPhongStr);
            int maPhong = Integer.parseInt(maPhongStr);
            BigDecimal tongTienPhong,tongTienDV;
            if (tienPhongStr==null){
                tongTienPhong = BigDecimal.ZERO;
            }
            else tongTienPhong = new BigDecimal(tienPhongStr);
            if (tienDVStr==null){
                tongTienDV=BigDecimal.ZERO;
            }
            else tongTienDV = new BigDecimal(tienDVStr);

            // 3. Gọi DAO để ghi vào Database
            InvoiceDAO dao = new InvoiceDAO();
            dao.saveInvoice(maDatPhong, tongTienPhong, tongTienDV);
            // chuyển datphong về trạng thái hoàn thành
            BookingDAO bookingDAO = new BookingDAO();
            bookingDAO.completeBooking(maDatPhong);
            // chuyen phong ve trang thai trong
            RoomDAO roomDAO = new RoomDAO();
            roomDAO.setRoomAvailable(maPhong);

            // 4. Sau khi lưu xong, chuyển hướng về trang danh sách hoặc thông báo thành công
            // Ở đây mình ví dụ chuyển về trang main
            response.sendRedirect("main.jsp?status=success");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("main.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}