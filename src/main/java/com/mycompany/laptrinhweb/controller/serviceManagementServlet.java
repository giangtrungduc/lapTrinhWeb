/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dao.serviceDAO;
import com.mycompany.laptrinhweb.model.dto.serviceDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class serviceManagementServlet extends HttpServlet {

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
        serviceDAO svDAO = new serviceDAO();
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "add": {
                String tenDV = request.getParameter("tenDV");
                BigDecimal donGia = new BigDecimal(request.getParameter("donGia"));
                String moTa = request.getParameter("moTa");
                
                serviceDTO sv1 = new serviceDTO();
                sv1.setTenDV(tenDV);
                sv1.setDonGia(donGia);
                sv1.setMoTa(moTa);
                svDAO.addService(sv1);
                List<serviceDTO> list = svDAO.listService();
                request.setAttribute("listService", list);
                break;
            }
            case "update": {
                Integer maDV = Integer.parseInt(request.getParameter("maDV"));
                String tenDV = request.getParameter("tenDV");
                BigDecimal donGia = new BigDecimal(request.getParameter("donGia"));
                String moTa = request.getParameter("moTa");
                serviceDTO sv1 = new serviceDTO();
                sv1.setTenDV(tenDV);
                sv1.setDonGia(donGia);
                sv1.setMoTa(moTa);
                sv1.setMaDV(maDV);
                svDAO.updateService(sv1);
                List<serviceDTO> list = svDAO.listService();
                request.setAttribute("listService", list);
                break;
            }
            case "delete": {
                Integer maDV = Integer.parseInt(request.getParameter("maDV"));
                svDAO.deleteService(maDV);
                List<serviceDTO> list = svDAO.listService();
                request.setAttribute("listService", list);
                break;
            }
            case "search": {
                String key = request.getParameter("search");
                List<serviceDTO> list = svDAO.searchService(key);
                request.setAttribute("listService", list);
                HttpSession session = request.getSession();
                session.setAttribute("keyword", key);
                break;                
            }
            
            default: {
                List<serviceDTO> list = svDAO.listService();
                request.setAttribute("listService", list);
            }
        }
        request.getRequestDispatcher("servicemanagement.jsp").forward(request, response);
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
