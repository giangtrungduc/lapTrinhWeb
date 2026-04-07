package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.RoomTypeDAO;
import com.mycompany.laptrinhweb.model.dto.RoomTypeDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

public class RoomServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
        List<RoomTypeDTO> listLoaiPhong = roomTypeDAO.listLoaiPhong();
        request.setAttribute("loaiPhongList", listLoaiPhong);
        request.getRequestDispatcher("room.jsp").forward(request, response);
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
        return "Servlet quản lý Phòng và Loại phòng";
    }
}
