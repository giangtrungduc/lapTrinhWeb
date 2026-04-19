package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.BookingDAO;
import com.mycompany.laptrinhweb.model.dao.CheckOutDAO;
import com.mycompany.laptrinhweb.model.dto.BookingDTO;
import com.mycompany.laptrinhweb.model.dto.UsedServiceDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CheckOutServlet", urlPatterns = {"/CheckOutServlet"})
public class CheckOutServlet extends HttpServlet {

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

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        String customerInformation = request.getParameter("customerInformation");

        BookingDAO bookingDAO = new BookingDAO();
        CheckOutDAO checkOutDAO = new CheckOutDAO();

        try {
            if ("view".equals(action)) {
                int maDatPhong = Integer.parseInt(request.getParameter("maDatPhong"));
                loadCheckOutDetail(request, bookingDAO, checkOutDAO, maDatPhong);

            } else if ("checkout".equals(action)) {
                int maDatPhong = Integer.parseInt(request.getParameter("maDatPhong"));

                boolean ok = checkOutDAO.processCheckOut(maDatPhong, maNV);
                if (ok) {
                    request.setAttribute("message", "Check-out thành công và đã tạo/cập nhật hóa đơn.");
                } else {
                    request.setAttribute("message", "Check-out thất bại.");
                    loadCheckOutDetail(request, bookingDAO, checkOutDAO, maDatPhong);
                }

            } else if ("close".equals(action)) {
                // không làm gì, chỉ đóng phần chi tiết
            }

            List<BookingDTO> dsDangO;
            if (customerInformation != null && !customerInformation.trim().isEmpty()) {
                dsDangO = checkOutDAO.searchCheckedInBookingsForCheckOut(customerInformation.trim());
                request.setAttribute("customerInformation", customerInformation);
            } else {
                dsDangO = checkOutDAO.listCheckedInBookingsForCheckOut();
            }

            request.setAttribute("dsDangO", dsDangO);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());

            List<BookingDTO> dsDangO;
            if (customerInformation != null && !customerInformation.trim().isEmpty()) {
                dsDangO = checkOutDAO.searchCheckedInBookingsForCheckOut(customerInformation.trim());
                request.setAttribute("customerInformation", customerInformation);
            } else {
                dsDangO = checkOutDAO.listCheckedInBookingsForCheckOut();
            }
            request.setAttribute("dsDangO", dsDangO);
        }

        request.getRequestDispatcher("check-out.jsp").forward(request, response);
    }

    private void loadCheckOutDetail(HttpServletRequest request, BookingDAO bookingDAO,
                                    CheckOutDAO checkOutDAO, int maDatPhong) {

        BookingDTO chiTiet = bookingDAO.getBookingDTOByIDForCheckOut(maDatPhong);
        List<UsedServiceDTO> dsDichVuDaThem = checkOutDAO.getUsedServicesByBooking(maDatPhong);

        double tongTienPhong = checkOutDAO.calculateRoomAmount(maDatPhong);
        double tongTienDV = checkOutDAO.getTotalServiceAmount(maDatPhong);
        double tongThanhToan = tongTienPhong + tongTienDV;

        request.setAttribute("chiTiet", chiTiet);
        request.setAttribute("dsDichVuDaThem", dsDichVuDaThem);
        request.setAttribute("tongTienPhong", tongTienPhong);
        request.setAttribute("tongTienDV", tongTienDV);
        request.setAttribute("tongThanhToan", tongThanhToan);
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