package SignUp;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import UserOp.UserHelper;
import UserOp.Users;

public class SignUpServlet extends HttpServlet {

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
        request.setCharacterEncoding( "ISO-8859-7" );
        
        //Open a connection to database
        Connection conn = null;  
        PreparedStatement pst = null;  
        EntityManagerFactory emfactory = null;
      
        EntityManager entitymanager = null;
        RequestDispatcher rd;
  
        emfactory = Persistence.createEntityManagerFactory( "Eclipselink_JPA" );
              
        try(PrintWriter out = response.getWriter()) {
            response.setContentType("text/html");
                
            
      
            entitymanager = emfactory.createEntityManager( );
            entitymanager.getTransaction( ).begin( );

            //Fill the user object with parameters from signup web page
            Users usr = new Users();
            usr.setUsername(request.getParameter("username"));
            usr.setPassword(request.getParameter("password"));
            usr.setName(request.getParameter("name"));
            usr.setAfm(request.getParameter("afm"));
            usr.setEmail(request.getParameter("email"));
            usr.setSurname(request.getParameter("surname"));
            usr.setPhone(request.getParameter("phone"));
            usr.setCity(request.getParameter("city"));
            usr.setAddress(request.getParameter("address"));
            usr.setTk(Integer.parseInt(request.getParameter("tk")));
            usr.setNumber(Integer.parseInt(request.getParameter("number")));
            usr.setCountry(request.getParameter("country"));
            usr.setLocation(request.getParameter("location"));
            usr.setInfos(1);
            usr.setRole(2);
            
            //validation of web page parametrs
            UserHelper usrHelper = usr.validate(entitymanager, request);
            HttpSession signupSession = usrHelper.getSession();

            //If parameter are safe then 
            if(usrHelper.isIsValidate() == true)
            {
                
                //insert into database
                
                entitymanager.persist( usr );
                entitymanager.getTransaction( ).commit( );
                
                //redirect to next web page
                rd=request.getRequestDispatcher("sign_up_conf.jsp"); 
                rd.forward(request,response);
                
                //remove session details
                signupSession.removeAttribute("username_span");
                signupSession.removeAttribute("password_span");
                signupSession.removeAttribute("name_span");
                signupSession.removeAttribute("surname_span");
                signupSession.removeAttribute("address_span");
                signupSession.removeAttribute("tk_span");
                signupSession.removeAttribute("number_span");
                signupSession.removeAttribute("afm_span");
                signupSession.removeAttribute("email_span"); 
                signupSession.removeAttribute("phone_span");
                signupSession.removeAttribute("color");
                signupSession.removeAttribute("password1");
                signupSession.invalidate();
            }else{
                signupSession.setAttribute("username", usr.getUsername());
                signupSession.setAttribute("password", usr.getPassword());
                signupSession.setAttribute("name1", usr.getName());
                signupSession.setAttribute("afm", usr.getAfm());
                signupSession.setAttribute("email", usr.getEmail());
                signupSession.setAttribute("surname", usr.getSurname());
                signupSession.setAttribute("phone", usr.getPhone());
                signupSession.setAttribute("address", usr.getAddress());
                signupSession.setAttribute("tk", usr.getTk());
                signupSession.setAttribute("number", usr.getNumber());
                signupSession.setAttribute("location", usr.getLocation());
                rd=request.getRequestDispatcher("signup.jsp"); 
                rd.include(request,response);
            }
            out.close();
            
        }catch ( IOException e) {  
            Logger.getLogger(SignUpServlet.class.getName()).log(Level.SEVERE, null, e);
        }finally {
            if (conn != null) {  
                try {  
                    conn.close();  
                } catch (SQLException e) {  
                    Logger.getLogger(SignUpServlet.class.getName()).log(Level.SEVERE, null, e);
                }  
            }  
            if (pst != null) {  
                try {  
                    pst.close();  
                } catch (SQLException e) {  
                    Logger.getLogger(SignUpServlet.class.getName()).log(Level.SEVERE, null, e);
                }  
            } 
            if(entitymanager != null){
                entitymanager.close( );
            }
            if(emfactory != null){
                emfactory.close( );
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
            Logger.getLogger(SignUpServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(SignUpServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(SignUpServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(SignUpServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SignUpServlet.class.getName()).log(Level.SEVERE, null, ex);
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

    private boolean IsNumeric(String str) {
        return str.matches("^[-+]?\\d+(\\.\\d+)?$");
    }
}
