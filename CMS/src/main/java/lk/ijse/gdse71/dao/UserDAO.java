package lk.ijse.gdse71.dao;

import lk.ijse.gdse71.model.User;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
}
