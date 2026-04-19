package com.mycompany.laptrinhweb.model.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class PaymentViewDTO {
    private int maHoaDon;
    private int maDatPhong;

    private Timestamp ngayDat;
    private Timestamp ngayNhanDuKien;
    private Timestamp ngayTraDuKien;
    private Timestamp ngayTraThucTe;

    private String tenKhachHang;
    private String cccd;
    private String sdtKhachHang;
    private String emailKhachHang;
    private String diaChiKhachHang;

    private int soPhong;
    private String tenLoaiPhong;

    private double tongTienPhong;
    private double tongTienDV;
    private double tongThanhToan;

    private String trangThaiThanhToan;

    private String formatTime(Timestamp ts) {
        if (ts == null) return "";
        return new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(ts);
    }

    public int getMaHoaDon() {
        return maHoaDon;
    }

    public void setMaHoaDon(int maHoaDon) {
        this.maHoaDon = maHoaDon;
    }

    public int getMaDatPhong() {
        return maDatPhong;
    }

    public void setMaDatPhong(int maDatPhong) {
        this.maDatPhong = maDatPhong;
    }

    public Timestamp getNgayDatRaw() {
        return ngayDat;
    }

    public void setNgayDat(Timestamp ngayDat) {
        this.ngayDat = ngayDat;
    }

    public String getNgayDat() {
        return formatTime(ngayDat);
    }

    public Timestamp getNgayNhanDuKienRaw() {
        return ngayNhanDuKien;
    }

    public void setNgayNhanDuKien(Timestamp ngayNhanDuKien) {
        this.ngayNhanDuKien = ngayNhanDuKien;
    }

    public String getNgayNhanDuKien() {
        return formatTime(ngayNhanDuKien);
    }

    public Timestamp getNgayTraDuKienRaw() {
        return ngayTraDuKien;
    }

    public void setNgayTraDuKien(Timestamp ngayTraDuKien) {
        this.ngayTraDuKien = ngayTraDuKien;
    }

    public String getNgayTraDuKien() {
        return formatTime(ngayTraDuKien);
    }

    public Timestamp getNgayTraThucTeRaw() {
        return ngayTraThucTe;
    }

    public void setNgayTraThucTe(Timestamp ngayTraThucTe) {
        this.ngayTraThucTe = ngayTraThucTe;
    }

    public String getNgayTraThucTe() {
        return formatTime(ngayTraThucTe);
    }

    public String getTenKhachHang() {
        return tenKhachHang;
    }

    public void setTenKhachHang(String tenKhachHang) {
        this.tenKhachHang = tenKhachHang;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public String getSdtKhachHang() {
        return sdtKhachHang;
    }

    public void setSdtKhachHang(String sdtKhachHang) {
        this.sdtKhachHang = sdtKhachHang;
    }

    public String getEmailKhachHang() {
        return emailKhachHang;
    }

    public void setEmailKhachHang(String emailKhachHang) {
        this.emailKhachHang = emailKhachHang;
    }

    public String getDiaChiKhachHang() {
        return diaChiKhachHang;
    }

    public void setDiaChiKhachHang(String diaChiKhachHang) {
        this.diaChiKhachHang = diaChiKhachHang;
    }

    public int getSoPhong() {
        return soPhong;
    }

    public void setSoPhong(int soPhong) {
        this.soPhong = soPhong;
    }

    public String getTenLoaiPhong() {
        return tenLoaiPhong;
    }

    public void setTenLoaiPhong(String tenLoaiPhong) {
        this.tenLoaiPhong = tenLoaiPhong;
    }

    public double getTongTienPhong() {
        return tongTienPhong;
    }

    public void setTongTienPhong(double tongTienPhong) {
        this.tongTienPhong = tongTienPhong;
    }

    public double getTongTienDV() {
        return tongTienDV;
    }

    public void setTongTienDV(double tongTienDV) {
        this.tongTienDV = tongTienDV;
    }

    public double getTongThanhToan() {
        return tongThanhToan;
    }

    public void setTongThanhToan(double tongThanhToan) {
        this.tongThanhToan = tongThanhToan;
    }

    public String getTrangThaiThanhToan() {
        return trangThaiThanhToan;
    }

    public void setTrangThaiThanhToan(String trangThaiThanhToan) {
        this.trangThaiThanhToan = trangThaiThanhToan;
    }
}