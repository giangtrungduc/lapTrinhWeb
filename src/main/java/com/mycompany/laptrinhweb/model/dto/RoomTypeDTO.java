package com.mycompany.laptrinhweb.model.dto;

public class RoomTypeDTO {
    private int maLoaiPhong;
    private String tenLoaiPhong;
    private int soNguoiToiDa;
    private double giaCoBan;
    private String moTa;
    private int soPhongHienCo;

    public int getMaLoaiPhong() {
        return maLoaiPhong;
    }

    public void setMaLoaiPhong(int maLoaiPhong) {
        this.maLoaiPhong = maLoaiPhong;
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

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    public int getSoPhongHienCo() {
        return soPhongHienCo;
    }

    public void setSoPhongHienCo(int soPhongHienCo) {
        this.soPhongHienCo = soPhongHienCo;
    }
}
