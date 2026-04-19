/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import com.mycompany.laptrinhweb.model.dto.BookingDTO;
import com.mycompany.laptrinhweb.model.dto.ServiceDTO;
import com.mycompany.laptrinhweb.model.dto.UsedServiceDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author giang
 */
public class ServiceForEmployeeDAO {
    public List<BookingDTO> listCheckedInBookings() {
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

    public List<BookingDTO> searchCheckedInBookings(String customerInformation) {
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

    public List<ServiceDTO> getAllServices() {
        List<ServiceDTO> list = new ArrayList<>();
        String sql = "SELECT MaDV, TenDV, DonGia, MoTa "
                + "FROM DichVu "
                + "ORDER BY TenDV ASC";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ServiceDTO dto = new ServiceDTO();
                dto.setMaDV(rs.getInt("MaDV"));
                dto.setTenDV(rs.getString("TenDV"));
                dto.setDonGia(rs.getBigDecimal("DonGia"));
                dto.setMoTa(rs.getString("MoTa"));
                list.add(dto);
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

    public boolean addServiceToBooking(int maDatPhong, int maDV, int soLuong) {
        if (soLuong <= 0) {
            return false;
        }

        String checkBookingSql = "SELECT MaDatPhong "
                + "FROM DatPhong "
                + "WHERE MaDatPhong = ? AND TrangThai = 'DaNhanPhong'";

        String checkExistSql = "SELECT MaSDDV, SoLuong "
                + "FROM SuDungDichVu "
                + "WHERE MaDatPhong = ? AND MaDV = ?";

        String updateSql = "UPDATE SuDungDichVu "
                + "SET SoLuong = SoLuong + ? "
                + "WHERE MaSDDV = ?";

        String insertSql = "INSERT INTO SuDungDichVu (MaDatPhong, MaDV, SoLuong, DonGia, ThoiGianSuDung) "
                + "SELECT ?, MaDV, ?, DonGia, CURRENT_TIMESTAMP "
                + "FROM DichVu "
                + "WHERE MaDV = ?";

        try (Connection conn = new DBConnection().getConnection()) {
            conn.setAutoCommit(false);

            try (
                PreparedStatement psCheckBooking = conn.prepareStatement(checkBookingSql);
                PreparedStatement psCheckExist = conn.prepareStatement(checkExistSql);
                PreparedStatement psUpdate = conn.prepareStatement(updateSql);
                PreparedStatement psInsert = conn.prepareStatement(insertSql)
            ) {
                psCheckBooking.setInt(1, maDatPhong);
                try (ResultSet rsBooking = psCheckBooking.executeQuery()) {
                    if (!rsBooking.next()) {
                        conn.rollback();
                        return false;
                    }
                }

                psCheckExist.setInt(1, maDatPhong);
                psCheckExist.setInt(2, maDV);

                try (ResultSet rs = psCheckExist.executeQuery()) {
                    if (rs.next()) {
                        int maSDDV = rs.getInt("MaSDDV");

                        psUpdate.setInt(1, soLuong);
                        psUpdate.setInt(2, maSDDV);

                        int updated = psUpdate.executeUpdate();
                        if (updated > 0) {
                            conn.commit();
                            return true;
                        } else {
                            conn.rollback();
                            return false;
                        }
                    } else {
                        psInsert.setInt(1, maDatPhong);
                        psInsert.setInt(2, soLuong);
                        psInsert.setInt(3, maDV);

                        int inserted = psInsert.executeUpdate();
                        if (inserted > 0) {
                            conn.commit();
                            return true;
                        } else {
                            conn.rollback();
                            return false;
                        }
                    }
                }

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

    public boolean deleteUsedService(int maSDDV) {
        String sql = "DELETE FROM SuDungDichVu WHERE MaSDDV = ?";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maSDDV);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
