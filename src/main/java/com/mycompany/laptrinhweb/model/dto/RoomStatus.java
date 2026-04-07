/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.laptrinhweb.model.dto;

public enum RoomStatus{
    Trong("Trống"),
    DaDat("Đã Đặt"),
    DangO("Đang Ở"),
    BaoTri("Bảo Trì");
    
    private final String displayName;
    
    RoomStatus(String displayName) {
        this.displayName = displayName;
    }
    
    public String getDisplayName() {
        return displayName;
    }
    
    public static RoomStatus fromName(String name) {
        for (RoomStatus status : RoomStatus.values()) {
            if (status.name().equalsIgnoreCase(name)) {
                return status;
            }
        }
        return Trong;
    }
}
