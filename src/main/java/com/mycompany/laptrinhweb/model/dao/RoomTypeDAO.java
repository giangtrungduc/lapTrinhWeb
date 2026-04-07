package com.mycompany.laptrinhweb.model.dao;

import com.mycompany.laptrinhweb.model.DBConnection;
import com.mycompany.laptrinhweb.model.dto.RoomTypeDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomTypeDAO {

    /**
     * Lấy danh sách tất cả loại phòng, kèm theo số phòng trống của mỗi loại.
     */
    public List<RoomTypeDTO> listLoaiPhong() {
        List<RoomTypeDTO> list = new ArrayList<>();
        DBConnection db = new DBConnection();
        try (Connection conn = db.getConnection()) {
            String sql = "SELECT lp.MaLoaiPhong, lp.TenLoaiPhong, lp.SoNguoiToiDa, "
                       + "lp.GiaCoBan, lp.MoTa, COUNT(p.MaPhong) AS SoPhong "
                       + "FROM LoaiPhong lp "
                       + "LEFT JOIN Phong p ON lp.MaLoaiPhong = p.MaLoaiPhong AND p.TrangThai = 'Trong' "
                       + "GROUP BY lp.MaLoaiPhong, lp.TenLoaiPhong, lp.SoNguoiToiDa, lp.GiaCoBan, lp.MoTa "
                       + "ORDER BY lp.MaLoaiPhong";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RoomTypeDTO dto = new RoomTypeDTO();
                dto.setMaLoaiPhong(rs.getInt("MaLoaiPhong"));
                dto.setTenLoaiPhong(rs.getString("TenLoaiPhong"));
                dto.setSoNguoiToiDa(rs.getInt("SoNguoiToiDa"));
                dto.setGiaCoBan(rs.getDouble("GiaCoBan"));
                dto.setMoTa(rs.getString("MoTa"));
                dto.setSoPhongHienCo(rs.getInt("SoPhong"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
