package Auction;

import Database.DbConnection;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;


@MultipartConfig 
public class AddImageServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     * @throws java.lang.ClassNotFoundException
     * @throws java.lang.InstantiationException
     * @throws java.lang.IllegalAccessException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        response.setContentType("text/html;charset=UTF-8");
        Connection conn = null;  
        PreparedStatement pst = null; 
        
        try (PrintWriter out = response.getWriter()) {
             RequestDispatcher rd;
             
            DbConnection db = new DbConnection();
            conn = db.getConn();
             HttpSession session = request.getSession(true);
             String item_id=request.getParameter("item_id");      
             
             InputStream inputStream = null; // input stream of the upload file

            // obtains the upload file part in this multipart request
            for (Part filePart : request.getParts()) {
                if(!"application/octet-stream".equals(filePart.getContentType())){
                    
                    if (filePart != null && filePart.getContentType()!=null) {

                        // obtains input stream of the upload file
                        inputStream = filePart.getInputStream();

                        if (inputStream != null) {

                            pst = conn.prepareStatement("insert into TED.IMAGES(ITEM_ID , IMAGE, CONTENT_TYPE,CONTENT_LENGTH)"+ 
                            "values ( ?, ?,?,?)");
                            pst.setString(1,item_id);

                            // fetches input stream of the upload file for the blob column
                            pst.setBlob(2, inputStream);

                            pst.setString(3,filePart.getContentType());

                            pst.setDouble(4, filePart.getSize());
                            pst.execute(); 
                            pst.close();
                        }
                    }
                }
            }
            session.setAttribute("item_id",item_id);
            rd=request.getRequestDispatcher("UpdateImages.jsp"); 
            rd.forward(request,response);
            
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
        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException ex) {
            Logger.getLogger(Auction_Image_Servlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException ex) {
            Logger.getLogger(Auction_Image_Servlet.class.getName()).log(Level.SEVERE, null, ex);
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
