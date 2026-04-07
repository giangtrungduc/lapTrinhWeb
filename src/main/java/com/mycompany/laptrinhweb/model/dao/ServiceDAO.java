/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import com.mycompany.laptrinhweb.model.dto.ServiceDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO {
    
    public List<ServiceDTO> findServiceByMaDP(int madp){
        DBConnection db = new DBConnection();
        List<ServiceDTO> service = new ArrayList<>();
        try(Connection conn = db.getConnection()){
            String sql="select * from sudungdichvu a join datphong b on a.madatphong=b.madatphong join dichvu c on a.MaDV=c.MaDV where a.MaDatPhong=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, madp);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                ServiceDTO ser = new ServiceDTO();
                ser.setMaDV(rs.getInt("MaDV"));
                ser.setDonGia(rs.getBigDecimal("DonGia"));
                ser.setSoLuong(rs.getInt("SoLuong"));
                ser.setTenDV(rs.getString("TenDV"));
                service.add(ser);
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return service;
    }
}
