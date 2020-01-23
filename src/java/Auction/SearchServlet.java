package Auction;


import Database.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SearchServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     * @throws java.lang.InstantiationException
     * @throws java.lang.IllegalAccessException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding( "ISO-8859-7" );
       
        
        Connection conn = null;  
        PreparedStatement pst=null;  
        
        
        try (PrintWriter out = response.getWriter()) {
            RequestDispatcher rd;
                    
            String from_amount=request.getParameter("from_amount");
            String to_amount=request.getParameter("to_amount");
            String country=request.getParameter("country");
            String description=request.getParameter("description");
            String category=request.getParameter("category");
            String str;
            Double d1=-1.0,d2=-1.0;          
            
            if(!from_amount.equals(""))
            {
                d1=Double.parseDouble(from_amount);
            }
            
            if(!to_amount.equals(""))
            {
                d2=Double.parseDouble(to_amount);
            }
          
            if((!IsNumeric(from_amount) && !from_amount.equals(""))|| (!IsNumeric(to_amount) && !to_amount.equals(""))){
             //alert  
                //out.println("boo2");  
                out.println("<script type=\"text/javascript\">");  
                out.println("alert('Error! Amount contains characters');");  
                out.println("</script>");
                rd=request.getRequestDispatcher("search.jsp");    
                rd.include(request,response);  
            }else if(d1!=-1.0 && d2!=-1.0 && d1>d2){
                //alert
                
                //out.println("boo3");  
                out.println("<script type=\"text/javascript\">");  
                out.println("alert('Error! From_Amount is greater than To_Amount');");  
                out.println("</script>");
                rd=request.getRequestDispatcher("search.jsp");    
                rd.include(request,response);  
            }else{                 
                Calendar calendar = Calendar.getInstance();
                java.sql.Timestamp current_time = new java.sql.Timestamp(calendar.getTime().getTime());
                
                HttpSession session = request.getSession(true);
                
                session.setAttribute("from_amount", from_amount);
                session.setAttribute("to_amount", to_amount);
                session.setAttribute("country", country);
                session.setAttribute("description", description);
                session.setAttribute("category", category);
                session.setAttribute("Results_per_page", request.getParameter("Results_per_page"));
                
                DbConnection db = new DbConnection();
                conn = db.getConn();
                ResultSet rs;
                ResultSet rs2;
                pst = conn.prepareStatement("select * from TED.AUCTIONS");  
                
                rs = pst.executeQuery();  
                int count=0;
                while(rs.next())
                {
                    if(!category.equals("Select Category"))
                    {
                        pst = conn.prepareStatement("select * from TED.ITEM_TO_CATEGORY where ITEM_ID=? and CATEGORY=?");
                        pst.setString(1, rs.getString("ITEM_ID"));
                        pst.setString(2, category);
                        rs2 = pst.executeQuery();
                        if(!rs2.next())
                        {
                            continue;
                        }
                    }
                    
                    if(!country.equals(""))
                    {
                        if(!country.equals(rs.getString("COUNTRY")))
                        {
                            continue;
                        }
                    }
                    
                    if(!description.equals(""))
                    {
                        str=rs.getString("DESCRIPTION");
                        if(!str.contains(description))
                        {
                            continue;
                        }
                    }
                    
                    if(!from_amount.equals(""))
                    {
                        if(d1>rs.getDouble("CURRENTLY"))
                        {
                            continue;
                        }
                    }
                    
                    if(!to_amount.equals(""))
                    {
                        if(d2<rs.getDouble("CURRENTLY"))
                        {
                            continue;
                        }
                    }
                    if(current_time.after(rs.getTimestamp("STARTED")) && current_time.before(rs.getTimestamp("ENDS"))&& rs.getDouble("CURRENTLY")!=rs.getDouble("BUY_PRICE"))                       
                    {
                         count++; 
                    }
                  //
                }
                
                session.setAttribute("count", Integer.toString(count));
                //recommendations NN Collaborative Filtering
                //------------------------------------------------------------------------------------------------------------------
                if(session.getAttribute("username")!=null)
                {
                    String username=(String)session.getAttribute("username");
                    count=0;
                    List<Integer> myBids;
                    Vector<String> Users=new Vector<String>();
                    Vector<Integer> Users_count=new Vector();
                    myBids = new ArrayList();
                    pst = conn.prepareStatement("select distinct ITEM_ID from TED.BIDS where USERNAME=?");  
                    pst.setString(1, username);   

                    rs = pst.executeQuery(); 
                    while(rs.next())
                    {
                        myBids.add((int)rs.getInt("ITEM_ID"));
                        pst = conn.prepareStatement("select distinct USERNAME from TED.BIDS where ITEM_ID=?");  
                        pst.setInt(1, rs.getInt("ITEM_ID"));   

                        rs2 = pst.executeQuery(); 
                        
                        while(rs2.next())
                        {
                            if(!rs2.getString(1).equals(username))
                            {
                                int n=Users.indexOf(rs2.getString(1));
                                if(n==-1)
                                {
                                    Users.add(rs2.getString(1));
                                    Users_count.add(1);
                                }else{
                                    int number=Users_count.get(n)+1;
                                    Users_count.set(n,number);
                                }
                            }
                        }
                    }

                    Vector<String> TopUsers=new Vector();
                                      
                    for(int i=0;i<20;++i)
                    {
                        int max=-1,position=0;
                        for(int j=0;j<Users_count.size();++j)
                        {
                            if(Users_count.get(j)>max)
                            {
                                max=Users_count.get(j);
                                position=j;
                            }
                        }
                        if(max==-1)
                        {
                            break;
                        }
                        TopUsers.add(Users.get(position));
                        Users_count.set(position, -1);
                    }
                                      
                    
                    Vector<TopAuctions> topAuctions=new Vector();
                    count=0;
                    int flag=0;
                    for(int i=0;i<TopUsers.size();++i)
                    {
                        pst = conn.prepareStatement("select distinct ITEM_ID from TED.BIDS where USERNAME=?");  
                        pst.setString(1, TopUsers.get(i));   
                        rs = pst.executeQuery(); 
                        while(rs.next())
                        {
                            //elegxos gia items pou den exoun ginei bid apo ton user
                            pst = conn.prepareStatement("select * from TED.BIDS where USERNAME=? and ITEM_ID=?");  
                            pst.setString(1, username);   
                            pst.setInt(2, rs.getInt(1));
                            rs2 = pst.executeQuery();
                            if(!rs2.next())
                            {
                                pst = conn.prepareStatement("select * from TED.AUCTIONS where ITEM_ID=?");    
                                pst.setInt(1, rs.getInt(1));
                                rs2 = pst.executeQuery();
                                if(rs2.next())
                                {//elegxos gia energo auction
                                    if(!username.equals(rs2.getString("USERNAME")))
                                    {
                                        if(current_time.before(rs2.getTimestamp("STARTED")) && rs2.getDouble("CURRENTLY")!=rs2.getDouble("BUY_PRICE") ||
                                        current_time.after(rs2.getTimestamp("STARTED")) && current_time.before(rs2.getTimestamp("ENDS"))&& rs2.getDouble("CURRENTLY")!=rs2.getDouble("BUY_PRICE"))                       
                                        {
                                            //elegxos an einai sta top Auctions
                                            int exists=0;
                                            TopAuctions auction=new TopAuctions(rs2.getInt("ITEM_ID"),rs2.getString("NAME"));
                                            for(int ii=0;ii<topAuctions.size();++ii)
                                            {
                                                if(topAuctions.get(ii).id == auction.id)
                                                {
                                                    exists=1;
                                                    break;
                                                }
                                            }
                                            if(exists==0)
                                            {
                                                topAuctions.add(auction);
                                                count++;
                                                if(count==20)
                                                {
                                                    flag=1;
                                                    break;
                                                } 
                                            }                                           
                                        } 
                                    }
                                }
                            }
                        }
                        if(flag==1)
                        {
                            break;
                        }
                    } 
                    session.setAttribute("TopAuctions", topAuctions);
                    /*for(int i=0;i<topAuctions.size();++i)//axristo
                    {
                        out.println(topAuctions.get(i).name);
                       
                    }*/
                }
                
                //------------------------------------------------------------------------------------------------------------------
                
                rd=request.getRequestDispatcher("results.jsp");    
                rd.forward(request,response); 
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | SQLException | InstantiationException | IllegalAccessException ex) {
            Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException | SQLException | InstantiationException | IllegalAccessException ex) {
            Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
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
