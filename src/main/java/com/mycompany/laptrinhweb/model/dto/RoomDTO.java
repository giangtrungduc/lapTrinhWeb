package com.mycompany.laptrinhweb.model.dto;

public class RoomDTO {
    private int maPhong;
    private int soPhong;
    private int maLoaiPhong;
    private RoomStatus trangThai; 
    private String tenLoaiPhong;
    private double gia;
    private int soNguoiToiDa;

    public RoomDTO() {}

    public RoomDTO(int maPhong, int soPhong, int maLoaiPhong, RoomStatus trangThai, String tenLoaiPhong, double gia, int soNguoiToiDa) {
        this.maPhong = maPhong;
        this.soPhong = soPhong;
        this.maLoaiPhong = maLoaiPhong;
        this.trangThai = trangThai;
        this.tenLoaiPhong = tenLoaiPhong;
        this.gia = gia;
        this.soNguoiToiDa = soNguoiToiDa;
    }

    // Getters & Setters dùng camelCase
    public int getMaPhong() { return maPhong; }
    public void setMaPhong(int maPhong) { this.maPhong = maPhong; }
    public int getSoPhong() { return soPhong; }
    public void setSoPhong(int soPhong) { this.soPhong = soPhong; }
    public int getMaLoaiPhong() { return maLoaiPhong; }
    public void setMaLoaiPhong(int maLoaiPhong) { this.maLoaiPhong = maLoaiPhong; }
    public RoomStatus getTrangThai() { return trangThai; }
    public void setTrangThai(RoomStatus trangThai) { this.trangThai = trangThai; }
    public String getTenLoaiPhong() { return tenLoaiPhong; }
    public void setTenLoaiPhong(String tenLoaiPhong) { this.tenLoaiPhong = tenLoaiPhong; }
    public double getGia() { return gia; }
    public void setGia(double gia) { this.gia = gia; }
    public int getSoNguoiToiDa() { return soNguoiToiDa; }
    public void setSoNguoiToiDa(int soNguoiToiDa) { this.soNguoiToiDa = soNguoiToiDa; }
}