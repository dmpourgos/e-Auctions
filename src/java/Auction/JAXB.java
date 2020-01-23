package Auction;

import Database.DbConnection;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;
import UserOp.*;

public class JAXB {
    public static void main(String ar[])
    {
         
        Connection conn = null;  
        PreparedStatement pst = null;  
  
        try 
        {
            DbConnection db = new DbConnection();
            conn = db.getConn();
            //Marshalling7
            for(int j=0;j<40;j++)
            {
                File file = new File("D:\\ebay-data/items-"+j+".xml");
                JAXBContext jaxbContext = JAXBContext.newInstance(AllAuctions.class);
                Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
                AllAuctions all = (AllAuctions) jaxbUnmarshaller.unmarshal(file);

                ResultSet rs;

                int i=0,item_id=-1;

                for(Auctions auction : all.getAuctions())
                {
                    //System.out.println(auction.getSeller());

                    for(String category : auction.getCat())
                    {
                        pst = conn.prepareStatement("select * from TED.CATEGORIES where CATEGORY=?");  
                        pst.setString(1, category);   

                        rs = pst.executeQuery();
                        if(!rs.next())
                        {
                            pst = conn.prepareStatement("insert into TED.CATEGORIES (CATEGORY)"+ 
                            "values (?)");
                            pst.setString(1, category);   

                            pst.execute();
                        }
                    }
                    
                    pst = conn.prepareStatement("select * from TED.USERS where USERNAME=?");  
                    pst.setString(1, auction.getSeller().getUsername());   

                    rs = pst.executeQuery(); 
                    if(!rs.next())
                    {
                         pst = conn.prepareStatement("insert into TED.USERS (USERNAME, PASSWORD, NAME, SURNAME, EMAIL, PHONE, CITY, ADDRESS, NUMBER, TK, INFOS, ACCEPTED, AFM, ROLE,COUNTRY,S_RATING,B_RATING,LOCATION)"+ 
                        "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

                        pst.setString(1, auction.getSeller().getUsername());  
                        pst.setString(2, "123456");
                        pst.setString(3, "Unknown");
                        pst.setString(4, "Kopoulos");
                        pst.setString(5, "Unknown@mail.com");
                        pst.setString(6, "697123455");
                        pst.setString(7, "Athens");
                        pst.setString(8, "Somewhere");
                        pst.setInt(9, 7);
                        pst.setInt(10, 666);                
                        pst.setInt(11, 1);
                        pst.setInt(12, 1);
                        pst.setString(13, "123456789");
                        pst.setInt(14, 2);
                        pst.setString(15, "Greece");
                        pst.setInt(16, auction.getSeller().getBRating());
                        pst.setInt(17, 0);
                        pst.setString(18, "MyPlace");
                        pst.execute();   
                    }
                    //-------------------------------------------------------------
                    pst = conn.prepareStatement("insert into TED.AUCTIONS(NAME, CURRENTLY, BUY_PRICE, FIRST_BID, NUMBER_OF_BIDS ,COUNTRY, LOCATION, LATITUDE, LONGITUDE, STARTED, ENDS, USERNAME, DESCRIPTION)"+ 
                    "values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)");

                    pst.setString(1, auction.getName());
                    pst.setDouble(2, 100);                    
                    pst.setDouble(3,0);                                      
                    pst.setDouble(4, 100);
                    pst.setInt(5,auction.getNumberOfBids());
                    pst.setString(6, auction.getCountry());
                    pst.setString(7, "MyPlace");                  
                    pst.setDouble(8,0);                 
                    pst.setDouble(9,0);                   
                    pst.setTimestamp(10,new Timestamp(113,3,7,7,59,30,20));
                    pst.setTimestamp(11, new Timestamp(113,4,7,7,59,30,20));
                    pst.setString(12, auction.getSeller().getUsername());
                    pst.setString(13, "I m less than 1000 chars");

                    pst.execute();   
                    pst.close();
                    //--------------------------------------------------------------------
                    // Prepare the statement to retrieve the identity value
                    pst = conn.prepareStatement("select identity_val_local() as identity_val from TED.AUCTIONS");

                    // Execute the query.
                    rs = pst.executeQuery();

                    // Get the value of the identity.
                    if (rs.next()) {
                        item_id = rs.getInt(1);
                    }               

                    // Close result set, prepared statement
                    rs.close();
                    pst.close();
                    //---------------------------------------------------------------
                    for(Bids bid : auction.getBidsCollection())
                    {
                        pst = conn.prepareStatement("select * from TED.USERS where USERNAME=?");  
                        pst.setString(1, bid.getUsers().getUsername());   

                        rs = pst.executeQuery(); 
                        if(!rs.next())
                        {
                             pst = conn.prepareStatement("insert into TED.USERS (USERNAME, PASSWORD, NAME, SURNAME, EMAIL, PHONE, CITY, ADDRESS, NUMBER, TK, INFOS, ACCEPTED, AFM, ROLE,COUNTRY,S_RATING,B_RATING,LOCATION)"+ 
                            "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

                            pst.setString(1, bid.getUsers().getUsername());  
                            pst.setString(2, "123456");
                            pst.setString(3, "Unknown");
                            pst.setString(4, "Kopoulos");
                            pst.setString(5, "Unknown@mail.com");
                            pst.setString(6, "697123455");
                            pst.setString(7, "Athens");
                            pst.setString(8, "Somewhere");
                            pst.setInt(9, 7);
                            pst.setInt(10, 666);                
                            pst.setInt(11, 1);
                            pst.setInt(12, 1);
                            pst.setString(13, "123456789");
                            pst.setInt(14, 2);
                            pst.setString(15, "Greece");
                            pst.setInt(16,0);
                            pst.setInt(17,  auction.getSeller().getBRating());
                            pst.setString(18, "MyPlace");
                            pst.execute();   
                        }

                        pst = conn.prepareStatement("insert into TED.BIDS(USERNAME , TIME, AMOUNT, ITEM_ID)"+ 
                        "values ( ?, ?, ?, ?)");
                        pst.setString(1,bid.getUsers().getUsername());
                        pst.setTimestamp(2,new Timestamp(113,3,8,7,59,30,i));
                        i++;
                        pst.setDouble(3,100);
                        pst.setInt(4, item_id);

                        pst.execute(); 
                    }

                }
            }

        }catch(Exception ex){
            System.out.println(ex);
        }
    }
}