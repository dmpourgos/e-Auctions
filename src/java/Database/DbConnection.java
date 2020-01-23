package Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


public class DbConnection {
    
    private Connection conn;  
    private PreparedStatement pst; 
  
    private String url;  
    private String driver; 
    private String userName;  
    private String password;

    public DbConnection(Connection conn, PreparedStatement pst, String url, String driver, String userName, String password) {
        this.conn = conn;
        this.pst = pst;
        this.url = url;
        this.driver = driver;
        this.userName = userName;
        this.password = password;
    }

    public DbConnection() {
        
        try {  
            this.url = "jdbc:derby://localhost:1527/auctions";
            this.driver = "org.apache.derby.jdbc.ClientDriver";
            this.userName = "app";
            this.password = "app";
            try {
                Class.forName(this.driver).newInstance();
            } catch (ClassNotFoundException | InstantiationException | IllegalAccessException ex) {
                Logger.getLogger(DbConnection.class.getName()).log(Level.SEVERE, null, ex);
            }
            conn = DriverManager.getConnection(url, userName, password);
        } catch (SQLException ex) {
            Logger.getLogger(DbConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

    public Connection getConn() {
        return conn;
    }

    public PreparedStatement getPst() {
        return pst;
    }

    public String getUrl() {
        return url;
    }

    public String getDriver() {
        return driver;
    }

    public String getUserName() {
        return userName;
    }

    public String getPassword() {
        return password;
    }

    public void setConn(Connection conn) {
        this.conn = conn;
    }

    public void setPst(PreparedStatement pst) {
        this.pst = pst;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public void setDriver(String driver) {
        this.driver = driver;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    
    
    
    
}
