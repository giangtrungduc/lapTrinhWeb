package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.BookingDAO;
import com.mycompany.laptrinhweb.model.dao.CustomerDAO;
import com.mycompany.laptrinhweb.model.dao.RoomDAO;
import com.mycompany.laptrinhweb.model.dto.CustomerDTO;
import com.mycompany.laptrinhweb.model.dto.RoomDTO;
import com.mycompany.laptrinhweb.model.dto.RoomStatus;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class BookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String msg = request.getParameter("msg");
        if(msg != null) {
            request.setAttribute("message", msg);
        }
    
        try {
            RoomDAO roomDAO = new RoomDAO();
            List<RoomDTO> allRooms = roomDAO.listRoom();
            
            CustomerDAO customerDAO = new CustomerDAO();
            List<CustomerDTO> customerList = customerDAO.listCustomer();

            request.setAttribute("phongTrongList", allRooms);
            request.setAttribute("customerList", customerList);
            
            request.getRequestDispatcher("booking.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("main.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        if ("book".equals(action)) {
            try {
                int maPhong = Integer.parseInt(request.getParameter("maPhong"));
                int maKH = Integer.parseInt(request.getParameter("maKH"));
                
                String ngayNhan = request.getParameter("ngayNhan"); 
                String ngayTra = request.getParameter("ngayTra");
                String ghiChu = request.getParameter("ghiChu");

                BookingDAO bookingDAO = new BookingDAO();
                boolean success = bookingDAO.bookRoom(maKH, maPhong, ngayNhan, ngayTra, ghiChu);
                
                if (success) {
                    response.sendRedirect("BookingServlet?msg=" + java.net.URLEncoder.encode("Đặt phòng thành công!", "UTF-8"));
                } else {
                    response.sendRedirect("BookingServlet?msg=" + java.net.URLEncoder.encode("Phòng đang bảo trì hoặc trùng lịch, vui lòng chọn ngày/phòng khác!", "UTF-8"));
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("BookingServlet?msg=" + java.net.URLEncoder.encode("Đã xảy ra lỗi hệ thống.", "UTF-8"));
            }
        } else {
            response.sendRedirect("BookingServlet");
        }
    }
}
