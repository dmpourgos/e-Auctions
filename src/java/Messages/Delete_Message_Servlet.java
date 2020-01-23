package Messages;

import Database.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Delete_Message_Servlet extends HttpServlet {

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
     * @throws java.lang.IllegalAccessException
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        
        Connection conn = null;  
        PreparedStatement pst = null;  
     
        
        try (PrintWriter out = response.getWriter()) {
            response.setContentType("text/html");
                                                
            RequestDispatcher rd;          
            HttpSession session = request.getSession(true);
                     
            String msg=request.getParameter("msg_id");
            String send=request.getParameter("send");
            String recv=request.getParameter("recv");
            
            DbConnection db = new DbConnection();
            conn = db.getConn();
                    
               
               if(send.equals((String)session.getAttribute("username")))
               {
                    pst = conn.prepareStatement("update TED.MESSAGES set DELETED_SENDER=1 where MESSAGE_ID=?");

                    pst.setString(1, msg);
                    
                    pst.executeUpdate();   
                    pst.close();               
               }else{
                   pst = conn.prepareStatement("update TED.MESSAGES set DELETED_RECEIVER=1 where MESSAGE_ID=?");

                    pst.setString(1, msg);
                    
                    pst.executeUpdate();   
                    pst.close();              
               }
               
                //------------------------------------------------------------------
                                                             
                request.getRequestDispatcher("message.jsp").forward(request,response);                        
            
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
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException ex) {
            Logger.getLogger(Delete_Message_Servlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException ex) {
            Logger.getLogger(Delete_Message_Servlet.class.getName()).log(Level.SEVERE, null, ex);
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

}
