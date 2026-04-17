
package com.mycompany.laptrinhweb.model.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class RoomBookingStatusDTO {
    int maDatPhong,maKhachHang,maPhong,soPhong,maNhanVien;
    LocalDateTime ngayDat,ngayNhanDuKien,NgayTraDuKien;
    String trangThai;
    BigDecimal giaPhong;

    public BigDecimal getGiaPhong() {
        return giaPhong;
    }

    public void setGiaPhong(BigDecimal giaPhong) {
        this.giaPhong = giaPhong;
    }

    public int getMaDatPhong() {
        return maDatPhong;
    }

    public void setMaDatPhong(int maDatPhong) {
        this.maDatPhong = maDatPhong;
    }

    public int getMaKhachHang() {
        return maKhachHang;
    }

    public void setMaKhachHang(int maKhachHang) {
        this.maKhachHang = maKhachHang;
    }

    public int getMaPhong() {
        return maPhong;
    }

    public void setMaPhong(int maPhong) {
        this.maPhong = maPhong;
    }

    public int getSoPhong() {
        return soPhong;
    }

    public void setSoPhong(int soPhong) {
        this.soPhong = soPhong;
    }

    public int getMaNhanVien() {
        return maNhanVien;
    }

    public void setMaNhanVien(int maNhanVien) {
        this.maNhanVien = maNhanVien;
    }

    public LocalDateTime getNgayDat() {
        return ngayDat;
    }

    public void setNgayDat(LocalDateTime ngayDat) {
        this.ngayDat = ngayDat;
    }

    public LocalDateTime getNgayNhanDuKien() {
        return ngayNhanDuKien;
    }

    public void setNgayNhanDuKien(LocalDateTime ngayNhanDuKien) {
        this.ngayNhanDuKien = ngayNhanDuKien;
    }

    public LocalDateTime getNgayTraDuKien() {
        return NgayTraDuKien;
    }

    public void setNgayTraDuKien(LocalDateTime NgayTraDuKien) {
        this.NgayTraDuKien = NgayTraDuKien;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
    
}
