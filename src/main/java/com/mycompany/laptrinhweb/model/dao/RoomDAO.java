package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import com.mycompany.laptrinhweb.model.dto.RoomBookingStatusDTO;
import com.mycompany.laptrinhweb.model.dto.RoomDTO;
import com.mycompany.laptrinhweb.model.dto.RoomStatus;
import com.mycompany.laptrinhweb.model.dto.RoomTypeDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    // ==================== PHÒNG ====================

    public List<RoomDTO> listRoom() {
        List<RoomDTO> list = new ArrayList<>();
        String sql = "SELECT p.*, lp.TenLoaiPhong, lp.SoNguoiToiDa, lp.GiaCoBan "
                   + "FROM Phong p JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RoomDTO room = new RoomDTO();
                room.setMaphong(rs.getInt("MaPhong"));
                room.setSophong(rs.getInt("SoPhong"));
                room.setMaloaiphong(rs.getInt("MaLoaiPhong"));
                room.setTrangthai(RoomStatus.fromName(rs.getString("TrangThai")));
                room.setTenloaiphong(rs.getString("TenLoaiPhong"));
                room.setSonguoitoida(rs.getInt("SoNguoiToiDa"));
                room.setGia(rs.getFloat("GiaCoBan"));
                list.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addRoom(RoomDTO room) {
        String sql = "INSERT INTO Phong(SoPhong, MaLoaiPhong, TrangThai) VALUES (?, ?, ?)";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, room.getSophong());
            ps.setInt(2, room.getMaloaiphong());
            ps.setString(3, room.getTrangthai().name());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateRoom(RoomDTO room) {
        String sql = "UPDATE Phong SET SoPhong = ?, MaLoaiPhong = ?, TrangThai = ? WHERE MaPhong = ?";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, room.getSophong());
            ps.setInt(2, room.getMaloaiphong());
            ps.setString(3, room.getTrangthai().name());
            ps.setInt(4, room.getMaphong());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Xóa mềm: chuyển trạng thái phòng về Bảo Trì thay vì xóa thật */
    public boolean setRoomBaoTri(int maPhong) {
        String sql = "UPDATE Phong SET TrangThai = 'BaoTri' WHERE MaPhong = ?";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, maPhong);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteRoom(int id) {
        String sql = "DELETE FROM Phong WHERE MaPhong = ?";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public RoomDTO getRoomById(int id) {
        String sql = "SELECT p.*, lp.TenLoaiPhong, lp.SoNguoiToiDa, lp.GiaCoBan "
                   + "FROM Phong p JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong "
                   + "WHERE p.MaPhong = ?";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                RoomDTO room = new RoomDTO();
                room.setMaphong(rs.getInt("MaPhong"));
                room.setSophong(rs.getInt("SoPhong"));
                room.setMaloaiphong(rs.getInt("MaLoaiPhong"));
                room.setTrangthai(RoomStatus.fromName(rs.getString("TrangThai")));
                room.setTenloaiphong(rs.getString("TenLoaiPhong"));
                room.setSonguoitoida(rs.getInt("SoNguoiToiDa"));
                room.setGia(rs.getFloat("GiaCoBan"));
                return room;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void setRoomAvailable(int maPhong) {
        String sql = "UPDATE Phong SET TrangThai = 'Trong' WHERE MaPhong = ?";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, maPhong);
            ps.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<RoomDTO> searchRooms(String keyword) {
        List<RoomDTO> list = new ArrayList<>();
        String sql = "SELECT p.MaPhong, p.SoPhong, p.MaLoaiPhong, p.TrangThai, "
                   + "lp.TenLoaiPhong, lp.GiaCoBan, lp.SoNguoiToiDa "
                   + "FROM Phong p JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong "
                   + "WHERE CAST(p.SoPhong AS CHAR) LIKE ? OR lp.TenLoaiPhong LIKE ?";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            String key = "%" + keyword + "%";
            ps.setString(1, key);
            ps.setString(2, key);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RoomDTO room = new RoomDTO();
                room.setMaphong(rs.getInt("MaPhong"));
                room.setSophong(rs.getInt("SoPhong"));
                room.setMaloaiphong(rs.getInt("MaLoaiPhong"));
                room.setTrangthai(RoomStatus.valueOf(rs.getString("TrangThai")));
                room.setTenloaiphong(rs.getString("TenLoaiPhong"));
                room.setGia(rs.getFloat("GiaCoBan"));
                room.setSonguoitoida(rs.getInt("SoNguoiToiDa"));
                list.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<RoomDTO> searchRoomForCustomer(int soPhong, float giaPhong, String loaiPhong, int soNguoi) {
        List<RoomDTO> listRoom = new ArrayList<>();
        String sql = "SELECT * FROM Phong p JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong "
                   + "WHERE (p.SoPhong = ? OR ? IS NULL) "
                   + "AND (lp.GiaCoBan <= ? OR ? IS NULL) "
                   + "AND (lp.SoNguoiToiDa <= ? OR ? IS NULL) "
                   + "AND (lp.TenLoaiPhong LIKE ? OR ? IS NULL)";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, soPhong);
            ps.setObject(2, soPhong == 0 ? null : soPhong);
            ps.setFloat(3, giaPhong);
            ps.setObject(4, giaPhong == 0 ? null : giaPhong);
            ps.setInt(5, soNguoi);
            ps.setObject(6, soNguoi == 0 ? null : soNguoi);
            ps.setString(7, loaiPhong == null ? null : "%" + loaiPhong + "%");
            ps.setObject(8, loaiPhong == null ? null : loaiPhong);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RoomDTO room = new RoomDTO();
                room.setMaphong(rs.getInt("MaPhong"));
                room.setSophong(rs.getInt("SoPhong"));
                room.setMaloaiphong(rs.getInt("MaLoaiPhong"));
                room.setTrangthai(RoomStatus.valueOf(rs.getString("TrangThai")));
                room.setTenloaiphong(rs.getString("TenLoaiPhong"));
                room.setGia(rs.getFloat("GiaCoBan"));
                room.setSonguoitoida(rs.getInt("SoNguoiToiDa"));
                listRoom.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listRoom;
    }

    public List<RoomBookingStatusDTO> getRoomBookingStatusByRoomId(int maPhong) {
        List<RoomBookingStatusDTO> li = new ArrayList<>();
        String sql = "SELECT * FROM DatPhong WHERE MaPhong = ? AND (TrangThai = 'DaDat' OR TrangThai = 'DaNhanPhong' OR TrangThai='ChoXacNhan')";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, maPhong);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RoomBookingStatusDTO room = new RoomBookingStatusDTO();
                room.setMaDatPhong(rs.getInt("MaDatPhong"));
                room.setMaKhachHang(rs.getInt("MaKH"));
                room.setMaPhong(rs.getInt("MaPhong"));
                room.setMaNhanVien(rs.getInt("MaNV"));
                room.setTrangThai(rs.getString("TrangThai"));
                room.setGiaPhong(rs.getBigDecimal("GiaPhongTaiThoiDiemDat"));
                Timestamp ts1 = rs.getTimestamp("NgayDat");
                if (ts1 != null) room.setNgayDat(ts1.toLocalDateTime());
                Timestamp ts2 = rs.getTimestamp("NgayNhanDuKien");
                if (ts2 != null) room.setNgayNhanDuKien(ts2.toLocalDateTime());
                Timestamp ts3 = rs.getTimestamp("NgayTraDuKien");
                if (ts3 != null) room.setNgayTraDuKien(ts3.toLocalDateTime());
                li.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return li;
    }

    // ==================== LOẠI PHÒNG ====================

    public List<RoomTypeDTO> listRoomType() {
        List<RoomTypeDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM LoaiPhong";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RoomTypeDTO rt = new RoomTypeDTO();
                rt.setMaloaiphong(rs.getInt("MaLoaiPhong"));
                rt.setTenloaiphong(rs.getString("TenLoaiPhong"));
                rt.setSonguoitoida(rs.getInt("SoNguoiToiDa"));
                rt.setGiacoban(rs.getFloat("GiaCoBan"));
                list.add(rt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addRoomType(RoomTypeDTO rt) {
        String sql = "INSERT INTO LoaiPhong(TenLoaiPhong, SoNguoiToiDa, GiaCoBan) VALUES (?, ?, ?)";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, rt.getTenloaiphong());
            ps.setInt(2, rt.getSonguoitoida());
            ps.setFloat(3, rt.getGiacoban());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateRoomType(RoomTypeDTO rt) {
        String sql = "UPDATE LoaiPhong SET TenLoaiPhong = ?, SoNguoiToiDa = ?, GiaCoBan = ? WHERE MaLoaiPhong = ?";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, rt.getTenloaiphong());
            ps.setInt(2, rt.getSonguoitoida());
            ps.setFloat(3, rt.getGiacoban());
            ps.setInt(4, rt.getMaloaiphong());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public RoomTypeDTO getRoomTypeById(int id) {
        String sql = "SELECT * FROM LoaiPhong WHERE MaLoaiPhong = ?";
        try (Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                RoomTypeDTO rt = new RoomTypeDTO();
                rt.setMaloaiphong(rs.getInt("MaLoaiPhong"));
                rt.setTenloaiphong(rs.getString("TenLoaiPhong"));
                rt.setSonguoitoida(rs.getInt("SoNguoiToiDa"));
                rt.setGiacoban(rs.getFloat("GiaCoBan"));
                return rt;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}