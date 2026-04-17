/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.BookingDAO;
import com.mycompany.laptrinhweb.model.dao.CustomerDAO;
import com.mycompany.laptrinhweb.model.dao.RoomDAO;
import com.mycompany.laptrinhweb.model.dto.CustomerDTO;
import com.mycompany.laptrinhweb.model.dto.RoomBookingStatusDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


public class BookingFormCustomerServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. Nhận tham số từ form
        String hoTen = request.getParameter("hoTen");
        String cccd = request.getParameter("cccd");
        String sdt = request.getParameter("sdt");
        String email = request.getParameter("email");
        String diaChi = request.getParameter("diaChi");

        int maPhong = Integer.parseInt(request.getParameter("maPhong"));

        // Ngày giờ nhận/trả phòng
        String ngayNhanStr = request.getParameter("ngayNhan");
        String ngayTraStr = request.getParameter("ngayTra");
        LocalDateTime ngayNhan = LocalDateTime.parse(ngayNhanStr);
        LocalDateTime ngayTra = LocalDateTime.parse(ngayTraStr);

        // 2. Kiểm tra xung đột thời gian với các đơn đặt phòng khác
        
        RoomDAO roomDAO = new RoomDAO();
        List<RoomBookingStatusDTO> existingBookings = roomDAO.getRoomBookingStatusByRoomId(maPhong);
        
        boolean conflict = false;
        for (RoomBookingStatusDTO booking : existingBookings) {
            LocalDateTime existingStart = booking.getNgayNhanDuKien();
            LocalDateTime existingEnd = booking.getNgayTraDuKien();
            if (!(ngayTra.isBefore(existingStart) || ngayNhan.isAfter(existingEnd))) {
                conflict = true;
                break;
            }
        }

        if (conflict) {
            // Nếu xung đột thì báo lỗi
            request.setAttribute("message", "Thời gian đặt phòng bị trùng với đơn khác!");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // 3. Kiểm tra khách hàng đã tồn tại chưa (theo CCCD)
        
        CustomerDAO customerDAO = new CustomerDAO();
        List<CustomerDTO> existingCustomers = customerDAO.listCustomer();
        
        CustomerDTO khachHang = null;
        for (CustomerDTO kh : existingCustomers) {
            if (kh.getCccd().equals(cccd)) {
                khachHang = kh;
                break;
            }
        }

        if (khachHang == null) {
            
            khachHang = new CustomerDTO();
            khachHang.setHoten(hoTen);
            khachHang.setCccd(cccd);
            khachHang.setSdt(sdt);
            khachHang.setEmail(email);
            khachHang.setDiachi(diaChi);
            
            existingCustomers.add(khachHang); // ---------------- ĐÂY VIẾT SQL THÊM KHÁCH HÀNG MỚI 
            try{
                customerDAO.addCustomer(khachHang);
            }
            catch(Exception e){
                e.printStackTrace();
            }
        }
        int makhachhang = customerDAO.findCustomerIdByCCCD(cccd);
        // 4. Tạo đơn đặt phòng mới cho khách hàng này
        RoomBookingStatusDTO newBooking = new RoomBookingStatusDTO();
        newBooking.setMaPhong(maPhong);
        newBooking.setNgayNhanDuKien(ngayNhan);
        newBooking.setNgayTraDuKien(ngayTra);
        newBooking.setTrangThai("DaDat");
        newBooking.setMaKhachHang(makhachhang); // giả định có getter

        // thêm vào danh sách đặt phòng giả định
        existingBookings.add(newBooking);
        BookingDAO bookingDAO = new BookingDAO();
        bookingDAO.addNewBooking(newBooking);

        // 5. Thông báo thành công
        request.setAttribute("message", "Đặt phòng thành công!");
        request.getRequestDispatcher("find-room-customer.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
