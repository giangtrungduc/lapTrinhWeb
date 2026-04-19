package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.BookingDAO;
import com.mycompany.laptrinhweb.model.dto.BookingDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name = "BookingConfirmationServlet", urlPatterns = {"/BookingConfirmationServlet"})
public class BookingConfirmationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
        if (action == null) {
            action = "list";
        }

        BookingDAO dao = new BookingDAO();

        if ("view".equals(action)) {
            String maDatPhongRaw = request.getParameter("maDatPhong");
            if (maDatPhongRaw != null && !maDatPhongRaw.isEmpty()) {
                int maDatPhong = Integer.parseInt(maDatPhongRaw);
                BookingDTO chiTiet = dao.getBookingDTOByID(maDatPhong);
                if (chiTiet != null) {
                    request.setAttribute("chiTiet", chiTiet);
                } else {
                    request.setAttribute("message", "Không tìm thấy phiếu đặt phòng.");
                }
            }

        } else if ("confirm".equals(action)) {
            int maDatPhong = Integer.parseInt(request.getParameter("maDatPhong"));
            boolean ok = dao.updateTrangThaiDatPhong(maDatPhong, "DaDat", maNV);
            if (ok) {
                request.setAttribute("message", "Xác nhận phiếu đặt phòng thành công.");
            } else {
                request.setAttribute("message", "Xác nhận thất bại.");
            }

        } else if ("cancel".equals(action)) {
            int maDatPhong = Integer.parseInt(request.getParameter("maDatPhong"));
            boolean ok = dao.updateTrangThaiDatPhong(maDatPhong, "DaHuy", maNV);
            if (ok) {
                request.setAttribute("message", "Hủy phiếu đặt phòng thành công.");
            } else {
                request.setAttribute("message", "Hủy thất bại.");
            }

        } else if ("close".equals(action)) {
            // không cần làm gì, chỉ load lại danh sách
        }

        List<BookingDTO> dsChoXacNhan = dao.listBooking();
        request.setAttribute("dsChoXacNhan", dsChoXacNhan);

        request.getRequestDispatcher("booking-confirmation.jsp").forward(request, response);
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