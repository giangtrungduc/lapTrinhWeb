/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.laptrinhweb.model.dto;

import java.math.BigDecimal;

/**
 *
 * @author giang
 */
public class ServiceDTO {
    private int maDV;
    private String tenDV;
    private BigDecimal donGia;
    private String moTa;

    public ServiceDTO() {
    }

    public ServiceDTO(int maDV, String tenDV, BigDecimal donGia, String moTa) {
        this.maDV = maDV;
        this.tenDV = tenDV;
        this.donGia = donGia;
        this.moTa = moTa;
    }

    public int getMaDV() {
        return maDV;
    }

    public void setMaDV(int maDV) {
        this.maDV = maDV;
    }

    public String getTenDV() {
        return tenDV;
    }

    public void setTenDV(String tenDV) {
        this.tenDV = tenDV;
    }

    public BigDecimal getDonGia() {
        return donGia;
    }

    public void setDonGia(BigDecimal donGia) {
        this.donGia = donGia;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }
    
}
