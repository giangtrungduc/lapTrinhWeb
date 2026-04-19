package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.PaymentDAO;
import com.mycompany.laptrinhweb.model.dto.PaymentViewDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/PaymentServlet"})
public class PaymentServlet extends HttpServlet {

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
        PaymentDAO dao = new PaymentDAO();

        try {
            if ("view".equals(action)) {
                int maHoaDon = Integer.parseInt(request.getParameter("maHoaDon"));
                PaymentViewDTO chiTiet = dao.getPaymentDetailByInvoiceId(maHoaDon);
                request.setAttribute("chiTiet", chiTiet);

            } else if ("pay".equals(action)) {
                int maHoaDon = Integer.parseInt(request.getParameter("maHoaDon"));

                boolean ok = dao.processPayment(maHoaDon, maNV);
                if (ok) {
                    request.setAttribute("message", "Thanh toán thành công.");
                } else {
                    request.setAttribute("message", "Thanh toán thất bại hoặc hóa đơn đã được thanh toán.");
                }

                PaymentViewDTO chiTiet = dao.getPaymentDetailByInvoiceId(maHoaDon);
                request.setAttribute("chiTiet", chiTiet);

            } else if ("close".equals(action)) {
                // đóng phần chi tiết
            }

            List<PaymentViewDTO> dsHoaDon;
            if (customerInformation != null && !customerInformation.trim().isEmpty()) {
                dsHoaDon = dao.searchCompletedInvoices(customerInformation.trim());
                request.setAttribute("customerInformation", customerInformation);
            } else {
                dsHoaDon = dao.listCompletedInvoices();
            }

            request.setAttribute("dsHoaDon", dsHoaDon);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());

            List<PaymentViewDTO> dsHoaDon;
            if (customerInformation != null && !customerInformation.trim().isEmpty()) {
                dsHoaDon = dao.searchCompletedInvoices(customerInformation.trim());
                request.setAttribute("customerInformation", customerInformation);
            } else {
                dsHoaDon = dao.listCompletedInvoices();
            }

            request.setAttribute("dsHoaDon", dsHoaDon);
        }

        request.getRequestDispatcher("payment.jsp").forward(request, response);
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