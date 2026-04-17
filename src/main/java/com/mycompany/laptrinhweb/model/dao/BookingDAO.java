/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import com.mycompany.laptrinhweb.model.dto.BillDTO;
import com.mycompany.laptrinhweb.model.dto.RoomBookingStatusDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class BookingDAO {

    public BillDTO FindBookingById(int madatphong) {
        DBConnection db = new DBConnection();
        BillDTO booking = new BillDTO();
        InvoiceServiceDAO service = new InvoiceServiceDAO();
        booking.setServices(service.findServiceByMaDP(madatphong));
        try (Connection conn = db.getConnection()) {
            String sql = "select * from datphong a join phong b on a.MaPhong=b.MaPhong join khachhang c on c.MaKH=a.MaKH join loaiphong d on d.MaLoaiPhong=b.MaLoaiPhong where madatphong=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, madatphong);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                booking.setMaDatPhong(madatphong);
                booking.setHoTen(rs.getString("HoTen"));
                booking.setSdt(rs.getString("SDT"));
                booking.setCccd(rs.getString("CCCD"));
                booking.setEmail(rs.getString("Email"));
                booking.setSoPhong(rs.getInt("SoPhong"));
                booking.setMaPhong(rs.getInt("MaPhong"));
                LocalDateTime ngayNhanDuKien = rs.getTimestamp("NgayNhanDuKien").toLocalDateTime();
                LocalDateTime ngayTraDuKien = rs.getTimestamp("NgayTraDuKien").toLocalDateTime();
                booking.setNgayNhanDuKien(ngayNhanDuKien);
                booking.setNgayTraDuKien(ngayTraDuKien);
                booking.setGiaPhong(rs.getBigDecimal("GiaPhongTaiThoiDiemDat"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return booking;
    }
    public void completeBooking(int madp){
        DBConnection db = new DBConnection();
        try (Connection conn=db.getConnection()){
            String sql="update datphong set TrangThai='HoanThanh' where MaDatPhong=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, madp);
            ps.execute();
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
    public void addNewBooking(RoomBookingStatusDTO booking){
        DBConnection db = new DBConnection();
        try (Connection conn=db.getConnection()){
            String sql="insert into datphong (MaKH,MaPhong,NgayNhanDuKien,NgayTraDuKien,TrangThai) values(?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, booking.getMaKhachHang());
            ps.setInt(2, booking.getMaPhong());
            LocalDateTime ngayNhan = booking.getNgayNhanDuKien();
            ps.setTimestamp(3, Timestamp.valueOf(ngayNhan));

            LocalDateTime ngayTra = booking.getNgayTraDuKien();
            ps.setTimestamp(4, Timestamp.valueOf(ngayTra));

            ps.setString(5, booking.getTrangThai());

            ps.executeUpdate();
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
}
