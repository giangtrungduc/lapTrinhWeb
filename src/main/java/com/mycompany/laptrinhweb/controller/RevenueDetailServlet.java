/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.RevenueDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class RevenueDetailServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        RevenueDetailDAO revenueDetailDAO = new RevenueDetailDAO();

        String tuNgay = request.getParameter("tuNgay");
        String denNgay = request.getParameter("denNgay");
        String thang = request.getParameter("thang");
        String nam = request.getParameter("nam");

        // Ghi chú:
        // Nếu có lọc theo ngày thì ưu tiên ngày, tự bỏ qua tháng/năm
        boolean coNgay = (tuNgay != null && !tuNgay.trim().isEmpty())
                || (denNgay != null && !denNgay.trim().isEmpty());

        boolean coThangNam = (thang != null && !thang.trim().isEmpty())
                || (nam != null && !nam.trim().isEmpty());

        if (coNgay && coThangNam) {
            thang = null;
            nam = null;

            request.setAttribute("infoMessage",
                    "Hệ thống đã ưu tiên lọc theo Từ ngày - Đến ngày, nên Tháng/Năm đã được bỏ qua.");
        }

        request.setAttribute("tuNgay", tuNgay);
        request.setAttribute("denNgay", denNgay);
        request.setAttribute("thang", thang);
        request.setAttribute("nam", nam);

        request.setAttribute("top3Phong", revenueDetailDAO.getTop3PhongDoanhThu(thang, nam));
        request.setAttribute("top3DichVu", revenueDetailDAO.getTop3DichVuDoanhThu(thang, nam));

        request.setAttribute("tongDoanhThu", revenueDetailDAO.getTongDoanhThu(tuNgay, denNgay, thang, nam));
        request.setAttribute("doanhThuPhong", revenueDetailDAO.getDoanhThuPhong(tuNgay, denNgay, thang, nam));
        request.setAttribute("doanhThuDichVu", revenueDetailDAO.getDoanhThuDichVu(tuNgay, denNgay, thang, nam));
        request.setAttribute("hoaDonList", revenueDetailDAO.getHoaDonList(tuNgay, denNgay, thang, nam));

        request.getRequestDispatcher("revenue.jsp").forward(request, response);
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
