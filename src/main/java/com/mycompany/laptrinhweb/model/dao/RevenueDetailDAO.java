/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import com.mycompany.laptrinhweb.model.dto.RevenueDetailDTO;
import com.mycompany.laptrinhweb.model.dto.RevenueTopDetailDTO;
import com.mycompany.laptrinhweb.model.dto.TopRoomDTO;
import com.mycompany.laptrinhweb.model.dto.TopServiceDTO;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class RevenueDetailDAO {

    public BigDecimal getTongDoanhThu(String tuNgay, String denNgay, String thang, String nam) {
        BigDecimal tongDoanhThu = BigDecimal.ZERO;
        String sql = "SELECT COALESCE(SUM(h.TongThanhToan),0) AS TongDoanhThu FROM hoadon h WHERE 1=1 ";

        if (tuNgay != null && !tuNgay.isEmpty()) {
            sql += " AND DATE(h.NgayLap) >= ? ";
        }
        if (denNgay != null && !denNgay.isEmpty()) {
            sql += " AND DATE(h.NgayLap) <= ? ";
        }
        if (thang != null && !thang.isEmpty()) {
            sql += " AND MONTH(h.NgayLap) = ? ";
        }
        if (nam != null && !nam.isEmpty()) {
            sql += " AND YEAR(h.NgayLap) = ? ";
        }

        try (Connection con = new DBConnection().getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            int i = 1;

            if (tuNgay != null && !tuNgay.isEmpty()) {
                ps.setDate(i++, Date.valueOf(tuNgay));
            }
            if (denNgay != null && !denNgay.isEmpty()) {
                ps.setDate(i++, Date.valueOf(denNgay));
            }
            if (thang != null && !thang.isEmpty()) {
                ps.setInt(i++, Integer.parseInt(thang));
            }
            if (nam != null && !nam.isEmpty()) {
                ps.setInt(i++, Integer.parseInt(nam));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                tongDoanhThu = rs.getBigDecimal("TongDoanhThu") != null
                        ? rs.getBigDecimal("TongDoanhThu")
                        : BigDecimal.ZERO;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tongDoanhThu;
    }

    public BigDecimal getDoanhThuPhong(String tuNgay, String denNgay, String thang, String nam) {
        BigDecimal tongTienPhong = BigDecimal.ZERO;
        String sql = "SELECT COALESCE(SUM(h.TongTienPhong),0) AS TongTienPhong FROM hoadon h WHERE 1=1 ";

        if (tuNgay != null && !tuNgay.isEmpty()) {
            sql += " AND DATE(h.NgayLap) >= ? ";
        }
        if (denNgay != null && !denNgay.isEmpty()) {
            sql += " AND DATE(h.NgayLap) <= ? ";
        }
        if (thang != null && !thang.isEmpty()) {
            sql += " AND MONTH(h.NgayLap) = ? ";
        }
        if (nam != null && !nam.isEmpty()) {
            sql += " AND YEAR(h.NgayLap) = ? ";
        }

        try (Connection con = new DBConnection().getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            int i = 1;

            if (tuNgay != null && !tuNgay.isEmpty()) {
                ps.setDate(i++, Date.valueOf(tuNgay));
            }
            if (denNgay != null && !denNgay.isEmpty()) {
                ps.setDate(i++, Date.valueOf(denNgay));
            }
            if (thang != null && !thang.isEmpty()) {
                ps.setInt(i++, Integer.parseInt(thang));
            }
            if (nam != null && !nam.isEmpty()) {
                ps.setInt(i++, Integer.parseInt(nam));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                tongTienPhong = rs.getBigDecimal("TongTienPhong") != null
                        ? rs.getBigDecimal("TongTienPhong")
                        : BigDecimal.ZERO;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tongTienPhong;
    }

    public BigDecimal getDoanhThuDichVu(String tuNgay, String denNgay, String thang, String nam) {
        BigDecimal tongTienDV = BigDecimal.ZERO;
        String sql = "SELECT COALESCE(SUM(h.TongTienDV),0) AS TongTienDV FROM hoadon h WHERE 1=1 ";

        if (tuNgay != null && !tuNgay.isEmpty()) {
            sql += " AND DATE(h.NgayLap) >= ? ";
        }
        if (denNgay != null && !denNgay.isEmpty()) {
            sql += " AND DATE(h.NgayLap) <= ? ";
        }
        if (thang != null && !thang.isEmpty()) {
            sql += " AND MONTH(h.NgayLap) = ? ";
        }
        if (nam != null && !nam.isEmpty()) {
            sql += " AND YEAR(h.NgayLap) = ? ";
        }

        try (Connection con = new DBConnection().getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            int i = 1;

            if (tuNgay != null && !tuNgay.isEmpty()) {
                ps.setDate(i++, Date.valueOf(tuNgay));
            }
            if (denNgay != null && !denNgay.isEmpty()) {
                ps.setDate(i++, Date.valueOf(denNgay));
            }
            if (thang != null && !thang.isEmpty()) {
                ps.setInt(i++, Integer.parseInt(thang));
            }
            if (nam != null && !nam.isEmpty()) {
                ps.setInt(i++, Integer.parseInt(nam));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                tongTienDV = rs.getBigDecimal("TongTienDV") != null
                        ? rs.getBigDecimal("TongTienDV")
                        : BigDecimal.ZERO;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tongTienDV;
    }

    public List<RevenueDetailDTO> getHoaDonList(String tuNgay, String denNgay, String thang, String nam) {
        List<RevenueDetailDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM hoadon h "
                + "JOIN datphong d ON h.MaDatPhong = d.MaDatPhong "
                + "JOIN khachhang k ON k.MaKH = d.MaKH "
                + "JOIN nhanvien n ON n.MaNV = h.MaNV "
                + "WHERE 1=1 ";

        if (tuNgay != null && !tuNgay.trim().isEmpty()) {
            sql += " AND DATE(h.NgayLap) >= ? ";
        }
        if (denNgay != null && !denNgay.trim().isEmpty()) {
            sql += " AND DATE(h.NgayLap) <= ? ";
        }
        if (thang != null && !thang.trim().isEmpty()) {
            sql += " AND MONTH(h.NgayLap) = ? ";
        }
        if (nam != null && !nam.trim().isEmpty()) {
            sql += " AND YEAR(h.NgayLap) = ? ";
        }

        sql += " ORDER BY h.NgayLap DESC, h.MaHoaDon DESC ";

        try (Connection con = new DBConnection().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            int index = 1;
            if (tuNgay != null && !tuNgay.trim().isEmpty()) {
                ps.setDate(index++, Date.valueOf(tuNgay));
            }
            if (denNgay != null && !denNgay.trim().isEmpty()) {
                ps.setDate(index++, Date.valueOf(denNgay));
            }
            if (thang != null && !thang.trim().isEmpty()) {
                ps.setInt(index++, Integer.parseInt(thang));
            }
            if (nam != null && !nam.trim().isEmpty()) {
                ps.setInt(index++, Integer.parseInt(nam));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RevenueDetailDTO hd = new RevenueDetailDTO();
                    hd.setMaHoaDon(rs.getInt("MaHoaDon"));
                    hd.setMaKH(rs.getInt("MaKH"));
                    hd.setMaNV(rs.getInt("MaNV"));
                    hd.setTenKH(rs.getString("HoTen"));
                    hd.setTenNV(rs.getString("HoTen"));
                    hd.setNgayLap(rs.getTimestamp("NgayLap"));
                    hd.setTongTienPhong(rs.getBigDecimal("TongTienPhong"));
                    hd.setTongTienDV(rs.getBigDecimal("TongTienDV"));
                    hd.setTongThanhToan(rs.getBigDecimal("TongThanhToan"));
                    list.add(hd);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * Lấy top 3 phòng có doanh thu cao nhất theo tháng/năm Ghi chú: - Giả định
     * bảng phong có: MaPhong, TenPhong - Giả định bảng datphong có: MaPhong
     */
    public List<TopRoomDTO> getTop3PhongDoanhThu(String thang, String nam) {
        List<TopRoomDTO> list = new ArrayList<>();

        String sql = "SELECT p.MaPhong, p.SoPhong, COALESCE(SUM(h.TongTienPhong),0) AS DoanhThu "
                + "FROM hoadon h "
                + "JOIN datphong d ON h.MaDatPhong = d.MaDatPhong "
                + "JOIN phong p ON d.MaPhong = p.MaPhong "
                + "WHERE 1=1 ";

        if (thang != null && !thang.trim().isEmpty()) {
            sql += " AND MONTH(h.NgayLap) = ? ";
        }
        if (nam != null && !nam.trim().isEmpty()) {
            sql += " AND YEAR(h.NgayLap) = ? ";
        }

        sql += " GROUP BY p.MaPhong, p.SoPhong "
                + " ORDER BY DoanhThu DESC "
                + " LIMIT 3";

        try (Connection con = new DBConnection().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            int index = 1;
            if (thang != null && !thang.trim().isEmpty()) {
                ps.setInt(index++, Integer.parseInt(thang));
            }
            if (nam != null && !nam.trim().isEmpty()) {
                ps.setInt(index++, Integer.parseInt(nam));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TopRoomDTO item = new TopRoomDTO();
                    item.setMaPhong(rs.getInt("MaPhong"));
                    item.setTenPhong("Phòng " + rs.getInt("SoPhong"));
                    item.setDoanhThu(rs.getBigDecimal("DoanhThu"));
                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * Lấy top 3 dịch vụ có doanh thu cao nhất theo tháng/năm Ghi chú: - Đoạn
     * này giả định có bảng chitietdichvu và dichvu - Nếu DB của bạn khác tên
     * bảng/cột thì sửa lại cho đúng
     */
    public List<TopServiceDTO> getTop3DichVuDoanhThu(String thang, String nam) {
        List<TopServiceDTO> list = new ArrayList<>();

        String sql = "SELECT dv.MaDV, dv.TenDV, COALESCE(SUM(sd.SoLuong * sd.DonGia),0) AS DoanhThu "
                + "FROM sudungdichvu sd "
                + "JOIN dichvu dv ON sd.MaDV = dv.MaDV "
                + "JOIN datphong d ON sd.MaDatPhong = d.MaDatPhong "
                + "JOIN hoadon h ON h.MaDatPhong = d.MaDatPhong "
                + "WHERE 1=1 ";

        if (thang != null && !thang.trim().isEmpty()) {
            sql += " AND MONTH(h.NgayLap) = ? ";
        }
        if (nam != null && !nam.trim().isEmpty()) {
            sql += " AND YEAR(h.NgayLap) = ? ";
        }

        sql += " GROUP BY dv.MaDV, dv.TenDV "
                + " ORDER BY DoanhThu DESC "
                + " LIMIT 3";

        try (Connection con = new DBConnection().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            int index = 1;
            if (thang != null && !thang.trim().isEmpty()) {
                ps.setInt(index++, Integer.parseInt(thang));
            }
            if (nam != null && !nam.trim().isEmpty()) {
                ps.setInt(index++, Integer.parseInt(nam));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TopServiceDTO item = new TopServiceDTO();
                    item.setMaDV(rs.getInt("MaDV"));
                    item.setTenDichVu(rs.getString("TenDV"));
                    item.setDoanhThu(rs.getBigDecimal("DoanhThu"));
                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * Lấy chi tiết 1 phòng để hiển thị ở trang chi tiết
     */
    public RevenueTopDetailDTO getChiTietPhongDoanhThu(int maPhong, String thang, String nam) {
        RevenueTopDetailDTO dto = null;

        String sql = "SELECT p.SoPhong, COALESCE(SUM(h.TongTienPhong),0) AS DoanhThu, "
                + "COUNT(h.MaHoaDon) AS SoLuong "
                + "FROM hoadon h "
                + "JOIN datphong d ON h.MaDatPhong = d.MaDatPhong "
                + "JOIN phong p ON d.MaPhong = p.MaPhong "
                + "WHERE p.MaPhong = ? ";

        if (thang != null && !thang.isEmpty()) {
            sql += " AND MONTH(h.NgayLap) = ? ";
        }
        if (nam != null && !nam.isEmpty()) {
            sql += " AND YEAR(h.NgayLap) = ? ";
        }

        sql += " GROUP BY p.SoPhong ";

        try (Connection con = new DBConnection().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            int i = 1;
            ps.setInt(i++, maPhong);

            if (thang != null && !thang.isEmpty()) {
                ps.setInt(i++, Integer.parseInt(thang));
            }
            if (nam != null && !nam.isEmpty()) {
                ps.setInt(i++, Integer.parseInt(nam));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                dto = new RevenueTopDetailDTO();
                dto.setTen("Phòng " + rs.getInt("SoPhong"));
                dto.setDoanhThu(rs.getBigDecimal("DoanhThu"));
                dto.setSoLuong(rs.getInt("SoLuong"));
                dto.setThangNam(thang + "/" + nam);
                dto.setGhiChu("Chi tiết doanh thu phòng trong tháng");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return dto;
    }

    /**
     * Lấy chi tiết 1 dịch vụ để hiển thị ở trang chi tiết Ghi chú: - Nếu
     * bảng/cột dịch vụ của bạn khác, sửa lại câu SQL
     */
    public RevenueTopDetailDTO getChiTietDichVuDoanhThu(int maDV, String thang, String nam) {
        RevenueTopDetailDTO dto = null;

        String sql = "SELECT dv.TenDV, COALESCE(SUM(sd.SoLuong * sd.DonGia),0) AS DoanhThu, "
                + "COALESCE(SUM(sd.SoLuong),0) AS SoLuong "
                + "FROM sudungdichvu sd "
                + "JOIN dichvu dv ON sd.MaDV = dv.MaDV "
                + "JOIN datphong d ON sd.MaDatPhong = d.MaDatPhong "
                + "JOIN hoadon h ON h.MaDatPhong = d.MaDatPhong "
                + "WHERE dv.MaDV = ? ";

        if (thang != null && !thang.isEmpty()) {
            sql += " AND MONTH(h.NgayLap) = ? ";
        }
        if (nam != null && !nam.isEmpty()) {
            sql += " AND YEAR(h.NgayLap) = ? ";
        }

        sql += " GROUP BY dv.TenDV ";

        try (Connection con = new DBConnection().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            int i = 1;
            ps.setInt(i++, maDV);

            if (thang != null && !thang.isEmpty()) {
                ps.setInt(i++, Integer.parseInt(thang));
            }
            if (nam != null && !nam.isEmpty()) {
                ps.setInt(i++, Integer.parseInt(nam));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                dto = new RevenueTopDetailDTO();
                dto.setTen(rs.getString("TenDV"));
                dto.setDoanhThu(rs.getBigDecimal("DoanhThu"));
                dto.setSoLuong(rs.getInt("SoLuong"));
                dto.setThangNam(thang + "/" + nam);
                dto.setGhiChu("Chi tiết doanh thu dịch vụ trong tháng");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return dto;
    }
}
