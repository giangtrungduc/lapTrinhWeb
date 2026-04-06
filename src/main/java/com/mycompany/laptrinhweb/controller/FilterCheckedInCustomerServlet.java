/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.CustomerDAO;
import com.mycompany.laptrinhweb.model.dto.CheckedInCustomerDTO;
import com.mycompany.laptrinhweb.model.dto.CustomerDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author DELL
 */
public class FilterCheckedInCustomerServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String infor = request.getParameter("customerInformation");
        String makhRaw = request.getParameter("makh");

        CustomerDAO customerDAO = new CustomerDAO();

        // TH1: Nếu có makh (người dùng nhấn vào link Xác nhận)
        if (makhRaw != null && !makhRaw.isEmpty()) {
            int makh = Integer.parseInt(makhRaw);
            List<CheckedInCustomerDTO> listBooking = customerDAO.findBookingByCustomerId(makh);
            request.setAttribute("listBooking", listBooking);
            
            request.getRequestDispatcher("check-in.jsp").forward(request, response);
            
        } // TH2: Nếu có thông tin tìm kiếm (người dùng nhấn nút Tìm kiếm)
        else if (infor != null && !infor.trim().isEmpty()) {
            List<CustomerDTO> listCustomers = customerDAO.filterCustomer(infor);
            request.setAttribute("listCustomers", listCustomers);
            request.getRequestDispatcher("check-in.jsp").forward(request, response);
        } // TH3: Mặc định (vào trang lần đầu)
        else {
            request.getRequestDispatcher("check-in.jsp").forward(request, response);
        }
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
