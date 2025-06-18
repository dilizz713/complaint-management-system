package lk.ijse.gdse71.dao;

import lk.ijse.gdse71.model.User;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private final BasicDataSource dataSource;

    public UserDAO(BasicDataSource dataSource) {
        this.dataSource = dataSource;
    }

    public boolean addUser(User user) throws SQLException {
        Connection connection = dataSource.getConnection();
        PreparedStatement pstm = connection.prepareStatement("insert into user(name,nic,department,email,password,role) values(?,?,?,?,?,?)");
        pstm.setString(1, user.getName());
        pstm.setString(2, user.getNic());
        pstm.setString(3, user.getDepartment());
        pstm.setString(4, user.getEmail());
        pstm.setString(5, user.getPassword());
        pstm.setString(6, user.getRole());

        return pstm.executeUpdate() > 0;
    }

    public User findByEmail(String email) throws SQLException {
        Connection connection = dataSource.getConnection();
        String sql = "select * from user where email=? ";
        PreparedStatement pstm = connection.prepareStatement(sql);
        pstm.setString(1,email);

        ResultSet rs = pstm.executeQuery();

        if(rs.next()) {
            return new User(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("nic"),
                    rs.getString("department"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("role")
            );
        }else{
            return null;
        }

    }

    public boolean updateUser(User user) throws Exception {
        String sql = "update user set name = ?, nic = ?, department = ? where id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getNic());
            stmt.setString(3, user.getDepartment());
            stmt.setInt(4, user.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateCredentials(int userId, String email, String password) throws Exception {
        StringBuilder sql = new StringBuilder("UPDATE user SET ");
        List<Object> params = new ArrayList<>();

        if (email != null && !email.isEmpty()) {
            sql.append("email = ?, ");
            params.add(email);
        }
        if (password != null && !password.isEmpty()) {
            sql.append("password = ?, ");
            params.add(password);
        }

        if (params.isEmpty()) return false;
        sql.setLength(sql.length() - 2);
        sql.append(" WHERE id = ?");
        params.add(userId);

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            return stmt.executeUpdate() > 0;
        }
    }



}
