
package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import com.mycompany.laptrinhweb.model.dto.CustomerDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class CustomerDAO {
    public List<CustomerDTO> listCustomer() {
        List<CustomerDTO> li=new ArrayList<>();
        DBConnection db=new DBConnection();
        try(Connection conn=db.getConnection()){
            String sql="select * from khachhang";
            PreparedStatement ps=conn.prepareStatement(sql);
            ResultSet rs=ps.executeQuery();
            while (rs.next()){
                int makh = rs.getInt("MaKH");
                String ten=rs.getString("HoTen");
                String cccd = rs.getString("CCCD");
                String sdt = rs.getString("SDT");
                String diachi = rs.getString("DiaChi");
                String email = rs.getString("Email");
                int solandat=countBookingForCustomer(makh);
                CustomerDTO customer=new CustomerDTO();
                customer.setCccd(cccd);
                customer.setDiachi(diachi);
                customer.setEmail(email);
                customer.setHoten(ten);
                customer.setMakh(makh);
                customer.setSdt(sdt);
                customer.setSolandat(solandat);
                li.add(customer);
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return li;
    }
    public int countBookingForCustomer(int makh){
        DBConnection db=new DBConnection();
        int solan=0;
        try(Connection conn=db.getConnection()){
            String sql="select count(*) as countCustomer from datphong where MaKH=?";
            PreparedStatement ps=conn.prepareStatement(sql);
            ps.setInt(1, makh);
            ResultSet rs=ps.executeQuery();
            rs.next();
            solan=rs.getInt("countCustomer");
            
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return solan;
    }
    public void deleteCustomerById(int id){
        DBConnection db=new DBConnection();
        try(Connection conn=db.getConnection()){
            String sql="delete from KhachHang where MaKH=?";
            PreparedStatement ps=conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.execute();
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
}
