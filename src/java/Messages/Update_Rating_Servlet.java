package Messages;

import Auction.Auction_Servlet;
import Database.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Update_Rating_Servlet extends HttpServlet {

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
            throws ServletException, IOException, ClassNotFoundException, InstantiationException, SQLException, IllegalAccessException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding( "ISO-8859-7" );
        
        Connection conn = null;  
        PreparedStatement pst = null;  
         
        
        try (PrintWriter out = response.getWriter()) {
            response.setContentType("text/html");
            
            int flag=0,message=0;         
                        
            RequestDispatcher rd;
            
            HttpSession auction_session = request.getSession(true);
            
            String rating=request.getParameter("rating");
            String type1=request.getParameter("type");
            String person=request.getParameter("person");
            String msg=request.getParameter("msg");
                  
           
            int type=Integer.parseInt(type1);
            
            DbConnection db = new DbConnection();
            conn = db.getConn();
            
            if(!isDouble(rating))
            {
                flag=1;
                message=1;
                //auction_session.setAttribute("f_bid_span","**First Bid must not contain characters");
            }else{
                if(Integer.parseInt(rating)<-10 || Integer.parseInt(rating)>10)
                {
                    flag=1;
                    message=2;
                }             
            }
            
            
            
            if(flag==0)
            {
               
               if(type==1)
               {
                    pst = conn.prepareStatement("update TED.USERS set  S_RATING=S_RATING+? where USERNAME=?");

                    pst.setInt(1, Integer.parseInt(rating));
                    pst.setString(2, person);
                    
                    pst.executeUpdate();   
                    pst.close();
               }else{
                    pst = conn.prepareStatement("update TED.USERS set  B_RATING=B_RATING+? where USERNAME=?");

                    pst.setInt(1, Integer.parseInt(rating));
                    pst.setString(2, person);
                    
                    pst.executeUpdate();   
                    pst.close();
               }
               
                pst = conn.prepareStatement("update TED.MESSAGES set TYPE=2 where MESSAGE_ID=?");

                pst.setInt(1, Integer.parseInt(msg));

                pst.executeUpdate();   
                pst.close();
                //------------------------------------------------------------------
                                                             
                request.getRequestDispatcher("message.jsp").forward(request,response); 
                
                
            }else{
                auction_session.setAttribute("message_id",msg);
                if(message==1)
                {
                   out.println("<script type=\"text/javascript\">");  
                   out.println("alert('**Rating must not contain characters');");  
                   out.println("</script>"); 
                }else if(message==2){
                    out.println("<script type=\"text/javascript\">");  
                   out.println("alert(' **Rating must not be bigger than 10 or less than -10!');");                   
                   out.println("</script>"); 
                }
                rd=request.getRequestDispatcher("profile_message.jsp"); 
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

