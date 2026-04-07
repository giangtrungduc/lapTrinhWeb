/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.laptrinhweb.model.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 *
 * @author Admin
 */
public class HoaDonDTO {

    private int maHoaDon;
    private int maDatPhong;
    private LocalDateTime ngayLap;
    private BigDecimal tongTienPhong;
    private BigDecimal tongTienDV;
    private BigDecimal tongThanhToan;

    public HoaDonDTO() {
    }

    public HoaDonDTO(int maHoaDon, int maDatPhong, LocalDateTime ngayLap, BigDecimal tongTienPhong, BigDecimal tongTienDV, BigDecimal tongThanhToan) {
        this.maHoaDon = maHoaDon;
        this.maDatPhong = maDatPhong;
        this.ngayLap = ngayLap;
        this.tongTienPhong = tongTienPhong;
        this.tongTienDV = tongTienDV;
        this.tongThanhToan = tongThanhToan;
    }
    
}
