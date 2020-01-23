package Auction;

import Database.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
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


public class BidServlet extends HttpServlet {

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
     * @throws java.text.ParseException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, InstantiationException, SQLException, IllegalAccessException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding( "ISO-8859-7" );
        
        Connection conn = null;  
        PreparedStatement pst = null;  
        
        
        try (PrintWriter out = response.getWriter()) {
            response.setContentType("text/html");
                    
            RequestDispatcher rd;            
            String item_id1=request.getParameter("item_id1");
            String Bid=request.getParameter("bid");   
            String b_price=request.getParameter("b_pr"); 
            String currently=request.getParameter("cur"); 
            String username=request.getParameter("usrn");
            String EndDate=request.getParameter("ends");
            String auctionName = request.getParameter("auction_name");
            EndDate=EndDate.replace("T"," ");
            Timestamp t1=getCurrentTimeStamp();
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
            Date date = sdf.parse(EndDate);
            Timestamp ts1 = new Timestamp(date.getTime());
            
            if(t1.before(ts1))
            {
                int flag=0,message=-1;

                int item_id=Integer.parseInt(item_id1); 

                if(!isDouble(Bid))
                {
                    flag=1;
                    //auction_session.setAttribute("b_price_span","**Bid must not contain characters");
                    message=1;
                }else{               
                    if(Double.parseDouble(b_price) > 0)
                    {
                        if(Double.parseDouble(Bid) > Double.parseDouble(b_price))
                        {
                            flag=1;
                            //auction_session.setAttribute("b_price_span","**Bid must not be bigger than Buy Price");
                            message=3;
                        }
                        if(Double.parseDouble(Bid) == Double.parseDouble(b_price))
                        {
                            flag=2;
                            //auction_session.setAttribute("b_price_span","**Bid must not be bigger than Buy Price");
                        }

                    }              
                    if(message!=3)
                    {                     
                        if(Double.parseDouble(Bid) <= Double.parseDouble(currently))
                        {
                            flag=1;
                            //auction_session.setAttribute("b_price_span","**Bid must be bigger than Currently");
                            message=2;
                        }
                    }

                }

                HttpSession auction_session = request.getSession(true);

                DbConnection db = new DbConnection();
                conn = db.getConn();


                if(flag==1)
                {
                    auction_session.setAttribute("item_id",item_id1);
                    if(message==1)
                    {
                       out.println("<script type=\"text/javascript\">");  
                       out.println("alert('**Bid must not contain characters');");  
                       out.println("</script>"); 
                    }else if(message==2){
                        out.println("<script type=\"text/javascript\">");  
                       out.println("alert(' **Bid must be bigger than Currently');");                   
                       out.println("</script>"); 
                    }else if(message==3){ 
                        out.println("<script type=\"text/javascript\">");  
                        out.println("alert('**Bid must not be bigger than Buy Price');");  
                        out.println("</script>");
                    }
                    rd=request.getRequestDispatcher("profile_auction_bid.jsp"); 
                    rd.include(request,response);
                }else if(flag==0){
                    auction_session.setAttribute("item_id",item_id1);
                     //insert bid in BIDS table
                    pst = conn.prepareStatement("insert into TED.BIDS(USERNAME , TIME, AMOUNT, ITEM_ID)"+ 
                    "values ( ?, ?, ?, ?)");
                    pst.setString(1,username);
                    Timestamp t=getCurrentTimeStamp();
                    pst.setTimestamp(2,t);
                    pst.setDouble(3,Double.parseDouble(Bid));
                    pst.setInt(4, item_id);

                    pst.execute();                            

                    pst.close();

                    pst = conn.prepareStatement("update TED.AUCTIONS set CURRENTLY=?, NUMBER_OF_BIDS=NUMBER_OF_BIDS +1 where ITEM_ID=?");

                    pst.setDouble(1, Double.parseDouble(Bid));           
                    pst.setInt(2, item_id);

                    pst.executeUpdate();  
                    
                    StringBuilder sb = new StringBuilder();
                    pst = conn.prepareStatement("insert into TED.MESSAGES(SENDER , RECEIVER, THEME, CONTENT, TIME, TYPE)"+ 
                    "values ( ?, ?, ?, ?, ?, ?)");
                    pst.setString(1,"admin");
                    pst.setString(2,username);
                    pst.setString(3,"Auction Bid");                          
                    sb.append("There is a new bid on an auction with name ").append(auctionName).append(", which you have bidded before");
                    pst.setString(4,sb.toString());
                    t=getCurrentTimeStamp();
                    pst.setTimestamp(5,t); 
                    pst.setInt(6,2);

                    pst.execute();   

                    rd=request.getRequestDispatcher("profile_auction_bid.jsp"); 
                    rd.forward(request,response);
                }else{
                    auction_session.setAttribute("item_id",item_id1);
                     //insert bid in BIDS table
                    pst = conn.prepareStatement("insert into TED.BIDS(USERNAME , TIME, AMOUNT, ITEM_ID)"+ 
                    "values ( ?, ?, ?, ?)");
                    pst.setString(1,username);
                    Timestamp t=getCurrentTimeStamp();
                    pst.setTimestamp(2,t);
                    pst.setDouble(3,Double.parseDouble(Bid));
                    pst.setInt(4, item_id);

                    pst.execute();                            

                    pst.close();

                    pst = conn.prepareStatement("update TED.AUCTIONS set CURRENTLY=?, NUMBER_OF_BIDS=NUMBER_OF_BIDS +1 where ITEM_ID=?");

                    pst.setDouble(1, Double.parseDouble(Bid));           
                    pst.setInt(2, item_id);

                    pst.executeUpdate();  
                    out.println("<script type=\"text/javascript\">");  
                    out.println("alert('**You won the auction!!');");  
                    out.println("</script>");

                    rd=request.getRequestDispatcher("auction_management.jsp"); 
                    rd.include(request,response);
                }      
            }else{
                out.println("<script type=\"text/javascript\">");  
                out.println("alert('**Auction ended');");  
                out.println("</script>");

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
            Logger.getLogger(DateTimeServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(DateTimeServlet.class.getName()).log(Level.SEVERE, null, ex);
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

