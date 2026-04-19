package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import com.mycompany.laptrinhweb.model.dto.BookingDTO;
import com.mycompany.laptrinhweb.model.dto.UsedServiceDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CheckOutDAO {

    public List<BookingDTO> listCheckedInBookingsForCheckOut() {
        List<BookingDTO> list = new ArrayList<>();
        String sql = "SELECT dp.MaDatPhong, dp.MaKH, dp.MaPhong, dp.NgayNhanDuKien, dp.NgayTraDuKien "
                + "FROM DatPhong dp "
                + "WHERE dp.TrangThai = 'DaNhanPhong' "
                + "ORDER BY dp.MaDatPhong DESC";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BookingDTO dto = new BookingDTO();
                dto.setMaDatPhong(rs.getInt("MaDatPhong"));
                dto.setMaKH(rs.getInt("MaKH"));
                dto.setMaPhong(rs.getInt("MaPhong"));
                LocalDateTime ngayNhanDuKien = rs.getTimestamp("NgayNhanDuKien").toLocalDateTime();
                LocalDateTime ngayTraDuKien = rs.getTimestamp("NgayTraDuKien").toLocalDateTime();
                dto.setNgayNhanDuKien(ngayNhanDuKien);
                dto.setNgayTraDuKien(ngayTraDuKien);
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<BookingDTO> searchCheckedInBookingsForCheckOut(String customerInformation) {
        List<BookingDTO> list = new ArrayList<>();
        String sql = "SELECT dp.MaDatPhong, dp.MaKH, dp.MaPhong, dp.NgayNhanDuKien, dp.NgayTraDuKien "
                + "FROM DatPhong dp "
                + "JOIN KhachHang kh ON dp.MaKH = kh.MaKH "
                + "WHERE dp.TrangThai = 'DaNhanPhong' "
                + "AND (kh.SDT LIKE ? OR kh.CCCD LIKE ?) "
                + "ORDER BY dp.MaDatPhong DESC";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String value = "%" + customerInformation + "%";
            ps.setString(1, value);
            ps.setString(2, value);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BookingDTO dto = new BookingDTO();
                    dto.setMaDatPhong(rs.getInt("MaDatPhong"));
                    dto.setMaKH(rs.getInt("MaKH"));
                    dto.setMaPhong(rs.getInt("MaPhong"));
                    LocalDateTime ngayNhanDuKien = rs.getTimestamp("NgayNhanDuKien").toLocalDateTime();
                    LocalDateTime ngayTraDuKien = rs.getTimestamp("NgayTraDuKien").toLocalDateTime();
                    dto.setNgayNhanDuKien(ngayNhanDuKien);
                    dto.setNgayTraDuKien(ngayTraDuKien);
                    list.add(dto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<UsedServiceDTO> getUsedServicesByBooking(int maDatPhong) {
        List<UsedServiceDTO> list = new ArrayList<>();
        String sql = "SELECT sddv.MaSDDV, sddv.MaDatPhong, sddv.MaDV, dv.TenDV, "
                + "sddv.SoLuong, sddv.DonGia, sddv.ThoiGianSuDung "
                + "FROM SuDungDichVu sddv "
                + "JOIN DichVu dv ON sddv.MaDV = dv.MaDV "
                + "WHERE sddv.MaDatPhong = ? "
                + "ORDER BY sddv.ThoiGianSuDung DESC";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maDatPhong);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UsedServiceDTO dto = new UsedServiceDTO();
                    dto.setMaSDDV(rs.getInt("MaSDDV"));
                    dto.setMaDatPhong(rs.getInt("MaDatPhong"));
                    dto.setMaDV(rs.getInt("MaDV"));
                    dto.setTenDV(rs.getString("TenDV"));
                    dto.setSoLuong(rs.getInt("SoLuong"));
                    dto.setDonGia(rs.getDouble("DonGia"));
                    dto.setThoiGianSuDung(rs.getTimestamp("ThoiGianSuDung"));
                    dto.setThanhTien(dto.getSoLuong() * dto.getDonGia());
                    list.add(dto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public double getTotalServiceAmount(int maDatPhong) {
        String sql = "SELECT COALESCE(SUM(SoLuong * DonGia), 0) AS TongTienDV "
                + "FROM SuDungDichVu WHERE MaDatPhong = ?";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maDatPhong);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("TongTienDV");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public double calculateRoomAmount(int maDatPhong) {
        String sql = "SELECT NgayNhanDuKien, GiaPhongTaiThoiDiemDat "
                + "FROM DatPhong "
                + "WHERE MaDatPhong = ? AND TrangThai = 'DaNhanPhong'";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maDatPhong);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Timestamp ngayNhan = rs.getTimestamp("NgayNhanDuKien");
                    double giaPhong = rs.getDouble("GiaPhongTaiThoiDiemDat");

                    LocalDateTime start = ngayNhan.toLocalDateTime();
                    LocalDateTime end = LocalDateTime.now();

                    long hours = Duration.between(start, end).toHours();
                    long soNgay = hours / 24;
                    if (hours % 24 != 0) {
                        soNgay++;
                    }
                    if (soNgay <= 0) {
                        soNgay = 1;
                    }

                    return soNgay * giaPhong;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public boolean processCheckOut(int maDatPhong, int maNV) {
        String getBookingSql = "SELECT dp.MaPhong, dp.NgayNhanDuKien, dp.GiaPhongTaiThoiDiemDat "
                + "FROM DatPhong dp "
                + "WHERE dp.MaDatPhong = ? AND dp.TrangThai = 'DaNhanPhong'";

        String updateBookingSql = "UPDATE DatPhong "
                + "SET NgayTraThucTe = CURRENT_TIMESTAMP, TrangThai = 'HoanThanh', MaNV = ? "
                + "WHERE MaDatPhong = ? AND TrangThai = 'DaNhanPhong'";

        String updateRoomSql = "UPDATE Phong SET TrangThai = 'Trong' WHERE MaPhong = ?";

        String checkInvoiceSql = "SELECT MaHoaDon FROM HoaDon WHERE MaDatPhong = ?";
        String insertInvoiceSql = "INSERT INTO HoaDon(MaDatPhong, TongTienPhong, TongTienDV) VALUES (?, ?, ?)";
        String updateInvoiceSql = "UPDATE HoaDon SET TongTienPhong = ?, TongTienDV = ?, NgayLap = CURRENT_TIMESTAMP "
                + "WHERE MaDatPhong = ?";

        try (Connection conn = new DBConnection().getConnection()) {
            conn.setAutoCommit(false);

            try {
                int maPhong;
                double tongTienPhong;
                double tongTienDV = 0;

                try (PreparedStatement ps = conn.prepareStatement(getBookingSql)) {
                    ps.setInt(1, maDatPhong);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            conn.rollback();
                            return false;
                        }

                        maPhong = rs.getInt("MaPhong");
                        Timestamp ngayNhan = rs.getTimestamp("NgayNhanDuKien");
                        double giaPhong = rs.getDouble("GiaPhongTaiThoiDiemDat");

                        LocalDateTime start = ngayNhan.toLocalDateTime();
                        LocalDateTime end = LocalDateTime.now();

                        long hours = Duration.between(start, end).toHours();
                        long soNgay = hours / 24;
                        if (hours % 24 != 0) {
                            soNgay++;
                        }
                        if (soNgay <= 0) {
                            soNgay = 1;
                        }

                        tongTienPhong = soNgay * giaPhong;
                    }
                }

                String totalServiceSql = "SELECT COALESCE(SUM(SoLuong * DonGia), 0) AS TongTienDV "
                        + "FROM SuDungDichVu WHERE MaDatPhong = ?";
                try (PreparedStatement ps = conn.prepareStatement(totalServiceSql)) {
                    ps.setInt(1, maDatPhong);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            tongTienDV = rs.getDouble("TongTienDV");
                        }
                    }
                }

                try (PreparedStatement ps = conn.prepareStatement(updateBookingSql)) {
                    ps.setInt(1, maNV);
                    ps.setInt(2, maDatPhong);
                    if (ps.executeUpdate() <= 0) {
                        conn.rollback();
                        return false;
                    }
                }

                try (PreparedStatement ps = conn.prepareStatement(updateRoomSql)) {
                    ps.setInt(1, maPhong);
                    ps.executeUpdate();
                }

                boolean existsInvoice = false;
                try (PreparedStatement ps = conn.prepareStatement(checkInvoiceSql)) {
                    ps.setInt(1, maDatPhong);
                    try (ResultSet rs = ps.executeQuery()) {
                        existsInvoice = rs.next();
                    }
                }

                if (existsInvoice) {
                    try (PreparedStatement ps = conn.prepareStatement(updateInvoiceSql)) {
                        ps.setDouble(1, tongTienPhong);
                        ps.setDouble(2, tongTienDV);
                        ps.setInt(3, maDatPhong);
                        ps.executeUpdate();
                    }
                } else {
                    try (PreparedStatement ps = conn.prepareStatement(insertInvoiceSql)) {
                        ps.setInt(1, maDatPhong);
                        ps.setDouble(2, tongTienPhong);
                        ps.setDouble(3, tongTienDV);
                        ps.executeUpdate();
                    }
                }

                conn.commit();
                return true;

            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
            } finally {
                conn.setAutoCommit(true);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}