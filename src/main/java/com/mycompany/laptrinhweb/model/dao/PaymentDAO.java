package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import com.mycompany.laptrinhweb.model.dto.PaymentViewDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    public List<PaymentViewDTO> listCompletedInvoices() {
        List<PaymentViewDTO> list = new ArrayList<>();

        String sql = "SELECT hd.MaHoaDon, dp.MaDatPhong, kh.HoTen AS TenKhachHang, kh.CCCD, kh.SDT AS SdtKhachHang, "
                + "p.SoPhong, hd.TongTienPhong, hd.TongTienDV, hd.TongThanhToan, "
                + "CASE WHEN EXISTS (SELECT 1 FROM ThanhToan tt WHERE tt.MaHoaDon = hd.MaHoaDon AND tt.TrangThai = 'DaThanhToan') "
                + "THEN 'DaThanhToan' ELSE 'ChuaThanhToan' END AS TrangThaiThanhToan "
                + "FROM HoaDon hd "
                + "JOIN DatPhong dp ON hd.MaDatPhong = dp.MaDatPhong "
                + "JOIN KhachHang kh ON dp.MaKH = kh.MaKH "
                + "JOIN Phong p ON dp.MaPhong = p.MaPhong "
                + "WHERE dp.TrangThai = 'HoanThanh' "
                + "ORDER BY hd.MaHoaDon DESC";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PaymentViewDTO dto = new PaymentViewDTO();
                dto.setMaHoaDon(rs.getInt("MaHoaDon"));
                dto.setMaDatPhong(rs.getInt("MaDatPhong"));
                dto.setTenKhachHang(rs.getString("TenKhachHang"));
                dto.setCccd(rs.getString("CCCD"));
                dto.setSdtKhachHang(rs.getString("SdtKhachHang"));
                dto.setSoPhong(rs.getInt("SoPhong"));
                dto.setTongTienPhong(rs.getDouble("TongTienPhong"));
                dto.setTongTienDV(rs.getDouble("TongTienDV"));
                dto.setTongThanhToan(rs.getDouble("TongThanhToan"));
                dto.setTrangThaiThanhToan(rs.getString("TrangThaiThanhToan"));
                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<PaymentViewDTO> searchCompletedInvoices(String customerInformation) {
        List<PaymentViewDTO> list = new ArrayList<>();

        String sql = "SELECT hd.MaHoaDon, dp.MaDatPhong, kh.HoTen AS TenKhachHang, kh.CCCD, kh.SDT AS SdtKhachHang, "
                + "p.SoPhong, hd.TongTienPhong, hd.TongTienDV, hd.TongThanhToan, "
                + "CASE WHEN EXISTS (SELECT 1 FROM ThanhToan tt WHERE tt.MaHoaDon = hd.MaHoaDon AND tt.TrangThai = 'DaThanhToan') "
                + "THEN 'DaThanhToan' ELSE 'ChuaThanhToan' END AS TrangThaiThanhToan "
                + "FROM HoaDon hd "
                + "JOIN DatPhong dp ON hd.MaDatPhong = dp.MaDatPhong "
                + "JOIN KhachHang kh ON dp.MaKH = kh.MaKH "
                + "JOIN Phong p ON dp.MaPhong = p.MaPhong "
                + "WHERE dp.TrangThai = 'HoanThanh' "
                + "AND (kh.SDT LIKE ? OR kh.CCCD LIKE ?) "
                + "ORDER BY hd.MaHoaDon DESC";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String value = "%" + customerInformation + "%";
            ps.setString(1, value);
            ps.setString(2, value);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PaymentViewDTO dto = new PaymentViewDTO();
                    dto.setMaHoaDon(rs.getInt("MaHoaDon"));
                    dto.setMaDatPhong(rs.getInt("MaDatPhong"));
                    dto.setTenKhachHang(rs.getString("TenKhachHang"));
                    dto.setCccd(rs.getString("CCCD"));
                    dto.setSdtKhachHang(rs.getString("SdtKhachHang"));
                    dto.setSoPhong(rs.getInt("SoPhong"));
                    dto.setTongTienPhong(rs.getDouble("TongTienPhong"));
                    dto.setTongTienDV(rs.getDouble("TongTienDV"));
                    dto.setTongThanhToan(rs.getDouble("TongThanhToan"));
                    dto.setTrangThaiThanhToan(rs.getString("TrangThaiThanhToan"));
                    list.add(dto);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public PaymentViewDTO getPaymentDetailByInvoiceId(int maHoaDon) {
        PaymentViewDTO dto = null;

        String sql = "SELECT hd.MaHoaDon, dp.MaDatPhong, dp.NgayDat, dp.NgayNhanDuKien, dp.NgayTraDuKien, dp.NgayTraThucTe, "
                + "kh.HoTen AS TenKhachHang, kh.CCCD, kh.SDT AS SdtKhachHang, kh.Email, kh.DiaChi, "
                + "p.SoPhong, lp.TenLoaiPhong, "
                + "hd.TongTienPhong, hd.TongTienDV, hd.TongThanhToan, "
                + "CASE WHEN EXISTS (SELECT 1 FROM ThanhToan tt WHERE tt.MaHoaDon = hd.MaHoaDon AND tt.TrangThai = 'DaThanhToan') "
                + "THEN 'DaThanhToan' ELSE 'ChuaThanhToan' END AS TrangThaiThanhToan "
                + "FROM HoaDon hd "
                + "JOIN DatPhong dp ON hd.MaDatPhong = dp.MaDatPhong "
                + "JOIN KhachHang kh ON dp.MaKH = kh.MaKH "
                + "JOIN Phong p ON dp.MaPhong = p.MaPhong "
                + "JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong "
                + "WHERE hd.MaHoaDon = ?";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maHoaDon);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    dto = new PaymentViewDTO();
                    dto.setMaHoaDon(rs.getInt("MaHoaDon"));
                    dto.setMaDatPhong(rs.getInt("MaDatPhong"));
                    dto.setNgayDat(rs.getTimestamp("NgayDat"));
                    dto.setNgayNhanDuKien(rs.getTimestamp("NgayNhanDuKien"));
                    dto.setNgayTraDuKien(rs.getTimestamp("NgayTraDuKien"));
                    dto.setNgayTraThucTe(rs.getTimestamp("NgayTraThucTe"));

                    dto.setTenKhachHang(rs.getString("TenKhachHang"));
                    dto.setCccd(rs.getString("CCCD"));
                    dto.setSdtKhachHang(rs.getString("SdtKhachHang"));
                    dto.setEmailKhachHang(rs.getString("Email"));
                    dto.setDiaChiKhachHang(rs.getString("DiaChi"));

                    dto.setSoPhong(rs.getInt("SoPhong"));
                    dto.setTenLoaiPhong(rs.getString("TenLoaiPhong"));

                    dto.setTongTienPhong(rs.getDouble("TongTienPhong"));
                    dto.setTongTienDV(rs.getDouble("TongTienDV"));
                    dto.setTongThanhToan(rs.getDouble("TongThanhToan"));
                    dto.setTrangThaiThanhToan(rs.getString("TrangThaiThanhToan"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return dto;
    }

    public boolean processPayment(int maHoaDon, int maNV) {
        String checkSql = "SELECT COUNT(*) AS Total "
                + "FROM ThanhToan "
                + "WHERE MaHoaDon = ? AND TrangThai = 'DaThanhToan'";

        String getInvoiceSql = "SELECT TongThanhToan FROM HoaDon WHERE MaHoaDon = ?";

        String insertSql = "INSERT INTO ThanhToan(MaHoaDon, SoTien, PhuongThuc, TrangThai, MaNV) "
                + "VALUES (?, ?, 'TienMat', 'DaThanhToan', ?)";

        try (Connection conn = new DBConnection().getConnection()) {

            try (PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
                psCheck.setInt(1, maHoaDon);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next() && rs.getInt("Total") > 0) {
                        return false;
                    }
                }
            }

            double tongThanhToan = 0;
            try (PreparedStatement psInvoice = conn.prepareStatement(getInvoiceSql)) {
                psInvoice.setInt(1, maHoaDon);
                try (ResultSet rs = psInvoice.executeQuery()) {
                    if (rs.next()) {
                        tongThanhToan = rs.getDouble("TongThanhToan");
                    } else {
                        return false;
                    }
                }
            }

            try (PreparedStatement psInsert = conn.prepareStatement(insertSql)) {
                psInsert.setInt(1, maHoaDon);
                psInsert.setDouble(2, tongThanhToan);
                psInsert.setInt(3, maNV);

                return psInsert.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}