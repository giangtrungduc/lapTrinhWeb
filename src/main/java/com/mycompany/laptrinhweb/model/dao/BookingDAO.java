package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class BookingDAO {
    public boolean bookRoom(int maKH, int maPhong, String ngayNhan, String ngayTra, String ghiChu) {
        String checkBaoTriSql = "SELECT TrangThai FROM phong WHERE MaPhong = ?";
        String checkAvailableSql = "SELECT COUNT(*) FROM datphong WHERE MaPhong = ? AND TrangThai IN ('DaDat', 'DaNhanPhong') AND (NgayNhanDuKien < ? AND NgayTraDuKien > ?)";
        String insertBookingSql = "INSERT INTO datphong (MaKH, MaPhong, NgayNhanDuKien, NgayTraDuKien, TrangThai, GhiChu) VALUES (?, ?, ?, ?, 'DaDat', ?)";
        
        Connection conn = null;
        try {
            conn = new DBConnection().getConnection();
            conn.setAutoCommit(false); // Begin transaction

            // 0. Kiểm tra phòng có đang bị bảo trì không
            try (PreparedStatement psBaoTri = conn.prepareStatement(checkBaoTriSql)) {
                psBaoTri.setInt(1, maPhong);
                try (java.sql.ResultSet rsBaoTri = psBaoTri.executeQuery()) {
                    if (rsBaoTri.next() && "BaoTri".equals(rsBaoTri.getString("TrangThai"))) {
                        return false; // Phòng đang bảo trì, không thể đặt
                    }
                }
            }

            // 1. Kiểm tra lịch trùng (có phòng nào đang đặt trong khoảng thời gian này không?)
            try (PreparedStatement psCheck = conn.prepareStatement(checkAvailableSql)) {
                psCheck.setInt(1, maPhong);
                psCheck.setString(2, ngayTra + " 00:00:00");
                psCheck.setString(3, ngayNhan + " 00:00:00");
                
                try (java.sql.ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        return false; // Trùng lịch, không thể báo thành công
                    }
                }
            }

            // 2. Nếu không trùng, tiến hành tạo mới Đặt Phòng (Không cập nhật bảng Phong nữa)
            try (PreparedStatement psBooking = conn.prepareStatement(insertBookingSql)) {
                
                psBooking.setInt(1, maKH);
                psBooking.setInt(2, maPhong);
                psBooking.setString(3, ngayNhan + " 00:00:00");
                psBooking.setString(4, ngayTra + " 00:00:00");
                psBooking.setString(5, ghiChu);
                psBooking.executeUpdate();

                conn.commit(); 
                return true;
            } catch (Exception ex) {
                conn.rollback(); 
                ex.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (Exception ex) {}
            }
        }
        return false;
    }
}
