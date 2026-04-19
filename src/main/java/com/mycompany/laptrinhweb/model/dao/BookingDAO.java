/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import com.mycompany.laptrinhweb.model.dto.BillDTO;
import com.mycompany.laptrinhweb.model.dto.BookingDTO;
import com.mycompany.laptrinhweb.model.dto.RoomBookingStatusDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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
    
    public List<BookingDTO> listBooking(){
        List<BookingDTO> list = new ArrayList<>();
        
        String sql = "SELECT MaDatPhong, MaKH, MaPhong, NgayDat, NgayNhanDuKien, NgayTraDuKien " +
                 "FROM DatPhong " +
                 "WHERE TrangThai = 'ChoXacNhan' " +
                 "ORDER BY NgayDat ASC";
        
        try(Connection conn = new DBConnection().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while(rs.next()){
                BookingDTO dp = new BookingDTO();
                dp.setMaDatPhong(rs.getInt("MaDatPhong"));
                dp.setMaKH(rs.getInt("MaKH"));
                dp.setMaPhong(rs.getInt("MaPhong"));
                LocalDateTime ngayDat = rs.getTimestamp("NgayDat").toLocalDateTime();
                LocalDateTime ngayNhanDuKien = rs.getTimestamp("NgayNhanDuKien").toLocalDateTime();
                LocalDateTime ngayTraDuKien = rs.getTimestamp("NgayTraDuKien").toLocalDateTime();
                dp.setNgayDat(ngayDat);
                dp.setNgayNhanDuKien(ngayNhanDuKien);
                dp.setNgayTraDuKien(ngayTraDuKien);
                list.add(dp);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<BookingDTO> listBookingByCheckIn(){
        List<BookingDTO> list = new ArrayList<>();
        
        String sql = "SELECT MaDatPhong, MaKH, MaPhong, NgayDat, NgayNhanDuKien, NgayTraDuKien " +
                 "FROM DatPhong " +
                 "WHERE TrangThai = 'DaDat' " +
                 "ORDER BY NgayDat ASC";
        
        try(Connection conn = new DBConnection().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while(rs.next()){
                BookingDTO dp = new BookingDTO();
                dp.setMaDatPhong(rs.getInt("MaDatPhong"));
                dp.setMaKH(rs.getInt("MaKH"));
                dp.setMaPhong(rs.getInt("MaPhong"));
                LocalDateTime ngayDat = rs.getTimestamp("NgayDat").toLocalDateTime();
                LocalDateTime ngayNhanDuKien = rs.getTimestamp("NgayNhanDuKien").toLocalDateTime();
                LocalDateTime ngayTraDuKien = rs.getTimestamp("NgayTraDuKien").toLocalDateTime();
                dp.setNgayDat(ngayDat);
                dp.setNgayNhanDuKien(ngayNhanDuKien);
                dp.setNgayTraDuKien(ngayTraDuKien);
                list.add(dp);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<BookingDTO> searchBookedList(String keyword) {
        List<BookingDTO> list = new ArrayList<>();

        String sql = "SELECT dp.MaDatPhong, dp.MaKH, dp.MaPhong, dp.NgayDat, dp.NgayNhanDuKien, dp.NgayTraDuKien " +
                     "FROM DatPhong dp " +
                     "JOIN KhachHang kh ON dp.MaKH = kh.MaKH " +
                     "WHERE dp.TrangThai = 'DaDat' " +
                     "AND (kh.SDT LIKE ? OR kh.CCCD LIKE ?) " +
                     "ORDER BY dp.NgayDat ASC";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BookingDTO dp = new BookingDTO();
                    dp.setMaDatPhong(rs.getInt("MaDatPhong"));
                    dp.setMaKH(rs.getInt("MaKH"));
                    dp.setMaPhong(rs.getInt("MaPhong"));
                    LocalDateTime ngayDat = rs.getTimestamp("NgayDat").toLocalDateTime();
                    LocalDateTime ngayNhanDuKien = rs.getTimestamp("NgayNhanDuKien").toLocalDateTime();
                    LocalDateTime ngayTraDuKien = rs.getTimestamp("NgayTraDuKien").toLocalDateTime();
                    dp.setNgayDat(ngayDat);
                    dp.setNgayNhanDuKien(ngayNhanDuKien);
                    dp.setNgayTraDuKien(ngayTraDuKien);
                    list.add(dp);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public BookingDTO getBookingDTOByID(int id){
        BookingDTO dp = new BookingDTO();
        String sql = "SELECT dp.MaDatPhong, dp.MaKH, dp.MaPhong, dp.NgayDat, dp.NgayNhanDuKien, dp.NgayTraDuKien, " +
                 "dp.TrangThai, dp.GhiChu, dp.GiaPhongTaiThoiDiemDat, " +
                 "kh.HoTen AS TenKhachHang, kh.CCCD, kh.SDT AS SDTKhachHang, kh.Email, kh.DiaChi, " +
                 "p.SoPhong, lp.TenLoaiPhong, lp.SoNguoiToiDa, lp.GiaCoBan, lp.MoTa " +
                 "FROM DatPhong dp " +
                 "JOIN KhachHang kh ON dp.MaKH = kh.MaKH " +
                 "JOIN Phong p ON dp.MaPhong = p.MaPhong " +
                 "JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong " +
                 "WHERE dp.MaDatPhong = ? AND dp.TrangThai = 'ChoXacNhan'";
        try(Connection conn = new DBConnection().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                dp.setMaDatPhong(rs.getInt("MaDatPhong"));
                dp.setMaKH(rs.getInt("MaKH"));
                dp.setMaPhong(rs.getInt("MaPhong"));
                LocalDateTime ngayDat = rs.getTimestamp("NgayDat").toLocalDateTime();
                LocalDateTime ngayNhanDuKien = rs.getTimestamp("NgayNhanDuKien").toLocalDateTime();
                LocalDateTime ngayTraDuKien = rs.getTimestamp("NgayTraDuKien").toLocalDateTime();
                dp.setNgayDat(ngayDat);
                dp.setNgayNhanDuKien(ngayNhanDuKien);
                dp.setNgayTraDuKien(ngayTraDuKien);
                dp.setTrangThai(rs.getString("TrangThai"));
                dp.setGhiChu(rs.getString("GhiChu"));
                dp.setGiaPhongTaiThoiDiemDat(rs.getBigDecimal("GiaPhongTaiThoiDiemDat"));

                dp.setTenKhachHang(rs.getString("TenKhachHang"));
                dp.setCccd(rs.getString("CCCD"));
                dp.setSdtKhachHang(rs.getString("SDTKhachHang"));
                dp.setEmailKhachHang(rs.getString("Email"));
                dp.setDiaChiKhachHang(rs.getString("DiaChi"));

                dp.setSoPhong(rs.getInt("SoPhong"));
                dp.setTenLoaiPhong(rs.getString("TenLoaiPhong"));
                dp.setSoNguoiToiDa(rs.getInt("SoNguoiToiDa"));
                dp.setGiaCoBan(rs.getDouble("GiaCoBan"));
                dp.setMoTaLoaiPhong(rs.getString("MoTa"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dp;
    }
    public BookingDTO getBookingDTOByIDForCheckIn(int id){
        BookingDTO dp = new BookingDTO();
        String sql = "SELECT dp.MaDatPhong, dp.MaKH, dp.MaPhong, dp.NgayDat, dp.NgayNhanDuKien, dp.NgayTraDuKien, " +
                 "dp.TrangThai, dp.GhiChu, dp.GiaPhongTaiThoiDiemDat, " +
                 "kh.HoTen AS TenKhachHang, kh.CCCD, kh.SDT AS SDTKhachHang, kh.Email, kh.DiaChi, " +
                 "p.SoPhong, lp.TenLoaiPhong, lp.SoNguoiToiDa, lp.GiaCoBan, lp.MoTa " +
                 "FROM DatPhong dp " +
                 "JOIN KhachHang kh ON dp.MaKH = kh.MaKH " +
                 "JOIN Phong p ON dp.MaPhong = p.MaPhong " +
                 "JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong " +
                 "WHERE dp.MaDatPhong = ? AND dp.TrangThai = 'DaDat'";
        try(Connection conn = new DBConnection().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                dp.setMaDatPhong(rs.getInt("MaDatPhong"));
                dp.setMaKH(rs.getInt("MaKH"));
                dp.setMaPhong(rs.getInt("MaPhong"));
                LocalDateTime ngayDat = rs.getTimestamp("NgayDat").toLocalDateTime();
                LocalDateTime ngayNhanDuKien = rs.getTimestamp("NgayNhanDuKien").toLocalDateTime();
                LocalDateTime ngayTraDuKien = rs.getTimestamp("NgayTraDuKien").toLocalDateTime();
                dp.setNgayDat(ngayDat);
                dp.setNgayNhanDuKien(ngayNhanDuKien);
                dp.setNgayTraDuKien(ngayTraDuKien);
                dp.setTrangThai(rs.getString("TrangThai"));
                dp.setGhiChu(rs.getString("GhiChu"));
                dp.setGiaPhongTaiThoiDiemDat(rs.getBigDecimal("GiaPhongTaiThoiDiemDat"));

                dp.setTenKhachHang(rs.getString("TenKhachHang"));
                dp.setCccd(rs.getString("CCCD"));
                dp.setSdtKhachHang(rs.getString("SDTKhachHang"));
                dp.setEmailKhachHang(rs.getString("Email"));
                dp.setDiaChiKhachHang(rs.getString("DiaChi"));

                dp.setSoPhong(rs.getInt("SoPhong"));
                dp.setTenLoaiPhong(rs.getString("TenLoaiPhong"));
                dp.setSoNguoiToiDa(rs.getInt("SoNguoiToiDa"));
                dp.setGiaCoBan(rs.getDouble("GiaCoBan"));
                dp.setMoTaLoaiPhong(rs.getString("MoTa"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dp;
    }
    public BookingDTO getBookingDTOByIDForCheckOut(int id){
        BookingDTO dp = new BookingDTO();
        String sql = "SELECT dp.MaDatPhong, dp.MaKH, dp.MaPhong, dp.NgayDat, dp.NgayNhanDuKien, dp.NgayTraDuKien, " +
                 "dp.TrangThai, dp.GhiChu, dp.GiaPhongTaiThoiDiemDat, " +
                 "kh.HoTen AS TenKhachHang, kh.CCCD, kh.SDT AS SDTKhachHang, kh.Email, kh.DiaChi, " +
                 "p.SoPhong, lp.TenLoaiPhong, lp.SoNguoiToiDa, lp.GiaCoBan, lp.MoTa " +
                 "FROM DatPhong dp " +
                 "JOIN KhachHang kh ON dp.MaKH = kh.MaKH " +
                 "JOIN Phong p ON dp.MaPhong = p.MaPhong " +
                 "JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong " +
                 "WHERE dp.MaDatPhong = ? AND dp.TrangThai = 'DaNhanPhong'";
        try(Connection conn = new DBConnection().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                dp.setMaDatPhong(rs.getInt("MaDatPhong"));
                dp.setMaKH(rs.getInt("MaKH"));
                dp.setMaPhong(rs.getInt("MaPhong"));
                LocalDateTime ngayDat = rs.getTimestamp("NgayDat").toLocalDateTime();
                LocalDateTime ngayNhanDuKien = rs.getTimestamp("NgayNhanDuKien").toLocalDateTime();
                LocalDateTime ngayTraDuKien = rs.getTimestamp("NgayTraDuKien").toLocalDateTime();
                dp.setNgayDat(ngayDat);
                dp.setNgayNhanDuKien(ngayNhanDuKien);
                dp.setNgayTraDuKien(ngayTraDuKien);
                dp.setTrangThai(rs.getString("TrangThai"));
                dp.setGhiChu(rs.getString("GhiChu"));
                dp.setGiaPhongTaiThoiDiemDat(rs.getBigDecimal("GiaPhongTaiThoiDiemDat"));

                dp.setTenKhachHang(rs.getString("TenKhachHang"));
                dp.setCccd(rs.getString("CCCD"));
                dp.setSdtKhachHang(rs.getString("SDTKhachHang"));
                dp.setEmailKhachHang(rs.getString("Email"));
                dp.setDiaChiKhachHang(rs.getString("DiaChi"));

                dp.setSoPhong(rs.getInt("SoPhong"));
                dp.setTenLoaiPhong(rs.getString("TenLoaiPhong"));
                dp.setSoNguoiToiDa(rs.getInt("SoNguoiToiDa"));
                dp.setGiaCoBan(rs.getDouble("GiaCoBan"));
                dp.setMoTaLoaiPhong(rs.getString("MoTa"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dp;
    }
    
    public boolean updateTrangThaiDatPhong(int maDatPhong, String trangThai, int maNV) {
        String sql = "UPDATE DatPhong SET TrangThai = ?, MaNV = ? " +
                     "WHERE MaDatPhong = ? AND TrangThai = 'ChoXacNhan'";

        try {
            Connection con = new DBConnection().getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, trangThai);
            ps.setInt(2, maNV);
            ps.setInt(3, maDatPhong);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
     public boolean checkInBooking(int maDatPhong, int maPhong, int maNV) {
        Connection conn = null;
        try {
            conn = new DBConnection().getConnection();
            conn.setAutoCommit(false);

            String sql1 = "UPDATE DatPhong " +
                          "SET TrangThai = 'DaNhanPhong', MaNV = ? " +
                          "WHERE MaDatPhong = ? AND TrangThai = 'DaDat'";
            PreparedStatement ps1 = conn.prepareStatement(sql1);
            ps1.setInt(1, maNV);
            ps1.setInt(2, maDatPhong);
            int row1 = ps1.executeUpdate();

            String sql2 = "UPDATE Phong " +
                          "SET TrangThai = 'DangO' " +
                          "WHERE MaPhong = ?";
            PreparedStatement ps2 = conn.prepareStatement(sql2);
            ps2.setInt(1, maPhong);
            int row2 = ps2.executeUpdate();

            if (row1 > 0 && row2 > 0) {
                conn.commit();
                return true;
            } else {
                conn.rollback();
            }

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public boolean cancelBookingForCheckIn(int maDatPhong, int maNV) {
        String sql = "UPDATE DatPhong " +
                     "SET TrangThai = 'DaHuy', MaNV = ? " +
                     "WHERE MaDatPhong = ? AND TrangThai = 'DaDat'";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maNV);
            ps.setInt(2, maDatPhong);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
