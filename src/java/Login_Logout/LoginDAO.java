package Login_Logout;

import UserOp.Users;
import UserOp.UserDto;
import Database.DbConnection;
import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.PreparedStatement; 
import java.sql.ResultSet;  
import java.sql.SQLException;  



public class LoginDAO {
     public static UserDto validate(String name, String pass) {          
        boolean status = false; 
        Connection conn = null;  
        PreparedStatement pst = null;  
        ResultSet rs = null;  
        UserDto usr=new UserDto();
        
       
        try {  
            DbConnection db = new DbConnection();
            conn = db.getConn();
            pst = conn.prepareStatement("select * from TED.USERS where USERNAME=? and PASSWORD=?");  
            pst.setString(1, name);  
            pst.setString(2, pass);  
  
            rs = pst.executeQuery();  
            status = rs.next();  
            if(status)
            {
                if(rs.getInt("ROLE")==1)
                {
                    usr.setUser(new Users(rs.getString("USERNAME"),rs.getString("PASSWORD"),rs.getString("NAME"),rs.getString("SURNAME"),rs.getString("EMAIL"),rs.getString("PHONE"),rs.getString("CITY"),rs.getString("ADDRESS"),rs.getInt("NUMBER"),rs.getInt("TK"),rs.getInt("INFOS"),rs.getInt("ACCEPTED"),rs.getString("AFM"),rs.getString("COUNTRY"),rs.getInt("ROLE"),rs.getString("LOCATION"),rs.getInt("S_RATING"),rs.getInt("B_RATING")));
                    usr.setFlag(2);    //admin
                }else if(rs.getInt("ROLE")==2){
                    if(rs.getInt("ACCEPTED")==1){
                        usr.setFlag(1);     //accepted user
                        usr.setUser(new Users(rs.getString("USERNAME"),rs.getString("PASSWORD"),rs.getString("NAME"),rs.getString("SURNAME"),rs.getString("EMAIL"),rs.getString("PHONE"),rs.getString("CITY"),rs.getString("ADDRESS"),rs.getInt("NUMBER"),rs.getInt("TK"),rs.getInt("INFOS"),rs.getInt("ACCEPTED"),rs.getString("AFM"),rs.getString("COUNTRY"),rs.getInt("ROLE"),rs.getString("LOCATION"),rs.getInt("S_RATING"),rs.getInt("B_RATING")));
                    }else{
                        usr.setFlag(0);     //non-accepted user
                    }   
                }
            }else{
                usr.setFlag(-1);    //wrong username or password
            }
  
        }catch (Exception e) {  
            System.out.println(e);  
        }finally {  
            if (conn != null) {  
                try {  
                    conn.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            }  
            if (pst != null) {  
                try {  
                    pst.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            }  
            if (rs != null) {  
                try {  
                    rs.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            }  
        }  
        return usr;  
    }  
}
