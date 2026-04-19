/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.laptrinhweb.model.dto;

import java.sql.Timestamp;

/**
 *
 * @author giang
 */
public class UsedServiceDTO {
    private int maSDDV;
    private int maDatPhong;
    private int maDV;
    private String tenDV;
    private int soLuong;
    private double donGia;
    private Timestamp thoiGianSuDung;
    private double thanhTien;

    public UsedServiceDTO() {
    }

    public UsedServiceDTO(int maSDDV, int maDatPhong, int maDV, String tenDV, int soLuong, double donGia, Timestamp thoiGianSuDung, double thanhTien) {
        this.maSDDV = maSDDV;
        this.maDatPhong = maDatPhong;
        this.maDV = maDV;
        this.tenDV = tenDV;
        this.soLuong = soLuong;
        this.donGia = donGia;
        this.thoiGianSuDung = thoiGianSuDung;
        this.thanhTien = thanhTien;
    }

    public int getMaSDDV() {
        return maSDDV;
    }

    public void setMaSDDV(int maSDDV) {
        this.maSDDV = maSDDV;
    }

    public int getMaDatPhong() {
        return maDatPhong;
    }

    public void setMaDatPhong(int maDatPhong) {
        this.maDatPhong = maDatPhong;
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

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    public double getDonGia() {
        return donGia;
    }

    public void setDonGia(double donGia) {
        this.donGia = donGia;
    }

    public Timestamp getThoiGianSuDung() {
        return thoiGianSuDung;
    }

    public void setThoiGianSuDung(Timestamp thoiGianSuDung) {
        this.thoiGianSuDung = thoiGianSuDung;
    }

    public double getThanhTien() {
        return thanhTien;
    }

    public void setThanhTien(double thanhTien) {
        this.thanhTien = thanhTien;
    }
    
    
}
