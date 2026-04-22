package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.BookingDAO;
import com.mycompany.laptrinhweb.model.dao.CustomerDAO;
import com.mycompany.laptrinhweb.model.dao.RoomDAO;
import com.mycompany.laptrinhweb.model.dto.CustomerDTO;
import com.mycompany.laptrinhweb.model.dto.RoomBookingStatusDTO;
import com.mycompany.laptrinhweb.model.dto.RoomDTO;
import com.mycompany.laptrinhweb.model.dto.RoomStatus;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class BookingByStaff extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Integer maNV = (Integer) session.getAttribute("MaNV");
        if (maNV == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String action = request.getParameter("action");
        if (action == null) action = "list";

        RoomDAO roomDAO = new RoomDAO();

        switch (action) {

            // Hiển thị danh sách phòng
            case "list": {
                List<RoomDTO> roomList = roomDAO.listRoom();
                request.setAttribute("roomList", roomList);
                request.setAttribute("message", request.getParameter("message"));
                request.getRequestDispatcher("find-room-staff.jsp").forward(request, response);
                break;
            }

            // Hiển thị form đặt phòng cho một phòng cụ thể
            case "showBookingForm": {
                int maPhong = Integer.parseInt(request.getParameter("maPhong"));
                RoomDTO room = roomDAO.getRoomById(maPhong);

                // Không cho đặt phòng bảo trì
                if (room == null || room.getTrangthai() == RoomStatus.BaoTri) {
                    response.sendRedirect("BookingByStaff?action=list");
                    return;
                }

                // Lấy các phiếu đặt hiện có để hiện thị ngày đã bận
                List<RoomBookingStatusDTO> existingBookings = roomDAO.getRoomBookingStatusByRoomId(maPhong);
                request.setAttribute("room", room);
                request.setAttribute("existingBookings", existingBookings);
                request.getRequestDispatcher("book-room-staff.jsp").forward(request, response);
                break;
            }

            // Xử lý submit form đặt phòng
            case "submitBooking": {
                String hoTen  = request.getParameter("hoTen");
                String cccd   = request.getParameter("cccd");
                String sdt    = request.getParameter("sdt");
                String email  = request.getParameter("email");
                String diaChi = request.getParameter("diaChi");
                int maPhong   = Integer.parseInt(request.getParameter("maPhong"));

                DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
                LocalDateTime ngayNhan, ngayTra;
                try {
                    ngayNhan = LocalDateTime.parse(request.getParameter("ngayNhan"), fmt);
                    ngayTra  = LocalDateTime.parse(request.getParameter("ngayTra"),  fmt);
                } catch (DateTimeParseException e) {
                    request.setAttribute("error", "Định dạng ngày không hợp lệ. Vui lòng chọn lại.");
                    prepareFormAgain(request, roomDAO, maPhong);
                    request.getRequestDispatcher("book-room-staff.jsp").forward(request, response);
                    return;
                }

                // Validate ngày
                if (!ngayTra.isAfter(ngayNhan)) {
                    request.setAttribute("error", "Ngày trả phải sau ngày nhận.");
                    prepareFormAgain(request, roomDAO, maPhong);
                    request.getRequestDispatcher("book-room-staff.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra xung đột thời gian
                List<RoomBookingStatusDTO> existingBookings = roomDAO.getRoomBookingStatusByRoomId(maPhong);
                for (RoomBookingStatusDTO b : existingBookings) {
                    LocalDateTime start = b.getNgayNhanDuKien();
                    LocalDateTime end   = b.getNgayTraDuKien();
                    if (start != null && end != null) {
                        if (!(ngayTra.isBefore(start) || ngayNhan.isAfter(end))) {
                            request.setAttribute("error",
                                "Phòng đã có người đặt từ " + start + " đến " + end + ". Vui lòng chọn ngày khác.");
                            prepareFormAgain(request, roomDAO, maPhong);
                            request.getRequestDispatcher("book-room-staff.jsp").forward(request, response);
                            return;
                        }
                    }
                }

                // Tìm hoặc tạo khách hàng theo CCCD
                CustomerDAO customerDAO = new CustomerDAO();
                int maKH = customerDAO.findCustomerIdByCCCD(cccd);
                if (maKH == 0) {
                    CustomerDTO kh = new CustomerDTO();
                    kh.setHoten(hoTen);
                    kh.setCccd(cccd);
                    kh.setSdt(sdt);
                    kh.setEmail(email);
                    kh.setDiachi(diaChi);
                    try {
                        customerDAO.addCustomer(kh);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    maKH = customerDAO.findCustomerIdByCCCD(cccd);
                }

                // Tạo phiếu đặt phòng
                RoomBookingStatusDTO newBooking = new RoomBookingStatusDTO();
                newBooking.setMaPhong(maPhong);
                newBooking.setMaKhachHang(maKH);
                newBooking.setNgayNhanDuKien(ngayNhan);
                newBooking.setNgayTraDuKien(ngayTra);
                newBooking.setTrangThai("DaDat");

                BookingDAO bookingDAO = new BookingDAO();
                bookingDAO.addNewBooking(newBooking);

                response.sendRedirect("BookingByStaff?action=list");
                break;
            }

            default:
                response.sendRedirect("BookingByStaff?action=list");
                break;
        }
    }

    /** Chuẩn bị lại dữ liệu phòng khi cần hiện lại form có lỗi */
    private void prepareFormAgain(HttpServletRequest request, RoomDAO roomDAO, int maPhong) {
        RoomDTO room = roomDAO.getRoomById(maPhong);
        List<RoomBookingStatusDTO> existingBookings = roomDAO.getRoomBookingStatusByRoomId(maPhong);
        request.setAttribute("room", room);
        request.setAttribute("existingBookings", existingBookings);
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