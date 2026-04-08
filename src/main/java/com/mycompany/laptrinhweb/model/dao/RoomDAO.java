/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import com.mycompany.laptrinhweb.model.dto.RoomDTO;
import com.mycompany.laptrinhweb.model.dto.RoomStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class RoomDAO {
    public List<RoomDTO> listRoom(){
        List<RoomDTO> list = new ArrayList<>();
        String sql = "select p.*, lp.TenLoaiPhong, lp.SoNguoiToiDa, lp.GiaCoBan from Phong p join LoaiPhong lp on p.MaLoaiPhong = lp.MaLoaiPhong;";
        try(Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                RoomDTO room = new RoomDTO();
                room.setMaphong(rs.getInt("MaPhong"));
                room.setSophong(rs.getInt("SoPhong"));
                room.setMaloaiphong(rs.getInt("MaLoaiPhong"));
                String statusRoom = rs.getString("TrangThai");
                room.setTrangthai(RoomStatus.fromName(statusRoom));
                room.setTenloaiphong(rs.getString("TenLoaiPhong"));
                room.setSonguoitoida(rs.getInt("SoNguoiToiDa"));
                room.setGia(rs.getFloat("GiaCoBan"));
                
                list.add(room);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public boolean addRoom(RoomDTO room){
        String sql = "insert into phong(MaPhong, SoPhong, MaLoaiPhong, TrangThai) values (?, ?, ?, ?);";
        try(Connection conn = new DBConnection().getConnection()){
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setInt(1, room.getMaphong());
            ps.setInt(2, room.getSophong());
            ps.setInt(3, room.getMaloaiphong());
            ps.setString(4, room.getTrangthai().name());
            
            int result = ps.executeUpdate();
            return result > 0;
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }
    public boolean updateRoom(RoomDTO room){
        String sql = "update phong set SoPhong = ?, MaLoaiPhong = ?, TrangThai = ? where MaPhong = ?";
        try(Connection conn = new DBConnection().getConnection()){
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setInt(1, room.getSophong());
            ps.setInt(2, room.getMaloaiphong());
            ps.setString(3, room.getTrangthai().name());
            ps.setInt(4, room.getMaphong());
            
            int result = ps.executeUpdate();
            return result > 0;
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }
    public boolean deleteRoom(int id){
        String sql= "delete from phong where MaPhong = ?";
        try(Connection conn = new DBConnection().getConnection()){
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setInt(1, id);
            
            int result = ps.executeUpdate();
            return result > 0;
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }
    public RoomDTO getRoomById(int id){
        String sql = "select p.*, lp.TenLoaiPhong, lp.SoNguoiToiDa, lp.GiaCoBan from Phong p join LoaiPhong lp on p.MaLoaiPhong = lp.MaLoaiPhong where p.MaPhong = ?";
        try(Connection conn = new DBConnection().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                RoomDTO room = new RoomDTO();
                room.setMaphong(rs.getInt("MaPhong"));
                room.setSophong(rs.getInt("SoPhong"));
                room.setMaloaiphong(rs.getInt("MaLoaiPhong"));
                String statusRoom = rs.getString("TrangThai");
                room.setTrangthai(RoomStatus.fromName(statusRoom));
                room.setTenloaiphong(rs.getString("TenLoaiPhong"));
                room.setSonguoitoida(rs.getInt("SoNguoiToiDa"));
                room.setGia(rs.getFloat("GiaCoBan"));
                
                return room;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public List<RoomDTO> searchRooms(String keyword) {
        List<RoomDTO> list = new ArrayList<>();
        String sql = "SELECT p.MaPhong, p.SoPhong, p.MaLoaiPhong, p.TrangThai, lp.TenLoaiPhong, lp.Gia, lp.SoNguoiToiDa " +
                     "FROM phong p JOIN loaiphong lp ON p.MaLoaiPhong = lp.MaLoaiPhong " +
                     "WHERE CAST(p.SoPhong AS CHAR) LIKE ? OR lp.TenLoaiPhong LIKE ?";
        try (Connection con = new DBConnection().getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            String searchKey = "%" + keyword + "%";
            ps.setString(1, searchKey);
            ps.setString(2, searchKey);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RoomDTO room = new RoomDTO();
                room.setMaphong(rs.getInt("MaPhong"));
                room.setSophong(rs.getInt("SoPhong"));
                room.setMaloaiphong(rs.getInt("MaLoaiPhong"));
                room.setTrangthai(RoomStatus.valueOf(rs.getString("TrangThai")));
                room.setTenloaiphong(rs.getString("TenLoaiPhong"));
                room.setGia(rs.getFloat("Gia"));
                room.setSonguoitoida(rs.getInt("SoNguoiToiDa"));
                list.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void setRoomAvailable(int map){
        DBConnection db = new DBConnection();
        try (Connection conn = db.getConnection()){
            String sql = "update phong set TrangThai='Trong' where MaPhong=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, map);
            ps.execute();
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

}
