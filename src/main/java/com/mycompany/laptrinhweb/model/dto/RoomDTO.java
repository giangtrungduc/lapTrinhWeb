/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.laptrinhweb.model.dto;

import java.sql.DatabaseMetaData;

public class RoomDTO {
    private int maphong, sophong, maloaiphong;
    private RoomStatus trangthai;
    private String tenloaiphong;
    private float gia;
    private int songuoitoida;

    public RoomDTO() {
    }

    public RoomDTO(int maphong, int sophong, int maloaiphong,RoomStatus trangthai, String tenloaiphong, float gia, int songuoitoida) {
        this.maphong = maphong;
        this.sophong = sophong;
        this.maloaiphong = maloaiphong;
        this.trangthai = trangthai;
        this.tenloaiphong = tenloaiphong;
        this.gia = gia;
        this.songuoitoida = songuoitoida;
    }

    public int getMaphong() {
        return maphong;
    }

    public void setMaphong(int maphong) {
        this.maphong = maphong;
    }

    public int getSophong() {
        return sophong;
    }

    public void setSophong(int sophong) {
        this.sophong = sophong;
    }

    public int getMaloaiphong() {
        return maloaiphong;
    }

    public void setMaloaiphong(int maloaiphong) {
        this.maloaiphong = maloaiphong;
    }

    public RoomStatus getTrangthai() {
        return trangthai;
    }

    public void setTrangthai(RoomStatus trangthai) {
        this.trangthai = trangthai;
    }

    public String getTenloaiphong() {
        return tenloaiphong;
    }

    public void setTenloaiphong(String tenloaiphong) {
        this.tenloaiphong = tenloaiphong;
    }

    public float getGia() {
        return gia;
    }

    public void setGia(float gia) {
        this.gia = gia;
    }

    public int getSonguoitoida() {
        return songuoitoida;
    }

    public void setSonguoitoida(int songuoitoida) {
        this.songuoitoida = songuoitoida;
    }
    
    
}
