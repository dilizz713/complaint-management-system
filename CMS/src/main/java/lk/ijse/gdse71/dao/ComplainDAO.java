package lk.ijse.gdse71.dao;

import lk.ijse.gdse71.model.Complain;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ComplainDAO {
    private final BasicDataSource dataSource;

    public ComplainDAO(BasicDataSource dataSource) {
        this.dataSource = dataSource;
    }


    public int getTotalComplaints(int id, String role) throws SQLException {
        String sql = role.equals("ADMIN")?
                "select count(*) from complain" : "select count(*) from complain where user_id=? ";

        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        if(!role.equals("ADMIN")){
            preparedStatement.setInt(1,id);
        }
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        return resultSet.getInt(1);
    }

    public int getPendingComplaints(int id, String role) throws SQLException {
        String sql = role.equals("ADMIN")?
                "select count(*) from complain where status='PENDING'":
                "select count(*) from complain where user_id=? and status='PENDING'";

        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        if(!role.equals("ADMIN")){
            preparedStatement.setInt(1,id);
        }
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        return resultSet.getInt(1);

    }

    public boolean addComplaint(Complain complain) throws SQLException {
        String sql = "insert into complain (user_id, title , description) values (?,?,?)";

        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        preparedStatement.setInt(1,complain.getUserId());
        preparedStatement.setString(2,complain.getTitle());
        preparedStatement.setString(3,complain.getDescription());

        return preparedStatement.executeUpdate() > 0;
    }

    public List<Complain> getComplaintsByUserId(int id) throws SQLException {
        List<Complain> complains = new ArrayList<>();

        String sql = "select * from complain where user_id = ? order by created_at desc";

        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        preparedStatement.setInt(1,id);

        ResultSet resultSet = preparedStatement.executeQuery();
        while(resultSet.next()){
            Complain complain = new Complain();
            complain.setId(resultSet.getInt("id"));
            complain.setUserId(resultSet.getInt("user_id"));
            complain.setTitle(resultSet.getString("title"));
            complain.setDescription(resultSet.getString("description"));
            complain.setStatus(resultSet.getString("status"));
            complain.setRemarks(resultSet.getString("remarks"));
            complain.setCreatedAt(resultSet.getTimestamp("created_at"));
            complain.setUpdatedAt(resultSet.getTimestamp("updated_at"));

            complains.add(complain);
        }
        return complains;

    }
}
