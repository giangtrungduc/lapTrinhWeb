package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import com.mycompany.laptrinhweb.model.dto.RoomDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    /**
     * Lấy danh sách các phòng đang Trống (TrangThai = 'Trong'),
     * JOIN với LoaiPhong để lấy tên loại phòng, giá, số người tối đa.
     */
    public List<RoomDTO> listPhongTrong() {
        List<RoomDTO> list = new ArrayList<>();
        DBConnection db = new DBConnection();
        try (Connection conn = db.getConnection()) {
            String sql = "SELECT p.MaPhong, p.SoPhong, p.MaLoaiPhong, p.TrangThai, "
                       + "lp.TenLoaiPhong, lp.GiaCoBan, lp.SoNguoiToiDa "
                       + "FROM Phong p "
                       + "JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong "
                       + "WHERE p.TrangThai = 'Trong' "
                       + "ORDER BY p.SoPhong";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RoomDTO dto = new RoomDTO();
                dto.setMaPhong(rs.getInt("MaPhong"));
                dto.setSoPhong(rs.getInt("SoPhong"));
                dto.setMaLoaiPhong(rs.getInt("MaLoaiPhong"));
                dto.setTrangThai(rs.getString("TrangThai"));
                dto.setTenLoaiPhong(rs.getString("TenLoaiPhong"));
                dto.setGiaCoBan(rs.getDouble("GiaCoBan"));
                dto.setSoNguoiToiDa(rs.getInt("SoNguoiToiDa"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Cập nhật trạng thái phòng (ví dụ: 'Trong' -> 'DaDat').
     */
    public boolean updateTrangThai(int maPhong, String trangThai) {
        DBConnection db = new DBConnection();
        try (Connection conn = db.getConnection()) {
            String sql = "UPDATE Phong SET TrangThai = ? WHERE MaPhong = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, trangThai);
            ps.setInt(2, maPhong);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Thêm bản ghi đặt phòng vào bảng DatPhong.
     * Trả về true nếu thành công.
     */
    public boolean datPhong(int maKH, int maPhong, int maNV, String ngayNhan, String ngayTra, String ghiChu) {
        DBConnection db = new DBConnection();
        try (Connection conn = db.getConnection()) {
            // Lấy giá phòng tại thời điểm đặt
            double giaPhong = 0;
            String sqlGia = "SELECT lp.GiaCoBan FROM Phong p "
                          + "JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong "
                          + "WHERE p.MaPhong = ?";
            PreparedStatement psGia = conn.prepareStatement(sqlGia);
            psGia.setInt(1, maPhong);
            ResultSet rsGia = psGia.executeQuery();
            if (rsGia.next()) {
                giaPhong = rsGia.getDouble("GiaCoBan");
            }

            // Insert vào DatPhong (đầy đủ cột MaNV và GiaPhongTaiThoiDiemDat)
            String sql = "INSERT INTO DatPhong (MaKH, MaPhong, MaNV, GiaPhongTaiThoiDiemDat, "
                       + "NgayNhanDuKien, NgayTraDuKien, TrangThai, GhiChu) "
                       + "VALUES (?, ?, ?, ?, ?, ?, 'DaDat', ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, maKH);
            ps.setInt(2, maPhong);
            ps.setInt(3, maNV);
            ps.setDouble(4, giaPhong);
            ps.setString(5, ngayNhan);
            ps.setString(6, ngayTra);
            ps.setString(7, ghiChu);
            int rows = ps.executeUpdate();

            if (rows > 0) {
                // Cập nhật trạng thái phòng sang 'DaDat'
                updateTrangThai(maPhong, "DaDat");
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
