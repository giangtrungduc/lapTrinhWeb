package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import com.mycompany.laptrinhweb.model.dto.EmployeeDTO;
import com.mycompany.laptrinhweb.model.dto.ServiceDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class ServiceDAO {

    public List<ServiceDTO> listService() {
        List<ServiceDTO> list = new ArrayList<>();
        try (Connection conn = new DBConnection().getConnection()) {
            String sql = "select * from dichvu";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ServiceDTO sv = new ServiceDTO();
                sv.setMaDV(rs.getInt("MaDV"));
                sv.setTenDV(rs.getString("TenDV"));
                sv.setDonGia(rs.getBigDecimal("DonGia"));
                sv.setMoTa(rs.getString("MoTa"));
                list.add(sv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addService(ServiceDTO sv) {
        try (Connection conn = new DBConnection().getConnection()) {
            String sql = "insert into  dichvu(TenDV,DonGia,MoTa) values(?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, sv.getTenDV());
            ps.setBigDecimal(2, sv.getDonGia());
            ps.setString(3, sv.getMoTa());
            int dem = ps.executeUpdate();
            return dem > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateService(ServiceDTO sv) {
        try (Connection con = new DBConnection().getConnection()) {
            String sql = "update dichvu set TenDV=?,DonGia=?,MoTa=? where MaDV=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, sv.getTenDV());
            ps.setBigDecimal(2, sv.getDonGia());
            ps.setString(3, sv.getMoTa());
            ps.setInt(4, sv.getMaDV());
            int dem = ps.executeUpdate();
            return dem > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteService(int ma) {
        String sql = "delete from dichvu where MaDV=?";
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

    public List<ServiceDTO> searchService(String key) {
        List<ServiceDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM dichvu WHERE CAST(MaDV AS CHAR) LIKE ? OR TenDV LIKE ?";
        try (Connection con = new DBConnection().getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + key + "%");
            ps.setString(2, "%" + key + "%");
            try(ResultSet rs = ps.executeQuery()){
                while(rs.next()){
                    ServiceDTO sv =new ServiceDTO();
                    sv.setMaDV(rs.getInt("MaDV"));
                    sv.setTenDV(rs.getString("TenDV"));
                    sv.setDonGia(rs.getBigDecimal("DonGia"));
                    sv.setMoTa(rs.getString("MoTa"));
                    list.add(sv);
                }
            }catch(Exception e){
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return  list;
    }
}