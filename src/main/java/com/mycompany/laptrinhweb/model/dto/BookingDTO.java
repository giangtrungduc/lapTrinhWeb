/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.laptrinhweb.model.dto;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;

/**
 *
 * @author giang
 */
public class BookingDTO {
    private int maDatPhong;
    private int maKH;
    private int maPhong;
    private LocalDateTime ngayDat;
    private LocalDateTime ngayNhanDuKien;
    private LocalDateTime ngayTraDuKien;
    private String trangThai;
    private String ghiChu;
    private BigDecimal giaPhongTaiThoiDiemDat;

    private String tenKhachHang;
    private String cccd;
    private String sdtKhachHang;
    private String emailKhachHang;
    private String diaChiKhachHang;

    private int soPhong;
    private String tenLoaiPhong;
    private int soNguoiToiDa;
    private double giaCoBan;
    private String moTaLoaiPhong;

    public BookingDTO() {
    }

    public BookingDTO(int maDatPhong, int maKH, int maPhong, LocalDateTime ngayDat, LocalDateTime ngayNhanDuKien, LocalDateTime ngayTraDuKien, String trangThai, String ghiChu, BigDecimal giaPhongTaiThoiDiemDat, String tenKhachHang, String cccd, String sdtKhachHang, String emailKhachHang, String diaChiKhachHang, int soPhong, String tenLoaiPhong, int soNguoiToiDa, double giaCoBan, String moTaLoaiPhong) {
        this.maDatPhong = maDatPhong;
        this.maKH = maKH;
        this.maPhong = maPhong;
        this.ngayDat = ngayDat;
        this.ngayNhanDuKien = ngayNhanDuKien;
        this.ngayTraDuKien = ngayTraDuKien;
        this.trangThai = trangThai;
        this.ghiChu = ghiChu;
        this.giaPhongTaiThoiDiemDat = giaPhongTaiThoiDiemDat;
        this.tenKhachHang = tenKhachHang;
        this.cccd = cccd;
        this.sdtKhachHang = sdtKhachHang;
        this.emailKhachHang = emailKhachHang;
        this.diaChiKhachHang = diaChiKhachHang;
        this.soPhong = soPhong;
        this.tenLoaiPhong = tenLoaiPhong;
        this.soNguoiToiDa = soNguoiToiDa;
        this.giaCoBan = giaCoBan;
        this.moTaLoaiPhong = moTaLoaiPhong;
    }
    

    public int getMaDatPhong() {
        return maDatPhong;
    }

    public void setMaDatPhong(int maDatPhong) {
        this.maDatPhong = maDatPhong;
    }

    public int getMaKH() {
        return maKH;
    }

    public void setMaKH(int maKH) {
        this.maKH = maKH;
    }

    public int getMaPhong() {
        return maPhong;
    }

    public void setMaPhong(int maPhong) {
        this.maPhong = maPhong;
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
        return ngayTraDuKien;
    }

    public void setNgayTraDuKien(LocalDateTime ngayTraDuKien) {
        this.ngayTraDuKien = ngayTraDuKien;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public String getGhiChu() {
        return ghiChu;
    }

    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }

    public BigDecimal getGiaPhongTaiThoiDiemDat() {
        return giaPhongTaiThoiDiemDat;
    }

    public void setGiaPhongTaiThoiDiemDat(BigDecimal giaPhongTaiThoiDiemDat) {
        this.giaPhongTaiThoiDiemDat = giaPhongTaiThoiDiemDat;
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

    public int getSoNguoiToiDa() {
        return soNguoiToiDa;
    }

    public void setSoNguoiToiDa(int soNguoiToiDa) {
        this.soNguoiToiDa = soNguoiToiDa;
    }

    public double getGiaCoBan() {
        return giaCoBan;
    }

    public void setGiaCoBan(double giaCoBan) {
        this.giaCoBan = giaCoBan;
    }

    public String getMoTaLoaiPhong() {
        return moTaLoaiPhong;
    }

    public void setMoTaLoaiPhong(String moTaLoaiPhong) {
        this.moTaLoaiPhong = moTaLoaiPhong;
    }
    
}
