
package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class InvoiceDAO {
    public void saveInvoice(int madatphong, BigDecimal tongtienphong, BigDecimal tongtiendv){
        DBConnection db = new DBConnection();
        try(Connection conn = db.getConnection()){
            String sql="insert into hoadon (MaDatPhong, TongTienPhong, TongTienDV) values (?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, madatphong);
            ps.setBigDecimal(2, tongtienphong);
            ps.setBigDecimal(3, tongtiendv);
            ps.execute();
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
    public boolean findBookingInvoice(int madatphong){
        DBConnection db = new DBConnection();
        try(Connection conn = db.getConnection()){
            String sql="select * from hoadon where MaDatPhong=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, madatphong);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                return false;
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return true;
    }
}
