package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.BookingDAO;
import com.mycompany.laptrinhweb.model.dao.ServiceForEmployeeDAO;
import com.mycompany.laptrinhweb.model.dto.BookingDTO;
import com.mycompany.laptrinhweb.model.dto.ServiceDTO;
import com.mycompany.laptrinhweb.model.dto.UsedServiceDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServiceServlet", urlPatterns = {"/ServiceServlet"})
public class ServiceServlet extends HttpServlet {

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
        ServiceForEmployeeDAO serviceDAO = new ServiceForEmployeeDAO();

        try {
            if ("view".equals(action)) {
                int maDatPhong = Integer.parseInt(request.getParameter("maDatPhong"));
                loadServicePanel(request, bookingDAO, serviceDAO, maDatPhong);
                request.setAttribute("showServicePanel", true);
                
                System.out.println("ACTION = " + action);
                System.out.println("maDatPhong = " + request.getParameter("maDatPhong"));

            } else if ("add".equals(action)) {
                int maDatPhong = Integer.parseInt(request.getParameter("maDatPhong"));
                int maDV = Integer.parseInt(request.getParameter("maDV"));
                int soLuong = Integer.parseInt(request.getParameter("soLuong"));

                boolean ok = serviceDAO.addServiceToBooking(maDatPhong, maDV, soLuong);
                if (ok) {
                    request.setAttribute("message", "Thêm dịch vụ thành công.");
                } else {
                    request.setAttribute("message", "Thêm dịch vụ thất bại.");
                }

                loadServicePanel(request, bookingDAO, serviceDAO, maDatPhong);
                request.setAttribute("showServicePanel", true);

            } else if ("delete".equals(action)) {
                int maDatPhong = Integer.parseInt(request.getParameter("maDatPhong"));
                int maSDDV = Integer.parseInt(request.getParameter("maSDDV"));

                boolean ok = serviceDAO.deleteUsedService(maSDDV);
                if (ok) {
                    request.setAttribute("message", "Xóa dịch vụ thành công.");
                } else {
                    request.setAttribute("message", "Xóa dịch vụ thất bại.");
                }

                loadServicePanel(request, bookingDAO, serviceDAO, maDatPhong);
                request.setAttribute("showServicePanel", true);

            } else if ("close".equals(action)) {
                // chỉ đóng popup, không cần làm gì thêm
            }

            List<BookingDTO> dsDaNhanPhong;
            if (customerInformation != null && !customerInformation.trim().isEmpty()) {
                dsDaNhanPhong = serviceDAO.searchCheckedInBookings(customerInformation.trim());
                request.setAttribute("customerInformation", customerInformation);
            } else {
                dsDaNhanPhong = serviceDAO.listCheckedInBookings();
            }

            request.setAttribute("dsDaNhanPhong", dsDaNhanPhong);

        } catch (Exception e) {
            request.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
            e.printStackTrace();

            List<BookingDTO> dsDaNhanPhong;
            if (customerInformation != null && !customerInformation.trim().isEmpty()) {
                dsDaNhanPhong = serviceDAO.searchCheckedInBookings(customerInformation.trim());
                request.setAttribute("customerInformation", customerInformation);
            } else {
                dsDaNhanPhong = serviceDAO.listCheckedInBookings();
            }
            request.setAttribute("dsDaNhanPhong", dsDaNhanPhong);
        }

        request.getRequestDispatcher("service.jsp").forward(request, response);
    }

    private void loadServicePanel(HttpServletRequest request, BookingDAO bookingDAO,
                                  ServiceForEmployeeDAO serviceDAO, int maDatPhong) {
        BookingDTO chiTiet = bookingDAO.getBookingDTOByIDForCheckOut(maDatPhong);
        List<ServiceDTO> dsDichVu = serviceDAO.getAllServices();
        List<UsedServiceDTO> dsDichVuDaThem = serviceDAO.getUsedServicesByBooking(maDatPhong);
        
        System.out.println("loadServicePanel maDatPhong = " + maDatPhong);
        System.out.println("chiTiet = " + chiTiet);

        request.setAttribute("chiTiet", chiTiet);
        request.setAttribute("dsDichVu", dsDichVu);
        request.setAttribute("dsDichVuDaThem", dsDichVuDaThem);
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