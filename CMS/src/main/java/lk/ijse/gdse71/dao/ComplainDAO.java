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
        String sql = role.equals("ADMIN") ?
                "select count(*) from complain" : "select count(*) from complain where user_id=? ";

        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        if (!role.equals("ADMIN")) {
            preparedStatement.setInt(1, id);
        }
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        return resultSet.getInt(1);
    }

    public int getPendingComplaints(int id, String role) throws SQLException {
        String sql = role.equals("ADMIN") ?
                "select count(*) from complain where status='PENDING'" :
                "select count(*) from complain where user_id=? and status='PENDING'";

        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        if (!role.equals("ADMIN")) {
            preparedStatement.setInt(1, id);
        }
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        return resultSet.getInt(1);

    }

    public boolean addComplaint(Complain complain) throws SQLException {
        String sql = "insert into complain (user_id, title , description) values (?,?,?)";

        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        preparedStatement.setInt(1, complain.getUserId());
        preparedStatement.setString(2, complain.getTitle());
        preparedStatement.setString(3, complain.getDescription());

        return preparedStatement.executeUpdate() > 0;
    }

    public List<Complain> getComplaintsByUserId(int id) throws SQLException {
        List<Complain> complains = new ArrayList<>();

        String sql = "select * from complain where user_id = ? order by created_at desc";

        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        preparedStatement.setInt(1, id);

        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
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

    public boolean updateComplainStatusAndRemarks(int complaintId, String status, String remarks) throws SQLException {
        String sql = "update complain set status = ?, remarks = ? updated_at = now() where id = ?";
        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        preparedStatement.setString(1, status);
        preparedStatement.setString(2, remarks);
        preparedStatement.setInt(3, complaintId);

        return preparedStatement.executeUpdate() > 0;
    }

    public List<Complain> getAllComplaints() throws SQLException {
        List<Complain> complains = new ArrayList<>();
        String sql = "select c.*, u.name as user_name, u.department from complain c join user u on c.user_id = u.id order by field(c.status, 'PENDING', 'IN_PROGRESS', 'RESOLVED'), c.created_at desc";

        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            Complain complain = new Complain();
            complain.setId(resultSet.getInt("id"));
            complain.setUserId(resultSet.getInt("user_id"));
            complain.setTitle(resultSet.getString("title"));
            complain.setDescription(resultSet.getString("description"));
            complain.setStatus(resultSet.getString("status"));
            complain.setRemarks(resultSet.getString("remarks"));
            complain.setCreatedAt(resultSet.getTimestamp("created_at"));
            complain.setUpdatedAt(resultSet.getTimestamp("updated_at"));

            complain.setUserName(resultSet.getString("user_name"));
            complain.setDepartment(resultSet.getString("department"));

            complains.add(complain);
        }
        return complains;

    }

    public boolean updateComplaint(int id, String status, String remarks) throws SQLException {
        String sql = "UPDATE complain SET status = ?, remarks = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, remarks);
            ps.setInt(3, id);

            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteComplaint(int id) throws SQLException {
        String sql = "delete from complain where id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }




}
