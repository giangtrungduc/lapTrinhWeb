package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.HoaDonDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ThanhToanServlet", urlPatterns = { "/thanhtoan" })
public class ThanhToanServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Nhận dữ liệu từ form (JSP)
            int maDatPhong = Integer.parseInt(request.getParameter("maDatPhong"));
            double tongTienPhong = Double.parseDouble(request.getParameter("tongTienPhong"));
            double tongTienDV = Double.parseDouble(request.getParameter("tongTienDV"));
            String phuongThuc = request.getParameter("phuongThuc");
            String trangThai = request.getParameter("trangThai");

            HoaDonDAO hoaDonDAO = new HoaDonDAO();

            // 1. Tạo hóa đơn
            int maHoaDon = hoaDonDAO.taoHoaDon(maDatPhong, tongTienPhong, tongTienDV);

            if (maHoaDon > 0) {
                // 2. Thực hiện thanh toán (Tính tổng tiền để lưu vào ThanhToan)
                double soTien = tongTienPhong + tongTienDV;
                boolean isSuccess = hoaDonDAO.thanhToan(maHoaDon, soTien, phuongThuc, trangThai);

                if (isSuccess) {
                    request.setAttribute("msg", "Tạo hóa đơn và thanh toán thành công!");
                } else {
                    request.setAttribute("msg", "Tạo hóa đơn thành công nhưng lỗi thanh toán!");
                }
            } else {
                request.setAttribute("msg", "Lỗi tạo hóa đơn!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Dữ liệu đầu vào không hợp lệ hoặc lỗi hệ thống!");
        }

        // Forward về main.jsp hoặc trang hiển thị kết quả
        request.getRequestDispatcher("main.jsp").forward(request, response);
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
