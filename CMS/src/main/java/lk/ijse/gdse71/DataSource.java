package lk.ijse.gdse71;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.apache.commons.dbcp2.BasicDataSource;

@WebListener
public class DataSource implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        BasicDataSource ds = new BasicDataSource();
        ds.setDriverClassName("com.mysql.jdbc.Driver");
        ds.setUrl("jdbc:mysql://localhost:3306/cms");
        ds.setUsername("root");
        ds.setPassword("Asd713@#");
        ds.setInitialSize(50);
        ds.setMaxTotal(100);

        ServletContext context = sce.getServletContext();
        context.setAttribute("dataSource", ds);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try{
            ServletContext context = sce.getServletContext();
            BasicDataSource ds = (BasicDataSource) context.getAttribute("dataSource");
            ds.close();
        }catch (Exception e) {
            throw new RuntimeException();
        }
    }
}
