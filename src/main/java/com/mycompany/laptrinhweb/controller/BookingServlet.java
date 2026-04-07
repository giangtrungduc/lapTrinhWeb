package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.RoomDAO;
import com.mycompany.laptrinhweb.model.dao.CustomerDAO;
import com.mycompany.laptrinhweb.model.dto.RoomDTO;
import com.mycompany.laptrinhweb.model.dto.CustomerDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

public class BookingServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        RoomDAO roomDAO = new RoomDAO();
        CustomerDAO customerDAO = new CustomerDAO();
        String action = request.getParameter("action");
        String message = null;

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "book": {
                    int maKH = Integer.parseInt(request.getParameter("maKH"));
                    int maPhong = Integer.parseInt(request.getParameter("maPhong"));
                    String ngayNhan = request.getParameter("ngayNhan");
                    String ngayTra = request.getParameter("ngayTra");
                    String ghiChu = request.getParameter("ghiChu");

                    // Lấy MaNV từ session (đã lưu khi login)
                    Integer maNVObj = (Integer) request.getSession().getAttribute("maNV");
                    int maNV = (maNVObj != null) ? maNVObj : 1; // mặc định NV 1 nếu chưa có

                    if (ngayNhan == null || ngayNhan.isEmpty() || ngayTra == null || ngayTra.isEmpty()) {
                        message = "Vui lòng nhập đầy đủ ngày nhận và ngày trả phòng.";
                    } else if (ngayNhan.compareTo(ngayTra) >= 0) {
                        message = "Ngày trả phòng phải sau ngày nhận phòng.";
                    } else {
                        // Thêm giờ mặc định: check-in 14:00, check-out 12:00
                        String ngayNhanFull = ngayNhan + " 14:00:00";
                        String ngayTraFull = ngayTra + " 12:00:00";

                        if (roomDAO.datPhong(maKH, maPhong, maNV, ngayNhanFull, ngayTraFull, ghiChu)) {
                            message = "Đặt phòng thành công! Phòng đã chuyển sang trạng thái 'Đã đặt'.";
                        } else {
                            message = "Đặt phòng thất bại. Vui lòng thử lại.";
                        }
                    }
                    break;
                }
                default:
                    break;
            }
        } catch (NumberFormatException e) {
            message = "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.";
        } catch (Exception e) {
            e.printStackTrace();
            message = "Có lỗi xảy ra: " + e.getMessage();
        }

        // Luôn load lại danh sách phòng trống và khách hàng cho form
        List<RoomDTO> phongTrongList = roomDAO.listPhongTrong();
        List<CustomerDTO> customerList = customerDAO.listCustomer();
        request.setAttribute("phongTrongList", phongTrongList);
        request.setAttribute("customerList", customerList);
        request.setAttribute("message", message);
        request.getRequestDispatcher("booking.jsp").forward(request, response);
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

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đặt phòng";
    }
}
