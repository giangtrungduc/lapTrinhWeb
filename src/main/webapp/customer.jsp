
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.laptrinhweb.model.dto.CustomerDTO"%>
<%
    List<CustomerDTO> customerList = (ArrayList) request.getAttribute("customerList");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CUSTOMER PAGE</title>
        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <script>
        function openEditModal(id, name, phone) {
            document.getElementById('editModal').style.display = "block";
            // Đổ dữ liệu vào các ô input trong form
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-name').value = name;
            document.getElementById('edit-phone').value = phone;
        }

        function closeModal() {
            document.getElementById('editModal').style.display = "none";
        }
    </script>
    <body>
        <style>
            table{
                border-collapse: collapse;
                width: 100%;
            }
            th,td{
                padding: 12px 15px;
                text-align: center;
                border: 1px solid #dddd;
            }
            .modal {
                display: none; /* Ẩn mặc định */
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5); /* Nền mờ phía sau */
            }
            .modal-content {
                background-color: #fefefe;
                margin: 10% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 30%; /* Độ rộng khung sửa */
            }
            .close {
                float: right;
                cursor: pointer;
                font-size: 28px;
            }
        </style>
        <table>
            s
            <tr>
                <th>Mã khách hàng</th>
                <th>Họ tên</th>
                <th>CCCD</th>
                <th>SĐT</th>
                <th>Email</th>
                <th>Địa chỉ</th>
                <th>Số lần đặt</th>
                <th>Thao tác</th>
            </tr>

            <%
                for (CustomerDTO cus : customerList) {
            %>
            <tr>
                <td><%=cus.getMakh()%></td>
                <td><%=cus.getHoten()%></td>
                <td><%=cus.getCccd()%></td>
                <td><%=cus.getSdt()%></td>
                <td><%=cus.getEmail()%></td>
                <td><%=cus.getDiachi()%></td>
                <td><%=cus.getSolandat()%></td>
                <td>
                    <input type="hidden" name="id" value="<%=cus.getMakh()%>">
                    <a href="javascript:void(0)" onclick="openEditModal('<%=cus.getMakh()%>', '<%=cus.getHoten()%>', '<%=cus.getSdt()%>')">
                        <i class="fa-solid fa-wrench" style="color: blue; margin-right: 10px;"></i>
                    </a>

                    <a href="DeleteCustomerServlet?id=<%=cus.getMakh()%>" onclick="return confirm('Bạn có chắc muốn xóa?')">
                        <i class="fa-solid fa-trash-can" style="color: red;"></i>
                    </a>
                </td>           
            </tr>
            <%
                }
            %>

        </table>
        <div id="editModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h3>Sửa thông tin khách hàng</h3>
                <form action="UpdateCustomerServlet" method="POST">
                    <input type="hidden" id="edit-id" name="id">
                    <label>Họ tên:</label>
                    <input type="text" id="edit-name" name="name"><br><br>
                    <label>Số điện thoại:</label>
                    <input type="text" id="edit-phone" name="phone"><br><br>
                    <button type="submit">Lưu thay đổi</button>
                </form>
            </div>
        </div>
    </body>
</html>
