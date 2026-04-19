package com.mycompany.laptrinhweb.model.dto;

public class RoomTypeDTO {
    private int maloaiphong;
    private String tenloaiphong;
    private int songuoitoida;
    private float giacoban;

    public RoomTypeDTO() {}

    public RoomTypeDTO(int maloaiphong, String tenloaiphong, int songuoitoida, float giacoban) {
        this.maloaiphong = maloaiphong;
        this.tenloaiphong = tenloaiphong;
        this.songuoitoida = songuoitoida;
        this.giacoban = giacoban;
    }

    public int getMaloaiphong() { return maloaiphong; }
    public void setMaloaiphong(int maloaiphong) { this.maloaiphong = maloaiphong; }

    public String getTenloaiphong() { return tenloaiphong; }
    public void setTenloaiphong(String tenloaiphong) { this.tenloaiphong = tenloaiphong; }

    public int getSonguoitoida() { return songuoitoida; }
    public void setSonguoitoida(int songuoitoida) { this.songuoitoida = songuoitoida; }

    public float getGiacoban() { return giacoban; }
    public void setGiacoban(float giacoban) { this.giacoban = giacoban; }
}