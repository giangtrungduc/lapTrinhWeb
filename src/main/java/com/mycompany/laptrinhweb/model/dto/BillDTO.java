/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.laptrinhweb.model.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author DELL
 */
public class BillDTO {
    private Integer maHoaDon;
    private Integer maDatPhong,maPhong;
    private LocalDateTime ngayTra,ngayNhanDuKien,ngayTraDuKien;
    private BigDecimal tongTienPhong,giaPhong;
    private BigDecimal tongTienDV;
    private BigDecimal tongThanhToan;
    private String hoTen,sdt,cccd,email;
    private int soPhong,soDem;
    private List<ServiceDTO> services;

    public Integer getMaPhong() {
        return maPhong;
    }

    public void setMaPhong(Integer maPhong) {
        this.maPhong = maPhong;
    }

    public Integer getMaHoaDon() {
        return maHoaDon;
    }

    public void setMaHoaDon(Integer maHoaDon) {
        this.maHoaDon = maHoaDon;
    }

    public Integer getMaDatPhong() {
        return maDatPhong;
    }

    public void setMaDatPhong(Integer maDatPhong) {
        this.maDatPhong = maDatPhong;
    }

    public LocalDateTime getNgayTra() {
        return ngayTra;
    }

    public void setNgayTra(LocalDateTime ngayTra) {
        this.ngayTra = ngayTra;
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

    public BigDecimal getTongTienPhong() {
        return tongTienPhong;
    }

    public void setTongTienPhong(BigDecimal tongTienPhong) {
        this.tongTienPhong = tongTienPhong;
    }

    public BigDecimal getGiaPhong() {
        return giaPhong;
    }

    public void setGiaPhong(BigDecimal giaPhong) {
        this.giaPhong = giaPhong;
    }

    public BigDecimal getTongTienDV() {
        return tongTienDV;
    }

    public void setTongTienDV(BigDecimal tongTienDV) {
        this.tongTienDV = tongTienDV;
    }

    public BigDecimal getTongThanhToan() {
        return tongThanhToan;
    }

    public void setTongThanhToan(BigDecimal tongThanhToan) {
        this.tongThanhToan = tongThanhToan;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getSdt() {
        return sdt;
    }

    public void setSdt(String sdt) {
        this.sdt = sdt;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getSoPhong() {
        return soPhong;
    }

    public void setSoPhong(int soPhong) {
        this.soPhong = soPhong;
    }

    public int getSoDem() {
        return soDem;
    }

    public void setSoDem(int soDem) {
        this.soDem = soDem;
    }

    public List<ServiceDTO> getServices() {
        return services;
    }

    public void setServices(List<ServiceDTO> services) {
        this.services = services;
    }
    
}
