package com.mycompany.laptrinhweb.model.dto;

import java.math.BigDecimal;

/**
 * DTO dùng để hiển thị chi tiết phòng / dịch vụ
 */
public class RevenueTopDetailDTO {
    private String ten;
    private BigDecimal doanhThu;
    private int soLuong;
    private String thangNam;
    private String ghiChu;

    public String getTen() {
        return ten;
    }

    public void setTen(String ten) {
        this.ten = ten;
    }

    public BigDecimal getDoanhThu() {
        return doanhThu;
    }

    public void setDoanhThu(BigDecimal doanhThu) {
        this.doanhThu = doanhThu;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    public String getThangNam() {
        return thangNam;
    }

    public void setThangNam(String thangNam) {
        this.thangNam = thangNam;
    }

    public String getGhiChu() {
        return ghiChu;
    }

    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }
}