package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import com.mycompany.laptrinhweb.model.dto.RoomDTO;
import com.mycompany.laptrinhweb.model.dto.RoomStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    // --- PHẦN 1: CÁC PHƯƠNG THỨC LIÊU QUAN ĐẾN DANH SÁCH VÀ CRUD (Từ nhánh HEAD) ---

    public List<RoomDTO> listRoom() {
        List<RoomDTO> list = new ArrayList<>();
        String sql = "SELECT p.*, lp.TenLoaiPhong, lp.SoNguoiToiDa, lp.GiaCoBan FROM Phong p "
                   + "JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RoomDTO room = new RoomDTO();
                room.setMaPhong(rs.getInt("MaPhong"));
                room.setSoPhong(rs.getInt("SoPhong"));
                room.setMaLoaiPhong(rs.getInt("MaLoaiPhong"));
                String statusRoom = rs.getString("TrangThai");
                room.setTrangThai(RoomStatus.fromName(statusRoom));
                room.setTenLoaiPhong(rs.getString("TenLoaiPhong"));
                room.setSoNguoiToiDa(rs.getInt("SoNguoiToiDa"));
                room.setGia(rs.getDouble("GiaCoBan"));
                list.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addRoom(RoomDTO room) {
        String sql = "INSERT INTO phong(SoPhong, MaLoaiPhong, TrangThai) VALUES (?, ?, ?)";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, room.getSoPhong());
            ps.setInt(2, room.getMaLoaiPhong());
            ps.setString(3, room.getTrangThai().name());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateRoom(RoomDTO room) {
        String sql = "UPDATE phong SET SoPhong = ?, MaLoaiPhong = ?, TrangThai = ? WHERE MaPhong = ?";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, room.getSoPhong());
            ps.setInt(2, room.getMaLoaiPhong());
            ps.setString(3, room.getTrangThai().name());
            ps.setInt(4, room.getMaPhong());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteRoom(int id) {
        String sql = "DELETE FROM phong WHERE MaPhong = ?";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // --- PHẦN 2: CÁC PHƯƠNG THỨC LOGIC ĐẶT PHÒNG (Hợp nhất từ nhánh booking) ---

    public List<RoomDTO> listPhongTrong() {
        List<RoomDTO> list = new ArrayList<>();
        String sql = "SELECT p.MaPhong, p.SoPhong, p.MaLoaiPhong, p.TrangThai, lp.TenLoaiPhong, lp.GiaCoBan, lp.SoNguoiToiDa "
                   + "FROM Phong p JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong "
                   + "WHERE p.TrangThai = 'Trong' ORDER BY p.SoPhong";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RoomDTO dto = new RoomDTO();
                dto.setMaPhong(rs.getInt("MaPhong"));
                dto.setSoPhong(rs.getInt("SoPhong"));
                dto.setMaLoaiPhong(rs.getInt("MaLoaiPhong"));
                dto.setTrangThai(RoomStatus.fromName(rs.getString("TrangThai")));
                dto.setTenLoaiPhong(rs.getString("TenLoaiPhong"));
                dto.setGia(rs.getDouble("GiaCoBan"));
                dto.setSoNguoiToiDa(rs.getInt("SoNguoiToiDa"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateTrangThai(int maPhong, String trangThai) {
        String sql = "UPDATE Phong SET TrangThai = ? WHERE MaPhong = ?";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, trangThai);
            ps.setInt(2, maPhong);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean datPhong(int maKH, int maPhong, int maNV, String ngayNhan, String ngayTra, String ghiChu) {
        try (Connection conn = new DBConnection().getConnection()) {
            // 1. Lấy giá phòng hiện tại
            double giaPhong = 0;
            String sqlGia = "SELECT lp.GiaCoBan FROM Phong p JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong WHERE p.MaPhong = ?";
            PreparedStatement psGia = conn.prepareStatement(sqlGia);
            psGia.setInt(1, maPhong);
            ResultSet rsGia = psGia.executeQuery();
            if (rsGia.next()) giaPhong = rsGia.getDouble("GiaCoBan");

            // 2. Chèn vào bảng DatPhong
            String sql = "INSERT INTO DatPhong (MaKH, MaPhong, MaNV, GiaPhongTaiThoiDiemDat, NgayNhanDuKien, NgayTraDuKien, TrangThai, GhiChu) "
                       + "VALUES (?, ?, ?, ?, ?, ?, 'DaDat', ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, maKH);
            ps.setInt(2, maPhong);
            ps.setInt(3, maNV);
            ps.setDouble(4, giaPhong);
            ps.setString(5, ngayNhan);
            ps.setString(6, ngayTra);
            ps.setString(7, ghiChu);
            
            if (ps.executeUpdate() > 0) {
                // 3. Cập nhật trạng thái phòng sang 'DaDat'
                return updateTrangThai(maPhong, "DaDat");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}