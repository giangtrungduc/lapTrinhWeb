package com.mycompany.laptrinhweb.model.dto;

import java.math.BigDecimal;

/**
 * DTO dùng để lưu top dịch vụ có doanh thu cao nhất
 */
public class TopServiceDTO {
    private int maDV;
    private String tenDichVu;
    private BigDecimal doanhThu;

    public int getMaDV() {
        return maDV;
    }

    public void setMaDV(int maDV) {
        this.maDV = maDV;
    }

    public String getTenDichVu() {
        return tenDichVu;
    }

    public void setTenDichVu(String tenDichVu) {
        this.tenDichVu = tenDichVu;
    }

    public BigDecimal getDoanhThu() {
        return doanhThu;
    }

    public void setDoanhThu(BigDecimal doanhThu) {
        this.doanhThu = doanhThu;
    }
}