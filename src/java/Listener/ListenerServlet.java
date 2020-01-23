package Listener;

import static Auction.BidServlet.getCurrentTimeStamp;
import Database.DbConnection;
import java.sql.DriverManager;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;


public class ListenerServlet implements ServletContextListener {

    private Thread t = null;
    private ServletContext context;
    public void contextInitialized(ServletContextEvent contextEvent) {
        t =  new Thread(){
            //task
            public void run(){                
                try {                    
                 
                    while(true){
                        Connection conn = null;  
                        PreparedStatement pst = null;  
                        ResultSet rs;
                        DbConnection db = new DbConnection();
                        conn = db.getConn();

                        pst = conn.prepareStatement("SELECT ITEM_ID,USERNAME,NAME FROM TED.AUCTIONS WHERE (STARTED != ENDS and ENDS < CURRENT_TIMESTAMP or CURRENTLY = BUY_PRICE) and BUYER is null");
                        rs = pst.executeQuery(); 
                        
                        
                        
                        //pst = conn.prepareStatement("UPDATE TED.AUCTIONS set BUYER=(SELECT B.USERNAME FROM TED.BIDS B,TED.AUCTIONS A WHERE B.ITEM_ID = A.ITEM_ID ORDER BY B.TIME DESC FETCH FIRST ROW ONLY) where (STARTED != ENDS and ENDS < CURRENT_TIMESTAMP or CURRENTLY = BUY_PRICE) and BUYER is null");

                        //pst.executeUpdate();   

                        //pst.close();
                        
                        //pst = conn.prepareStatement("select * from TED.AUCTIONS where BUYER IS NOT NULL and SENT_MESSAGE=0");  
                        //rs = pst.executeQuery();  
                        
                        while(rs.next())
                        {
                            pst = conn.prepareStatement("SELECT USERNAME FROM TED.BIDS WHERE ITEM_ID = ? ORDER BY TIME DESC FETCH FIRST ROW ONLY");
                            pst.setInt(1,rs.getInt(1));
                            ResultSet rs2=pst.executeQuery();
                            
                            if(rs2.next())
                            {
                                StringBuilder sb = new StringBuilder();
                                pst = conn.prepareStatement("insert into TED.MESSAGES(SENDER , RECEIVER, THEME, CONTENT, TIME, TYPE)"+ 
                                "values ( ?, ?, ?, ?, ?, ?)");
                                pst.setString(1,rs.getString(2));
                                pst.setString(2,rs2.getString(1));
                                pst.setString(3,"You won an Auction!");                          
                                sb.append("Congratulations! You won the auction ");
                                sb.append((int)rs.getInt(1));
                                sb.append(" with name ");
                                sb.append((String)rs.getString(3));
                                sb.append("! Rate me so as to have better auctions in the future! Don't hesitate to text me a message for anything you want about the auctio! With regards.");
                                pst.setString(4,sb.toString());
                                Timestamp t=getCurrentTimeStamp();
                                pst.setTimestamp(5,t); 
                                pst.setInt(6,1);

                                pst.execute();   

                                StringBuilder sb1 = new StringBuilder();
                                pst = conn.prepareStatement("insert into TED.MESSAGES(SENDER , RECEIVER, THEME, CONTENT, TIME, TYPE)"+ 
                                "values ( ?, ?, ?, ?, ?, ?)");
                                pst.setString(1,rs2.getString(1));
                                pst.setString(2,rs.getString(2));
                                pst.setString(3,"You sold an Auction!");                           
                                sb1.append("You sold the auction ");
                                sb1.append((int)rs.getInt(1));
                                sb1.append(" with name ");
                                sb1.append((String)rs.getString(3));
                                sb1.append("! Rate me so as to have better auctions in the future!");
                                pst.setString(4,sb1.toString());
                                Timestamp t1=getCurrentTimeStamp();
                                pst.setTimestamp(5,t1);  
                                pst.setInt(6,0);

                                pst.execute();   

                                pst = conn.prepareStatement("update TED.AUCTIONS set SENT_MESSAGE=1 , BUYER=? where ITEM_ID=?");

                                pst.setString(1, rs2.getString(1));
                                pst.setInt(2, rs.getInt(1));                    

                                pst.executeUpdate();  
                            }else{
                                pst = conn.prepareStatement("update TED.AUCTIONS set SENT_MESSAGE=1, BUYER=? where ITEM_ID=?");

                                pst.setString(1, "null");
                                pst.setInt(2, rs.getInt(1));                    

                                pst.executeUpdate();  
                            }
                            
                        }
                       
                        pst.close();
                        conn.close();
                        Thread.sleep(1000);
                    }
                } catch (InterruptedException e) {} catch (SQLException ex) {
                    Logger.getLogger(ListenerServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }            
        };
        t.start();
        context = contextEvent.getServletContext();
        // you can set a context variable just like this
        context.setAttribute("TEST", "TEST_VALUE");
    }
    public void contextDestroyed(ServletContextEvent contextEvent) {
        // context is destroyed interrupts the thread
        t.interrupt();
    }            
}