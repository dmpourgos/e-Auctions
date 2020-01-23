package Auction;

import static Auction.DateTimeServlet.getCurrentTimeStamp;
import Database.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UpdateServlet extends HttpServlet {

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
     * @throws java.lang.IllegalAccessException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, InstantiationException, SQLException, IllegalAccessException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding( "ISO-8859-7" );
        
        Connection conn = null;  
        PreparedStatement pst = null;           
        
        try (PrintWriter out = response.getWriter()) {
            response.setContentType("text/html");
            
            int flag=0;
            int size,size1;
            ResultSet rs = null;  
                        
            RequestDispatcher rd;
            
            String item_id1=request.getParameter("item_id1");
            String s=request.getParameter("count");
            String name=request.getParameter("rname");
            String b_price=request.getParameter("b_price");
            String f_bid=request.getParameter("f_bid");            
            String[] category=request.getParameterValues("category"); 
            String country=request.getParameter("country");
            String country1=request.getParameter("country1");
            String latitude=request.getParameter("latitude");
            String location=request.getParameter("location");
            String longitude=request.getParameter("longitude");
            String desc=request.getParameter("desc");            
            
            int item_id=Integer.parseInt(item_id1);
            HttpSession auction_session = request.getSession(true);
            DbConnection db = new DbConnection();
            conn = db.getConn();
            
            pst = conn.prepareStatement("select * from TED.AUCTIONS where ITEM_ID=?");  
            pst.setInt(1, item_id);   
  
            rs = pst.executeQuery();  
            rs.next();
            if(Integer.parseInt(rs.getString("number_of_bids"))==0)
            {
           
                size1=Integer.parseInt(s);
                if(category==null)
                {
                    size=0;
                }else{
                    size=category.length;
                }
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
                            if(Double.parseDouble(b_price)!=0)
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


                    pst = conn.prepareStatement("update TED.AUCTIONS set NAME=?, FIRST_BID=? ,BUY_PRICE=? ,COUNTRY=?, LOCATION=?, LATITUDE=?, LONGITUDE=? , DESCRIPTION=? where ITEM_ID=?");

                    pst.setString(1, name);
                    pst.setDouble(2, Double.parseDouble(f_bid));
                     if("".equals(b_price)) {
                        pst.setDouble(3,0);
                    }else {
                        pst.setDouble(3, Double.parseDouble(b_price));
                    }    
                    if(country==null)
                    {
                        pst.setString(4, country1);
                    }else if("".equals(country)){
                        pst.setString(4, country1);
                    }else{
                        pst.setString(4, country);
                    }  
                    pst.setString(5, location);
                    if("".equals(latitude)) {
                        pst.setDouble(6,0);
                    }else {
                        pst.setDouble(6, Double.parseDouble(latitude));
                    }
                     if("".equals(longitude)) {
                        pst.setDouble(7,0);
                    }else {
                        pst.setDouble(7, Double.parseDouble(longitude));
                    }                           
                    pst.setString(8, desc);
                    pst.setInt(9, item_id);

                    pst.executeUpdate();   
                    pst.close();

                    //------------------------------------------------------------------
                    if(size>0)
                    {
                        //delete categories of the item

                        pst = conn.prepareStatement("delete from TED.ITEM_TO_CATEGORY where ITEM_ID=?");                 
                        pst.setInt(1,item_id);   
                        pst.executeUpdate(); 


                        pst.close();

                        for(int i=0;i<size;++i)
                        {
                             pst = conn.prepareStatement("insert into TED.ITEM_TO_CATEGORY(ITEM_ID , CATEGORY)"+ 
                            "values ( ?, ?)");
                            pst.setInt(1,item_id);
                            pst.setString(2, category[i]);

                            pst.execute(); 

                        }



                    }

                    auction_session.setAttribute("item_id",item_id1);
                    request.getRequestDispatcher("profile_auction_update_delete.jsp").forward(request,response); 


                }else{
                    auction_session.setAttribute("item_id",item_id1);
                    rd=request.getRequestDispatcher("profile_auction_update_delete.jsp"); 
                    rd.include(request,response);
                }
            }else{
                out.println("<script type=\"text/javascript\">");  
                out.println("alert('**A Bid has been made! Updates cannot be done!');");  
                out.println("</script>"); 
                auction_session.setAttribute("item_id",item_id1);
                rd=request.getRequestDispatcher("auction_management.jsp"); 
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
        } catch (ClassNotFoundException | InstantiationException | SQLException | IllegalAccessException ex) {
            Logger.getLogger(Auction_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(UpdateServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException | InstantiationException | SQLException | IllegalAccessException ex) {
            Logger.getLogger(Auction_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(UpdateServlet.class.getName()).log(Level.SEVERE, null, ex);
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

