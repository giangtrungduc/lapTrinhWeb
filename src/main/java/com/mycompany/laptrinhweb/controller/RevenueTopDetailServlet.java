package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.RevenueDetailDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet hiển thị chi tiết 1 phòng hoặc 1 dịch vụ
 */
public class RevenueTopDetailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type");
        String id = request.getParameter("id");
        String thang = request.getParameter("thang");
        String nam = request.getParameter("nam");

        RevenueDetailDAO dao = new RevenueDetailDAO();

        request.setAttribute("type", type);
        request.setAttribute("thang", thang);
        request.setAttribute("nam", nam);

        if ("room".equals(type) && id != null && !id.isEmpty()) {
            request.setAttribute("detail", dao.getChiTietPhongDoanhThu(Integer.parseInt(id), thang, nam));
        } else if ("service".equals(type) && id != null && !id.isEmpty()) {
            request.setAttribute("detail", dao.getChiTietDichVuDoanhThu(Integer.parseInt(id), thang, nam));
        }

        request.getRequestDispatcher("revenueTopDetail.jsp").forward(request, response);
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
        return "Revenue Top Detail Servlet";
    }
}