package Auction;

import Database.DbConnection;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;
import UserOp.*;

public class JAXB_Servlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        RequestDispatcher rd;
        
        Connection conn = null;  
        PreparedStatement pst = null;  
  
        try (PrintWriter out = response.getWriter()) {
                                                   
           DbConnection db = new DbConnection();
            conn = db.getConn();

            ResultSet rs;
            pst = conn.prepareStatement("select * from TED.AUCTIONS");  
            rs = pst.executeQuery();  
            
            List<Auctions> auctions=new ArrayList<Auctions>();
            AllAuctions all=new AllAuctions();
            while(rs.next())
            {
                Auctions auction=new Auctions();
                auction.setItemId(rs.getInt("ITEM_ID"));
                auction.setName(rs.getString("NAME"));
                
                ResultSet rs2;
                pst = conn.prepareStatement("select * from TED.ITEM_TO_CATEGORY where ITEM_ID=?");
                pst.setInt(1, rs.getInt("ITEM_ID"));
                
                rs2 = pst.executeQuery();
                 
                List<String> category=new ArrayList<String>();
                while(rs2.next())
                {
                    category.add(rs2.getString("CATEGORY"));
                }
                
                auction.setCat(category);
                auction.setCurrently(rs.getDouble("CURRENTLY"));
                auction.setFirstBid(rs.getDouble("FIRST_BID"));
                auction.setNumberOfBids(rs.getInt("NUMBER_OF_BIDS"));
                
                if(rs.getDouble("LONGITUDE")==0.0 && rs.getDouble("LATITUDE")==0.0)
                {
                    auction.setLocation(rs.getString("LOCATION"));
                }else{
                
                    Location loc=new Location();

                    loc.setLocation(rs.getString("LOCATION"));
                    loc.setLongitude(rs.getDouble("LONGITUDE"));
                    loc.setLatitude(rs.getDouble("LATITUDE"));

                    auction.setLoc(loc);
                }
                auction.setCountry(rs.getString("COUNTRY"));
                auction.setStarted(rs.getTimestamp("STARTED"));
                auction.setEnds(rs.getTimestamp("ENDS"));
                
                Users seller=new Users();
                
                pst = conn.prepareStatement("select * from TED.USERS where USERNAME=?");
                pst.setString(1, rs.getString("USERNAME"));
                rs2 = pst.executeQuery();
                if(rs2.next())
                {
                    seller.setBRating(rs2.getInt("S_RATING"));
                }

                seller.setUsername(rs.getString("USERNAME"));
                auction.setSeller(seller);
                auction.setDescription(rs.getString("DESCRIPTION"));
                
                if(rs.getDouble("BUY_PRICE")!=0)
                {
                    auction.setBuyPrice(rs.getDouble("BUY_PRICE"));
                }
                
                Collection<Bids> bidsCollection=new ArrayList<Bids>();
                
                pst = conn.prepareStatement("select * from TED.BIDS where ITEM_ID=?");
                pst.setInt(1, rs.getInt("ITEM_ID"));
                rs2 = pst.executeQuery();
                
                while(rs2.next())
                {
                    Bids bid=new Bids();
                    Users bidder=new Users();
                    pst = conn.prepareStatement("select * from TED.USERS where USERNAME=?");
                    pst.setString(1, rs2.getString("USERNAME"));
                    ResultSet rs3 = pst.executeQuery();
                    if(rs3.next())
                    {
                        bidder.setUsername(rs2.getString("USERNAME"));
                        bidder.setBRating(rs3.getInt("B_RATING"));
                        bidder.setCountry(rs3.getString("COUNTRY"));
                        if(rs3.getString("LOCATION").equals(""))
                        {
                            bidder.setLocation(rs3.getString("CITY"));
                        }else{
                            bidder.setLocation(rs3.getString("LOCATION"));
                        }
                    }
                    
                    bid.setUsers(bidder);
                    bid.setAmount(rs2.getDouble("AMOUNT"));
                    bid.setTime(rs2.getTimestamp("TIME"));
                    
                    bidsCollection.add(bid);
                }

                auction.setBidsCollection(bidsCollection);
                all.add(auction);
                //auctions.add(auction);
                
            }
            //all.setAuctions(auctions);
            File file = new File("C:\\Users\\exported-auctions.xml");   
            file.createNewFile();
            /* init jaxb marshaler */
            JAXBContext jaxbContext = JAXBContext.newInstance( AllAuctions.class );
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();

            /* set this flag to true to format the output */
            jaxbMarshaller.setProperty( Marshaller.JAXB_FORMATTED_OUTPUT, true );

            /* marshaling of java objects in xml (output to file and standard output) */
            jaxbMarshaller.marshal( all, file );
            jaxbMarshaller.marshal( all, System.out );
            
            out.println("<script type=\"text/javascript\">");  
            out.println("alert('XML file has been successfully exported to exported-auctions.xml');");  
            out.println("</script>"); 
                   
            rd=request.getRequestDispatcher("admin_auction_management.jsp"); 
            rd.include(request,response);
                  
        }catch(Exception ex){
            System.out.println(ex);
        }
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
