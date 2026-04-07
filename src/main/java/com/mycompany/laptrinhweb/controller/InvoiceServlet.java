/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.BookingDAO;
import com.mycompany.laptrinhweb.model.dto.BillDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

/**
 *
 * @author DELL
 */
public class InvoiceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int madp = Integer.parseInt(request.getParameter("madp"));
        BookingDAO bookingDAO = new BookingDAO();
        BillDTO bill = new BillDTO();
        bill = bookingDAO.FindBookingById(madp);
        String ngayTraStr = request.getParameter("ngaytra");
        LocalDateTime ngayTra = LocalDateTime.parse(ngayTraStr);
        LocalDateTime ngayNhan = bill.getNgayNhanDuKien();
        long soDem = ChronoUnit.DAYS.between(ngayNhan, ngayTra);
        bill.setSoDem((int) soDem);
        // Chuyển soDem sang BigDecimal rồi mới nhân
        BigDecimal tienPhong = BigDecimal.valueOf(soDem).multiply(bill.getGiaPhong());

// Sau đó gán vào object bill để hiển thị
        // ... (đoạn code tính toán soDem và tienPhong của Kiên) ...
        bill.setTongTienPhong(tienPhong);

// QUAN TRỌNG: Gửi đối tượng bill sang JSP
        request.setAttribute("bill", bill);
        request.getRequestDispatcher("bill.jsp").forward(request, response);
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
