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


public class DateTimeServlet extends HttpServlet {

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
            String StartDate=request.getParameter("start");    
            StartDate=StartDate.replace("T"," ");
            String EndDate=request.getParameter("ends");
            EndDate=EndDate.replace("T"," ");
            int item_id=Integer.parseInt(item_id1); 
            
            HttpSession auction_session = request.getSession(true);
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
            Date date = sdf.parse(StartDate);
            Timestamp ts1 = new Timestamp(date.getTime());
            
            Date date2 = sdf.parse(EndDate);
            Timestamp ts2 = new Timestamp(date2.getTime());
            Timestamp t=getCurrentTimeStamp();
            
            DbConnection db = new DbConnection();
            conn = db.getConn();
            
            if(t.before(ts1))
            {
                if(ts1.after(ts2))
                {
                    auction_session.setAttribute("item_id",item_id1);
                    out.println("<script type=\"text/javascript\">");  
                    out.println("alert('End Time is before Start Time');");  
                    out.println("</script>");
                    rd=request.getRequestDispatcher("profile_auction_start.jsp"); 
                    rd.include(request,response);
                }else{
                     //update started ends in AUCTIONS
                    pst = conn.prepareStatement("update TED.AUCTIONS set STARTED=?, ENDS=? where ITEM_ID=?");
                    pst.setTimestamp(1,ts1);
                    pst.setTimestamp(2, ts2);
                    pst.setInt(3, item_id);

                    pst.executeUpdate(); 

                    rd=request.getRequestDispatcher("auction_management.jsp"); 
                    rd.forward(request,response);
                }      
            }else{
                auction_session.setAttribute("item_id",item_id1);
                out.println("<script type=\"text/javascript\">");  
                out.println("alert('Start Time is before Current Time');");  
                out.println("</script>");
                rd=request.getRequestDispatcher("profile_auction_start.jsp"); 
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

