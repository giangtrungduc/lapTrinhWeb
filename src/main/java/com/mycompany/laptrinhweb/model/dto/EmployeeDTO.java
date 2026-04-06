/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.laptrinhweb.model.dto;

/**
 *
 * @author Admin
 */
public class EmployeeDTO {
    private int maNV;
    private String sdt,hoTen,chucVu,tenDangNhap,matKhauHash;

    public EmployeeDTO() {
    }

    public EmployeeDTO(int maNV,String hoTen, String sdt, String chucVu, String tenDangNhap, String matKhauHash) {
        this.maNV = maNV;
        this.sdt = sdt;
        this.chucVu = chucVu;
        this.tenDangNhap = tenDangNhap;
        this.matKhauHash = matKhauHash;
        this.hoTen=hoTen;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public int getMaNV() {
        return maNV;
    }

    public void setMaNV(int maNV) {
        this.maNV = maNV;
    }

    public String getSdt() {
        return sdt;
    }

    public void setSdt(String sdt) {
        this.sdt = sdt;
    }

    public String getChucVu() {
        return chucVu;
    }

    public void setChucVu(String chucVu) {
        this.chucVu = chucVu;
    }

    public String getTenDangNhap() {
        return tenDangNhap;
    }

    public void setTenDangNhap(String tenDangNhap) {
        this.tenDangNhap = tenDangNhap;
    }

    public String getMatKhauHash() {
        return matKhauHash;
    }

    public void setMatKhauHash(String matKhauHash) {
        this.matKhauHash = matKhauHash;
    }
    
}
