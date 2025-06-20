package lk.ijse.gdse71.db;

import org.apache.commons.dbcp2.BasicDataSource;


public class DBConnection {
    private static final BasicDataSource ds = new BasicDataSource();

    static {
        ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
        ds.setUrl("jdbc:mysql://localhost:3306/cms?useSSL=false&serverTimezone=UTC");
        ds.setUsername("root");
        ds.setPassword("Asd713@#");
        ds.setInitialSize(50);
        ds.setMaxTotal(100);
    }

    private DBConnection() {

    }

   public static BasicDataSource getDataSource() {
        return ds;
   }
}
