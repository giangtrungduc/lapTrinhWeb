package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.RoomDAO;
import com.mycompany.laptrinhweb.model.dao.RoomTypeDAO;
import com.mycompany.laptrinhweb.model.dto.RoomDTO;
import com.mycompany.laptrinhweb.model.dto.RoomTypeDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

public class RoomServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("chucVu"); // Nhớ kiểm tra tên attribute này trong LoginServlet
        
        RoomDAO roomDAO = new RoomDAO();
        RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
        
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "list":
                    List<RoomDTO> listRoom = roomDAO.listRoom();
                    List<RoomTypeDTO> listLoaiPhong = roomTypeDAO.listLoaiPhong();
                    request.setAttribute("roomList", listRoom);
                    request.setAttribute("loaiPhongList", listLoaiPhong);
                    request.getRequestDispatcher("room.jsp").forward(request, response);
                    break;
                case "delete":
                    if ("Quản lý".equals(role)) {
                        int id = Integer.parseInt(request.getParameter("id"));
                        roomDAO.deleteRoom(id);
                    }
                    response.sendRedirect("RoomServlet?action=list");
                    break;
                default:
                    response.sendRedirect("RoomServlet?action=list");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("main.jsp");
        }
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