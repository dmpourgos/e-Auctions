<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Database.DbConnection"%>
<!DOCTYPE html>
<html>
    <head>
        <script>
            function myFunction() {
                if(confirm("Do you want to log out?")){
                    window.location="LogoutServlet";
                }
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <link href="css/current_bids.css" rel="stylesheet" type="text/css"/>
      
        <script src="js/jquery-1.11.3.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <title>Current Bids</title>
    </head>
    <body>
        <%
        //allow access only if session exists
        if(session.getAttribute("name") == null){
            response.sendRedirect("index.jsp");
        }
        %>
       <jsp:include page="login_menu.jsp"/>
       <%@page import="java.sql.*" %>
   
       <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">

                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="auction_management.jsp">Auctions Management</a></li>
                        <li class="active">Current Bids</li>
                    </ol>
                </div>
            </div>
            
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#home">Current Bids</a></li>                
            </ul>
            <div class="tab-content">
                    
                <div id="home" class="tab-pane fade in active" style="height:500px; ">
                    

                    <%
                        boolean status = false; 
                        Connection conn = null;  
                        PreparedStatement pst = null;  
                        ResultSet rs = null;  

                      
                        String id=request.getParameter("item_id");
                        try {  
                            DbConnection db = new DbConnection();
                            conn = db.getConn();  
                            pst = conn.prepareStatement("select * from TED.BIDS where ITEM_ID=? order by TIME"); 
                            pst.setInt(1, Integer.parseInt(id));

                            rs = pst.executeQuery();
                            
                            if(rs.next())
                            {
                    %>
                    
                    <fieldset class="row1" style="font:16px/26px Georgia, Garamond, Serif; overflow:auto;">
                         <div class="column">
                             <a> USERNAME</a> 
                         </div>
                         <div class="column">
                              <a> TIME</a>
                         </div>
                         <div class="column">
                              <a>AMOUNT</a> 
                         </div>
                    </fieldset>
                    
                    
                    <fieldset class="row1">
                        <div class="column">
                            <a> <%=rs.getString("USERNAME")%></a> 
                        </div>
                        <div class="column">
                             <a> <%=rs.getTimestamp("TIME")%></a>
                        </div>
                        <div class="column">
                             <a> <%=rs.getDouble("AMOUNT")%> &nbsp; $</a> 
                        </div>
                    </fieldset>
                    
                    <%
                            }else{
                    %>
                    
                    
                    <fieldset class="row1">
                        <h3>
                            There are no bids on this item
                        </h3>
                    </fieldset>
                    
                    <%
                            }
                            while(rs.next())
                            {

                     %>


                    <fieldset class="row1">
                        <div class="column">
                            <a> <%=rs.getString("USERNAME")%></a> 
                        </div>
                        <div class="column">
                             <a> <%=rs.getTimestamp("TIME")%></a>
                        </div>
                        <div class="column">
                             <a> <%=rs.getDouble("AMOUNT")%> &nbsp; $</a> 
                        </div>
                    </fieldset>


                    <%
                            }
                            pst = conn.prepareStatement("select USERNAME from TED.AUCTIONS where ITEM_ID=?"); 
                            pst.setInt(1, Integer.parseInt(id));

                            rs = pst.executeQuery();
                            
                            if(rs.next())
                            {
                                if(rs.getString(1).equals((String)session.getAttribute("username")))
                                {
                    %>
                        
                                    </div>

                                    <div>
                                        <a class="link" href="profile_auction.jsp?item_id=<%=Integer.parseInt(id)%>">Go to item's profile >></a>
                                    </div> 
                    <%      
                                }else{
                     %>
                                    <div>

                                        <a class="link" href="profile_auction_bid.jsp?item_id=<%=Integer.parseInt(id)%>">Bid this item >></a>
                                    </div>   
                     <%
                                }
                            }
                        }catch (Exception e) {  
                           System.out.println(e);  
                        }finally {  
                            if (conn != null) {  
                                try {  
                                    conn.close();  
                                } catch (SQLException e) {  
                                    e.printStackTrace();  
                                }  
                            }  
                            if (pst != null) {  
                                try {  
                                    pst.close();  
                                } catch (SQLException e) {  
                                    e.printStackTrace();  
                                }  
                            }  
                            if (rs != null) {  
                                try {  
                                    rs.close();  
                                } catch (SQLException e) {  
                                    e.printStackTrace();  
                                }  
                            }  
                        }  
                       %>

                
                       
            <footer>
                <div class="row">
                    <div class="col-lg-12">
                        <p>Copyright &copy; Your Website 2019</p>
                    </div>
                </div>
            </footer> 
        </div>
    </body>
</html>
