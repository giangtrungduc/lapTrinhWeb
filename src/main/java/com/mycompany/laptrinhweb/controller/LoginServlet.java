/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.laptrinhweb.controller;

import com.mycompany.laptrinhweb.model.dto.LoginDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.mycompany.laptrinhweb.model.dao.LoginDAO;

/**
 *
 * @author Admin
 */
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        if (username==null && password==null){
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
//        LoginDTO login=new LoginDTO();
//        login.setPassword(password);
//        login.setUsername(username);
        System.out.println(username+" "+password);
        LoginDAO lgDAO=new LoginDAO();
        String result=lgDAO.checkLogin(username, password);
        String errMsg="Ten dang nhap hoac mat khau khong hop le";
        if (result==null){
            request.setAttribute("failLogin", errMsg);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            
        }
        else{
            String user=username;
            request.setAttribute("user", user);
            request.getRequestDispatcher("main.jsp").forward(request, response);
            
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
