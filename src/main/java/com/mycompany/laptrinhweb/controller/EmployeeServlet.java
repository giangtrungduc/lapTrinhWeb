/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dto.EmployeeDTO;
import com.mycompany.laptrinhweb.model.dao.EmployeeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Admin
 */
public class EmployeeServlet extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        EmployeeDAO employeeDAO = new EmployeeDAO();
        String action = request.getParameter("action");
        String message = null;
        if (action == null) {
            action = "list";
        }
        try {
            switch (action) {
                case "add": {
                    String hoTen = request.getParameter("hoTen");
                    String sdt = request.getParameter("sdt");
                    String chucVu = request.getParameter("chucVu");
                    String tenDangNhap = request.getParameter("tenDangNhap");
                    String matKhauHash = request.getParameter("matKhauHash");
                    if (employeeDAO.isTenDangNhapExists(tenDangNhap, null)) {
                        message = "Tên đăng nhập đã tồn tại";
                    } else {
                        EmployeeDTO ep = new EmployeeDTO();
                        ep.setHoTen(hoTen);
                        ep.setChucVu(chucVu);
                        ep.setSdt(sdt);
                        ep.setTenDangNhap(tenDangNhap);
                        ep.setMatKhauHash(matKhauHash);
                        if (employeeDAO.addEmployee(ep)) {
                            message = "Thêm nhân viên thành công";
                        } else {
                            message = "Thêm nhân viên thất bại";
                        }
                    }
                    List<EmployeeDTO> list = employeeDAO.listEmployee();
                    request.setAttribute("nhanVienList", list);
                    break;
                }

                case "update": {
                    int maNV = Integer.parseInt(request.getParameter("maNV"));
                    String hoTen = request.getParameter("hoTen");
                    String sdt = request.getParameter("sdt");
                    String chucVu = request.getParameter("chucVu");
                    String tenDangNhap = request.getParameter("tenDangNhap");
                    String matKhauHash = request.getParameter("matKhauHash");
                    if (employeeDAO.isTenDangNhapExists(tenDangNhap, maNV)) {
                        message = "Tên đăng nhập đã tồn tại";
                    } else {
                        EmployeeDTO nv = new EmployeeDTO();
                        nv.setMaNV(maNV);
                        nv.setHoTen(hoTen);
                        nv.setSdt(sdt);
                        nv.setChucVu(chucVu);
                        nv.setTenDangNhap(tenDangNhap);
                        nv.setMatKhauHash(matKhauHash);
                        if (employeeDAO.updateEmPloyee(nv)) {
                            message = "Cập nhật nhân viên thành công";
                        } else {
                            message = "Cập nhật nhân viên thất bại";
                        }
                    }
                    List<EmployeeDTO> list = employeeDAO.listEmployee();
                    request.setAttribute("nhanVienList", list);
                    break;
                }
                case "delete": {
                    int maNV = Integer.parseInt(request.getParameter("maNV"));
                    if (employeeDAO.deleteEmployee(maNV)) {
                        message = "Xóa nhân viên thành công";
                    } else {
                        message = "Xóa nhân viên thất bại";
                    }
                    List<EmployeeDTO> list = employeeDAO.listEmployee();
                    request.setAttribute("nhanVienList", list);
                    break;
                }

                case "search": {
                    String key = request.getParameter("keyword");
                    List<EmployeeDTO> list = employeeDAO.searchNhanVien(key);
                    request.setAttribute("nhanVienList", list);
                    request.setAttribute("keyword", key);
                }
                default:{
                    List<EmployeeDTO> list=employeeDAO.listEmployee();
                    request.setAttribute("nhanVienList", list);
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("message", message);
        request.getRequestDispatcher("employee.jsp").forward(request, response);
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
