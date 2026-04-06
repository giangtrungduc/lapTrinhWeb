package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import com.mycompany.laptrinhweb.model.dto.AddingCustomerDTO;
import com.mycompany.laptrinhweb.model.dto.CheckedInCustomerDTO;
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
        List<CustomerDTO> li = new ArrayList<>();
        DBConnection db = new DBConnection();
        try (Connection conn = db.getConnection()) {
            String sql = "select * from khachhang";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int makh = rs.getInt("MaKH");
                String ten = rs.getString("HoTen");
                String cccd = rs.getString("CCCD");
                String sdt = rs.getString("SDT");
                String diachi = rs.getString("DiaChi");
                String email = rs.getString("Email");
                int solandat = countBookingForCustomer(makh);
                CustomerDTO customer = new CustomerDTO();
                customer.setCccd(cccd);
                customer.setDiachi(diachi);
                customer.setEmail(email);
                customer.setHoten(ten);
                customer.setMakh(makh);
                customer.setSdt(sdt);
                customer.setSolandat(solandat);
                li.add(customer);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return li;
    }

    public int countBookingForCustomer(int makh) {
        DBConnection db = new DBConnection();
        int solan = 0;
        try (Connection conn = db.getConnection()) {
            String sql = "select count(*) as countCustomer from datphong where MaKH=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, makh);
            ResultSet rs = ps.executeQuery();
            rs.next();
            solan = rs.getInt("countCustomer");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return solan;
    }

    public void deleteCustomerById(int id) {
        DBConnection db = new DBConnection();
        try (Connection conn = db.getConnection()) {
            String sql = "delete from KhachHang where MaKH=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addCustomer(AddingCustomerDTO customer) throws Exception {
        DBConnection db = new DBConnection();
        try (Connection conn = db.getConnection()) {
            String sql = "insert into khachhang (HoTen, CCCD, SDT, Email, DiaChi) values (?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, customer.getHoTen());
            ps.setString(5, customer.getDiaChi());
            ps.setString(4, customer.getEmail());
            ps.setString(2, customer.getCCCD());
            ps.setString(3, customer.getSDT());
            ps.execute();
        }
    }

    public List<CustomerDTO> filterCustomer(String result) {
        List<CustomerDTO> li = new ArrayList<>();
        String keyword = "%" + result + "%";
        DBConnection db = new DBConnection();
        try (Connection conn = db.getConnection()) {
            String sql = "select * from khachhang where HoTen like ? or CCCD like ? or SDT like ? ";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, keyword);
            ps.setString(2, keyword);
            ps.setString(3, keyword);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CustomerDTO customer = new CustomerDTO();
                customer.setMakh(rs.getInt("MaKH"));
                customer.setHoten(rs.getString("HoTen"));
                customer.setCccd(rs.getString("CCCD"));
                customer.setDiachi(rs.getString("DiaChi"));
                customer.setEmail(rs.getString("Email"));
                customer.setSdt(rs.getString("SDT"));
                int makh = rs.getInt("MaKH");
                int count = countBookingForCustomer(makh);
                customer.setSolandat(count);
                li.add(customer);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return li;
    }

    public List<CheckedInCustomerDTO> findBookingByCustomerId(int makh) {
        DBConnection db = new DBConnection();
        List<CheckedInCustomerDTO> li = new ArrayList<>();
        try (Connection conn = db.getConnection()) {
            String sql = "select d.*, p.SoPhong from datphong d join phong p on d.MaPhong = p.MaPhong where d.MaKH=? and d.TrangThai='DaDat'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, makh);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CheckedInCustomerDTO checkedIn = new CheckedInCustomerDTO();
                int madatphong = rs.getInt("MaDatPhong");
                int maphong = rs.getInt("MaPhong");
                int sophong = rs.getInt("SoPhong");
                String ngaydat = rs.getString("NgayDat");
                checkedIn.setMaDatPhong(madatphong);
                checkedIn.setMaKH(makh);
                checkedIn.setMaPhong(maphong);
                checkedIn.setNgayDat(ngaydat);
                checkedIn.setSoPhong(sophong);
                li.add(checkedIn);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return li;
    }

    public boolean checkIn(int maDatPhong, int maPhong) {
        DBConnection db = new DBConnection();
        String sqlUpdateDatPhong = "UPDATE DatPhong SET TrangThai = 'DaNhanPhong' WHERE MaDatPhong = ?";
        String sqlUpdatePhong = "UPDATE Phong SET TrangThai = 'DangO' WHERE MaPhong = ?";

        try (Connection conn = db.getConnection()) {
            conn.setAutoCommit(false); // Bắt đầu Transaction

            try (PreparedStatement ps1 = conn.prepareStatement(sqlUpdateDatPhong); PreparedStatement ps2 = conn.prepareStatement(sqlUpdatePhong)) {

                // 1. Cập nhật đơn đặt phòng
                ps1.setInt(1, maDatPhong);
                ps1.executeUpdate();

                // 2. Cập nhật trạng thái phòng thực tế
                ps2.setInt(1, maPhong);
                ps2.executeUpdate();

                conn.commit(); // Xác nhận thay đổi
                return true;
            } catch (Exception e) {
                conn.rollback(); // Có lỗi thì quay lại trạng thái cũ
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
