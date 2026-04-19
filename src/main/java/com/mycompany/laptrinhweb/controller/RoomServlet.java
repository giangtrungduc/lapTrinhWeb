package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.RoomDAO;
import com.mycompany.laptrinhweb.model.dto.RoomDTO;
import com.mycompany.laptrinhweb.model.dto.RoomStatus;
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
        String role = (String) session.getAttribute("chucVu");
        
        System.out.println(role);

        // Chặn người không phải quản lý
        if (!"Quan Ly".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        RoomDAO roomDAO = new RoomDAO();
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {

                // ========== PHÒNG ==========

                case "list": {
                    List<RoomDTO> list = roomDAO.listRoom();
                    request.setAttribute("roomList", list);
                    request.getRequestDispatcher("room.jsp").forward(request, response);
                    break;
                }

                case "showAddRoom": {
                    List<RoomTypeDTO> roomTypes = roomDAO.listRoomType();
                    request.setAttribute("roomTypes", roomTypes);
                    request.getRequestDispatcher("add-room.jsp").forward(request, response);
                    break;
                }

                case "addRoom": {
                    int soPhong = Integer.parseInt(request.getParameter("soPhong"));
                    int maLoaiPhong = Integer.parseInt(request.getParameter("maLoaiPhong"));
                    String trangThai = request.getParameter("trangThai");

                    RoomDTO room = new RoomDTO();
                    room.setSophong(soPhong);
                    room.setMaloaiphong(maLoaiPhong);
                    room.setTrangthai(RoomStatus.fromName(trangThai));

                    roomDAO.addRoom(room);
                    response.sendRedirect("RoomServlet?action=list");
                    break;
                }

                case "showEditRoom": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    RoomDTO room = roomDAO.getRoomById(id);
                    List<RoomTypeDTO> roomTypes = roomDAO.listRoomType();
                    request.setAttribute("room", room);
                    request.setAttribute("roomTypes", roomTypes);
                    request.getRequestDispatcher("edit-room.jsp").forward(request, response);
                    break;
                }

                case "editRoom": {
                    int maPhong = Integer.parseInt(request.getParameter("maPhong"));
                    int soPhong = Integer.parseInt(request.getParameter("soPhong"));
                    int maLoaiPhong = Integer.parseInt(request.getParameter("maLoaiPhong"));
                    String trangThai = request.getParameter("trangThai");

                    RoomDTO room = new RoomDTO();
                    room.setMaphong(maPhong);
                    room.setSophong(soPhong);
                    room.setMaloaiphong(maLoaiPhong);
                    room.setTrangthai(RoomStatus.fromName(trangThai));

                    roomDAO.updateRoom(room);
                    response.sendRedirect("RoomServlet?action=list");
                    break;
                }

                case "deleteRoom": {
                    // Không xóa thật - chuyển trạng thái về Bảo Trì
                    int id = Integer.parseInt(request.getParameter("id"));
                    roomDAO.setRoomBaoTri(id);
                    response.sendRedirect("RoomServlet?action=list");
                    break;
                }

                // ========== LOẠI PHÒNG ==========

                case "listRoomType": {
                    List<RoomTypeDTO> list = roomDAO.listRoomType();
                    request.setAttribute("roomTypeList", list);
                    request.getRequestDispatcher("roomtype.jsp").forward(request, response);
                    break;
                }

                case "showAddRoomType": {
                    request.getRequestDispatcher("add-roomtype.jsp").forward(request, response);
                    break;
                }

                case "addRoomType": {
                    String tenLoaiPhong = request.getParameter("tenLoaiPhong");
                    int soNguoiToiDa = Integer.parseInt(request.getParameter("soNguoiToiDa"));
                    float giaCoBan = Float.parseFloat(request.getParameter("giaCoBan"));

                    RoomTypeDTO rt = new RoomTypeDTO();
                    rt.setTenloaiphong(tenLoaiPhong);
                    rt.setSonguoitoida(soNguoiToiDa);
                    rt.setGiacoban(giaCoBan);

                    roomDAO.addRoomType(rt);
                    response.sendRedirect("RoomServlet?action=listRoomType");
                    break;
                }

                case "showEditRoomType": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    RoomTypeDTO rt = roomDAO.getRoomTypeById(id);
                    request.setAttribute("roomType", rt);
                    request.getRequestDispatcher("edit-roomtype.jsp").forward(request, response);
                    break;
                }

                case "editRoomType": {
                    int maLoaiPhong = Integer.parseInt(request.getParameter("maLoaiPhong"));
                    String tenLoaiPhong = request.getParameter("tenLoaiPhong");
                    int soNguoiToiDa = Integer.parseInt(request.getParameter("soNguoiToiDa"));
                    float giaCoBan = Float.parseFloat(request.getParameter("giaCoBan"));

                    RoomTypeDTO rt = new RoomTypeDTO();
                    rt.setMaloaiphong(maLoaiPhong);
                    rt.setTenloaiphong(tenLoaiPhong);
                    rt.setSonguoitoida(soNguoiToiDa);
                    rt.setGiacoban(giaCoBan);

                    roomDAO.updateRoomType(rt);
                    response.sendRedirect("RoomServlet?action=listRoomType");
                    break;
                }

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