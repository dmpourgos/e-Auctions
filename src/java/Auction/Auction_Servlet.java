package Auction;

import Database.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;


public class Auction_Servlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     * @throws java.lang.InstantiationException
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, InstantiationException, SQLException, IllegalAccessException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding( "ISO-8859-7" );
        
        Connection conn = null;  
        PreparedStatement pst = null;  
       
        
        try (PrintWriter out = response.getWriter()) {
            response.setContentType("text/html");
            
            int flag=0;
            int item_id=-1;
            int size;
                        
            RequestDispatcher rd;
            
            String user=request.getParameter("usr");
            String name=request.getParameter("rname");
            String b_price=request.getParameter("b_price");
            String f_bid=request.getParameter("f_bid");            
            String[] category=request.getParameterValues("category");   
            String country=request.getParameter("country");
            String latitude=request.getParameter("latitude");
            String location=request.getParameter("location");
            String longitude=request.getParameter("longitude");
            String desc=request.getParameter("desc");
            
            size=category.length;
            HttpSession auction_session = request.getSession(true);
            
            DbConnection db = new DbConnection();
            conn = db.getConn();
            
            if(!isDouble(f_bid))
            {
                flag=1;
                auction_session.setAttribute("f_bid_span","**First Bid must not contain characters");
            }else{
                auction_session.setAttribute("f_bid_span","");
            }
            if(!("".equals(b_price)))
            {
                if(!isDouble(b_price))
                {
                    flag=1;
                    auction_session.setAttribute("b_price_span","**Buy Price must not contain characters");
                }else{
                    if(flag==0)
                    {
                        if(Double.parseDouble(b_price) < Double.parseDouble(f_bid))
                        {
                            flag=1;
                            auction_session.setAttribute("b_price_span","**Buy Price must be bigger than First Bid");
                        }else{
                            auction_session.setAttribute("b_price_span","");
                        }
                    }else{
                        auction_session.setAttribute("b_price_span","");
                    }
                }
            }
            
            if(!("".equals(latitude)))
            {
                 if(!("".equals(longitude)))
                {
                    if(!isDouble(latitude))
                    {
                        flag=1;
                        auction_session.setAttribute("latitude_span","**Latitude must not contain characters");
                    }else{
                        if(Double.parseDouble(latitude) <=  90 && Double.parseDouble(latitude) >= -90)
                        {
                            auction_session.setAttribute("latitude_span","");
                        }else{
                            auction_session.setAttribute("latitude_span","**Latitude must be between -90 and 90");
                        }
                    }
                }else{
                    flag=1;
                    auction_session.setAttribute("longitude_span","**Longitude must be filled"); 
                    auction_session.setAttribute("latitude_span","");
                }
            }
            
            if(!("".equals(longitude)))
            {
                if(!("".equals(latitude)))
                {
                    if(!isDouble(longitude))
                    {
                        flag=1;
                        auction_session.setAttribute("longitude_span","**Longitude must not contain characters");
                    }else{
                        if(Double.parseDouble(longitude) <=  180 && Double.parseDouble(longitude) >= -180)
                        {
                            auction_session.setAttribute("longitude_span","");
                        }else{
                            auction_session.setAttribute("longitude_span","**Longitude must be between -180 and 180");
                        }
                    }
                }else{
                    flag=1;
                    auction_session.setAttribute("latitude_span","**Latitude must be filled"); 
                    auction_session.setAttribute("longitude_span","");
                }
            }
            
            
            if(flag==0)
            {
               
               
                pst = conn.prepareStatement("insert into TED.AUCTIONS(NAME, CURRENTLY, BUY_PRICE, FIRST_BID, NUMBER_OF_BIDS ,COUNTRY, LOCATION, LATITUDE, LONGITUDE, STARTED, ENDS, USERNAME, DESCRIPTION)"+ 
                "values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)");
                
                pst.setString(1, name);
                pst.setDouble(2, Double.parseDouble(f_bid));
                 if("".equals(b_price)) {
                    pst.setDouble(3,0);
                }else {
                    pst.setDouble(3, Double.parseDouble(b_price));
                }
                pst.setDouble(4, Double.parseDouble(f_bid));
                pst.setInt(5,0);
                pst.setString(6, country);
                pst.setString(7, location);
                if("".equals(latitude)) {
                    pst.setDouble(8,0);
                }else {
                    pst.setDouble(8, Double.parseDouble(latitude));
                }
                 if("".equals(longitude)) {
                    pst.setDouble(9,0);
                }else {
                    pst.setDouble(9, Double.parseDouble(longitude));
                }
                Timestamp t=getCurrentTimeStamp();
                pst.setTimestamp(10,t);
                pst.setTimestamp(11, t);
                pst.setString(12, user);
                pst.setString(13, desc);
                
                pst.execute();   
                pst.close();
                
                //------------------------------------------------------------------
                // Prepare the statement to retrieve the identity value
                pst = conn.prepareStatement("select identity_val_local() as identity_val from TED.AUCTIONS");

                // Execute the query.
                ResultSet rs = pst.executeQuery();

                // Get the value of the identity.
                if (rs.next()) {
                    item_id = rs.getInt(1);
                }
                auction_session.setAttribute("last_item_id",item_id);

                // Close result set, prepared statement
                rs.close();
                pst.close();
                
                //insert categories of the item_id to table item_to_category
                for(int i=0;i<size;++i)
                {
                     pst = conn.prepareStatement("insert into TED.ITEM_TO_CATEGORY(ITEM_ID , CATEGORY)"+ 
                     "values ( ?, ?)");
                     pst.setInt(1,item_id);
                     pst.setString(2, category[i]);
                     
                     pst.execute(); 
                     
                }
                pst.close();
                 
                
                
                /*auction_session.removeAttribute("aname");
                auction_session.removeAttribute("b_price");
                auction_session.removeAttribute("f_bid");
                auction_session.removeAttribute("alocation");
                auction_session.removeAttribute("latitude");
                auction_session.removeAttribute("longitude");
                auction_session.removeAttribute("desc");
                auction_session.removeAttribute("f_bin_span");
                auction_session.removeAttribute("b_price_span");
                auction_session.removeAttribute("latitude_span");
                auction_session.removeAttribute("longitude_span");*/
                
                rd=request.getRequestDispatcher("auction_images.jsp"); 
                rd.forward(request,response);
                
            }else{
                auction_session.setAttribute("aname", name);
                auction_session.setAttribute("b_price", b_price);
                auction_session.setAttribute("f_bid", f_bid);
                auction_session.setAttribute("alocation", location);
                auction_session.setAttribute("latitude", latitude);
                auction_session.setAttribute("longitude", longitude);
                auction_session.setAttribute("desc", desc);
                rd=request.getRequestDispatcher("create_auction.jsp"); 
                rd.include(request,response);
            }
            out.close();
            
        }catch ( IOException e) {  
            System.out.println(e);  
        }finally {
            if (conn != null) {  
                try {  
                    conn.close();  
                } catch (SQLException e) {  
                }  
            }  
            if (pst != null) {  
                try {  
                    pst.close();  
                } catch (SQLException e) {  
                }  
            }  
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Auction_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(Auction_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Auction_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(Auction_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Auction_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(Auction_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Auction_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(Auction_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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

   public boolean isDouble( String str ){
        try{
          Double.parseDouble( str );
          return true;
        }catch( Exception e ){
          return false;
        }
   }
   public static java.sql.Timestamp getCurrentTimeStamp() {

            java.util.Date today = new java.util.Date();
            return new java.sql.Timestamp(today.getTime());

    }
}

