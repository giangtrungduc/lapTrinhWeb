/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import java.util.*;
import com.mycompany.laptrinhweb.model.dto.EmployeeDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class EmployeeDAO {

    public List<EmployeeDTO> listEmployee() {
        List<EmployeeDTO> list = new ArrayList<>();
        String sql = "select * from nhanvien order by MaNV";
        try (Connection con = new DBConnection().getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                EmployeeDTO ep = new EmployeeDTO();
                ep.setMaNV(rs.getInt("MaNV"));
                ep.setChucVu(rs.getString("ChucVu"));
                ep.setMatKhauHash(rs.getString("MatKhauHash"));
                ep.setSdt(rs.getString("SDT"));
                ep.setTenDangNhap(rs.getString("TenDangNhap"));
                ep.setHoTen(rs.getString("HoTen"));
                list.add(ep);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addEmployee(EmployeeDTO ep) {
        String sql = "insert into nhanvien(HoTen,SDT,ChucVu,TenDangNhap,MatKhauHash) values(?,?,?,?,?)";
        try (Connection con = new DBConnection().getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, ep.getHoTen());
            ps.setString(2, ep.getSdt());
            ps.setString(3, ep.getChucVu());
            ps.setString(4, ep.getTenDangNhap());
            ps.setString(5, ep.getMatKhauHash());
            int sl = ps.executeUpdate();
            return sl > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateEmPloyee(EmployeeDTO ep) {
        String sql = "update nhanvien set HoTen=?,SDT=?,ChucVu=?,TenDangNhap=?,MatKhauHash=? where MaNV=?";
        try (Connection con = new DBConnection().getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, ep.getHoTen());
            ps.setString(2, ep.getSdt());
            ps.setString(3, ep.getChucVu());
            ps.setString(4, ep.getTenDangNhap());
            ps.setString(5, ep.getMatKhauHash());
            ps.setInt(6, ep.getMaNV());
            int sl = ps.executeUpdate();
            return sl > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteEmployee(int ma) {
        String sql = "delete from nhanvien where MaNV=?";
        try (Connection con = new DBConnection().getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, ma);
            int sl = ps.executeUpdate();
            return sl > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public EmployeeDTO getEmployeeById(int ma) {
        String sql = "select * from nhanvien where MaNV=?";
        try (Connection conn = new DBConnection().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ma);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    EmployeeDTO nv = new EmployeeDTO();
                    nv.setMaNV(rs.getInt("MaNV"));
                    nv.setHoTen(rs.getString("HoTen"));
                    nv.setSdt(rs.getString("SDT"));
                    nv.setChucVu(rs.getString("ChucVu"));
                    nv.setTenDangNhap(rs.getString("TenDangNhap"));
                    nv.setMatKhauHash(rs.getString("MatKhauHash"));
                    return nv;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<EmployeeDTO> searchNhanVien(String keyword) {
        List<EmployeeDTO> list = new ArrayList<>();
        String sql = "SELECT MaNV, HoTen, SDT, ChucVu, TenDangNhap, MatKhauHash "
                + "FROM NhanVien "
                + "WHERE CAST(MaNV AS CHAR) LIKE ? "
                + "OR HoTen LIKE ? "
                + "OR SDT LIKE ? "
                + "OR ChucVu LIKE ? "
                + "OR TenDangNhap LIKE ? "
                + "ORDER BY MaNV ASC";

        try (Connection conn = new DBConnection().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            String key = "%" + keyword + "%";
            ps.setString(1, key);
            ps.setString(2, key);
            ps.setString(3, key);
            ps.setString(4, key);
            ps.setString(5, key);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    EmployeeDTO nv = new EmployeeDTO();
                    nv.setMaNV(rs.getInt("MaNV"));
                    nv.setHoTen(rs.getString("HoTen"));
                    nv.setSdt(rs.getString("SDT"));
                    nv.setChucVu(rs.getString("ChucVu"));
                    nv.setTenDangNhap(rs.getString("TenDangNhap"));
                    nv.setMatKhauHash(rs.getString("MatKhauHash"));
                    list.add(nv);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public boolean isTenDangNhapExists(String tenDangNhap, Integer maNV) {
        String sql;
        if (maNV == null) {
            sql = "SELECT COUNT(*) FROM nhanvien WHERE TenDangNhap = ?";
        } else {
            sql = "SELECT COUNT(*) FROM nhanvien WHERE TenDangNhap = ? AND MaNV <> ?";
        }

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, tenDangNhap);
            if (maNV != null) {
                ps.setInt(2, maNV);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public EmployeeDTO getEmployeeByUsername(String username){
        EmployeeDTO emp = new EmployeeDTO();
        DBConnection db = new DBConnection();
        try(Connection conn = db.getConnection()){
            String sql = "select * from nhanvien where TenDangNhap=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                emp.setHoTen(rs.getString("HoTen"));
                emp.setChucVu(rs.getString("ChucVu"));
                emp.setMaNV(rs.getInt("MaNV"));
                emp.setSdt(rs.getString("SDT"));
                emp.setMatKhauHash(rs.getString("MatKhauHash"));
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return emp;
    }
}
