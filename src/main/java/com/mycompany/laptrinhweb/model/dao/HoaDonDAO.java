package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class HoaDonDAO {

    /**
     * Chức năng 1: Tạo Hóa Đơn
     * Trả về MaHoaDon (ID) vừa được tạo trong database. Nếu thất bại trả về -1.
     */
    public int taoHoaDon(int maDatPhong, double tongTienPhong, double tongTienDV) {
        DBConnection db = new DBConnection();

        // NgayLap và TongThanhToan tự động sinh ra trong MySQL nên không cần Insert
        String sql = "INSERT INTO HoaDon (MaDatPhong, TongTienPhong, TongTienDV) VALUES (?, ?, ?)";

        try (Connection conn = db.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, maDatPhong);
            ps.setDouble(2, tongTienPhong);
            ps.setDouble(3, tongTienDV);

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                // Lấy ra khóa chính tự sinh (MaHoaDon)
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * Chức năng 2: Thanh Toán
     * Trả về true nếu thành công, false nếu thất bại.
     * Lưu ý cho phuongThuc: Chỉ nhận 'TienMat', 'ChuyenKhoan', 'The', 'ViDienTu'
     * Lưu ý cho trangThai: Chỉ nhận 'ChuaThanhToan', 'DaThanhToan', 'ThatBai',
     * 'HoanTien'
     */
    public boolean thanhToan(int maHoaDon, double soTien, String phuongThuc, String trangThai) {
        DBConnection db = new DBConnection();

        // NgayThanhToan tự động lấy CURRENT_TIMESTAMP nên không cần Insert
        String sql = "INSERT INTO ThanhToan (MaHoaDon, SoTien, PhuongThuc, TrangThai) VALUES (?, ?, ?, ?)";

        try (Connection conn = db.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maHoaDon);
            ps.setDouble(2, soTien);
            ps.setString(3, phuongThuc);
            ps.setString(4, trangThai);

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
