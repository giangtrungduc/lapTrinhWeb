
package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDAO {
    public String checkLogin(String username, String password){
        DBConnection db = new DBConnection();
        try(Connection conn=(Connection) db.getConnection()){
            String sql="select * from nhanvien";
            PreparedStatement ps=conn.prepareStatement(sql);
            ResultSet rs=ps.executeQuery();
            while (rs.next()){
                String us=rs.getString("TenDangNhap");
                String psw=rs.getString("MatKhauHash");
                if (us.equals(username) && psw.equals(password)) return username.substring(0, 5);
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
