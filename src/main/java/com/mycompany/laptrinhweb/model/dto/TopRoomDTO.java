package com.mycompany.laptrinhweb.model.dto;

import java.math.BigDecimal;

/**
 * DTO dùng để lưu top phòng có doanh thu cao nhất
 */
public class TopRoomDTO {
    private int maPhong;
    private String tenPhong;
    private BigDecimal doanhThu;

    public int getMaPhong() {
        return maPhong;
    }

    public void setMaPhong(int maPhong) {
        this.maPhong = maPhong;
    }

    public String getTenPhong() {
        return tenPhong;
    }

    public void setTenPhong(String tenPhong) {
        this.tenPhong = tenPhong;
    }

    public BigDecimal getDoanhThu() {
        return doanhThu;
    }

    public void setDoanhThu(BigDecimal doanhThu) {
        this.doanhThu = doanhThu;
    }
}