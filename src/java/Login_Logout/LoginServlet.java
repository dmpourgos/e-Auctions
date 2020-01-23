package Login_Logout;

import UserOp.UserDto;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;  
import javax.servlet.RequestDispatcher;

public class LoginServlet extends HttpServlet {

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
        
        UserDto usr=null;
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            response.setContentType("text/html");      

            String n=request.getParameter("username");    
            String p=request.getParameter("password");   
            HttpSession session = request.getSession(false);
            if(session!=null)  
                session.setAttribute("username", n);  
            
            usr=LoginDAO.validate(n, p);
            
            if(usr.getFlag()==1){
                if(session!=null)
                {
                    session.setAttribute("name", usr.getUser().getName()); 
                    session.setAttribute("surname", usr.getUser().getSurname());                 
                    session.setAttribute("email", usr.getUser().getEmail());                 
                    session.setAttribute("phone", usr.getUser().getPhone());                   
                    session.setAttribute("city", usr.getUser().getCity());                   
                    session.setAttribute("address", usr.getUser().getAddress());                  
                    session.setAttribute("number", usr.getUser().getNumber());                  
                    session.setAttribute("tk", usr.getUser().getTk());                  
                    session.setAttribute("infos", usr.getUser().getInfos());                  
                    session.setAttribute("afm", usr.getUser().getAfm());                 
                    session.setAttribute("country", usr.getUser().getCountry());   
                    session.setAttribute("role", usr.getUser().getRole());
                    session.setAttribute("location", usr.getUser().getLocation());
                    session.setAttribute("s_rating", usr.getUser().getSRating());
                    session.setAttribute("b_rating", usr.getUser().getBRating());
                }
                RequestDispatcher rd=request.getRequestDispatcher("index_login.jsp");    
                rd.forward(request,response);    
            }else if(usr.getFlag()==0){
                RequestDispatcher rd=request.getRequestDispatcher("sign_up_conf.jsp");    
                rd.include(request,response);  
            }else if(usr.getFlag()==2){
                if(session!=null)
                {
                    session.setAttribute("name", usr.getUser().getName()); 
                    session.setAttribute("surname", usr.getUser().getSurname());                 
                    session.setAttribute("email", usr.getUser().getEmail());                 
                    session.setAttribute("phone", usr.getUser().getPhone());                   
                    session.setAttribute("city", usr.getUser().getCity());                   
                    session.setAttribute("address", usr.getUser().getAddress());                  
                    session.setAttribute("number", usr.getUser().getNumber());                  
                    session.setAttribute("tk", usr.getUser().getTk());                  
                    session.setAttribute("infos", usr.getUser().getInfos());                  
                    session.setAttribute("afm", usr.getUser().getAfm());                 
                    session.setAttribute("country", usr.getUser().getCountry());   
                    session.setAttribute("role", usr.getUser().getRole());
                    session.setAttribute("location", usr.getUser().getLocation());
                    session.setAttribute("s_rating", usr.getUser().getSRating());
                    session.setAttribute("b_rating", usr.getUser().getBRating());
                }
                RequestDispatcher rd=request.getRequestDispatcher("admin_home_page.jsp");    
                rd.forward(request,response);   
            }else if(usr.getFlag()==-1){    
                out.println("<script type=\"text/javascript\">");  
                out.println("alert('Wrong username or password!');");  
                out.println("</script>");
                RequestDispatcher rd=request.getRequestDispatcher("login.jsp");    
                rd.include(request,response);    
            }   
            out.close();    
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
