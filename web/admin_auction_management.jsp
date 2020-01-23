<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Auction.JAXB"%>
<%@ page import="Database.DbConnection"%>
<!DOCTYPE html>
<html lang="en">
    <head> 
        <script>
            function myFunction() {
                if(confirm("Do you want to log out?")){
                    window.location="LogoutServlet";
                }
            }
        </script>
        <title>Auctions Management Page</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/auction_management.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="css/datatables.min.css"/>
        <script src="js/jquery-1.11.3.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
    </head>
    
    <body>
        <%
            //allow access only if session exists
            if(session.getAttribute("name") == null){
                response.sendRedirect("index.jsp");
            }
        %>
        <jsp:include page="login_menu.jsp" />
        
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">

                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="index.jsp">Home</a></li>
                        <li class="active">Auctions Management</li>
                    </ol>
                </div>
            </div>
            
            <div class="row">
                <div class="col-lg-12">                   
                    <a  class="breadcrumb" href="create_auction.jsp">Create Auction </a>
                    <h1>
                    </h1>
                </div>
            </div>
            
            <div class="row">
                <div class="col-lg-12">                   
                    <a  class="breadcrumb" href="JAXB_Servlet">Export To XML</a>
                    <h1>
                    </h1>
                </div>
            </div>
            
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#home">All Active Auctions</a></li>
                <li><a data-toggle="tab" href="#menu3">My Bids</a></li> 
                <li><a data-toggle="tab" href="#menu1">My Auctions-Edit</a></li>  
                <li><a data-toggle="tab" href="#menu2">My Inactive Auctions</a></li> 
                <li><a data-toggle="tab" href="#menu4">History</a></li>
                
            </ul>
            
            <div class="tab-content">
               
                <div id="home" class="tab-pane fade in active" style="height:500px; font:16px/26px Georgia, Garamond, Serif;overflow:auto;">
                     <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th class="th-sm">Item</th>
                                <th class="th-sm">Start Bid</th>
                                <th class="th-sm">Currently Bid</th>
                                <th class="th-sm">Buy Price</th>
                                <th class="th-sm">Start Time</th>
                                <th class="th-sm">End Time</th>
                                <th class="th-sm">Seller</th>

                              </th>
                            </tr>
                        </thead>
                        <tbody>
                    <%
                        boolean status = false; 
                        Connection conn = null;  
                        PreparedStatement pst = null; 
                        PreparedStatement pst2 = null; 
                        ResultSet rs = null;  

                        try {  
                            DbConnection db = new DbConnection();
                            conn = db.getConn();     
                            pst = conn.prepareStatement("select * from TED.AUCTIONS");  

                            Calendar calendar = Calendar.getInstance();
                            java.sql.Timestamp current_time = new java.sql.Timestamp(calendar.getTime().getTime());
                             rs = pst.executeQuery();  
                            while(rs.next())
                            {
                                if(current_time.after(rs.getTimestamp("STARTED")) && current_time.before(rs.getTimestamp("ENDS")) && rs.getDouble("CURRENTLY")!=rs.getDouble("BUY_PRICE"))                       
                                {                                   
                    %>
                    
                    
                            <tr>
                                <td>
                                    <a href="current_bids.jsp?item_id=<%=rs.getString("ITEM_ID")%>"> <%=rs.getString("NAME")%> </a>  
                                </td>
                                <td>
                                    <%=rs.getString("FIRST_BID")%>
                                </td>
                                 <% 
                                    if(rs.getString("CURRENTLY").equals(rs.getString("FIRST_BID"))){
                                %>
                                <td>
                                    -
                                </td>
                                <%
                                    }else{
                                %>
                                <td>
                                    <%=rs.getString("CURRENTLY")%>
                                </td>
                                <%  }
                                    if(rs.getString("BUY_PRICE").equals("0.0")){
                                %>
                                <td>
                                    -
                                </td>
                                <%
                                    }else{
                                %>
                                <td>
                                    <%=rs.getString("BUY_PRICE")%>
                                </td>
                                <%  }
                                %>
                                <td>
                                    <%=rs.getString("STARTED")%>
                                </td>
                                <td>
                                    <%=rs.getString("ENDS")%>
                                </td>
                                <td>
                                    <a href="profile_accepted.jsp?usr=<%=rs.getString("USERNAME")%>"> <%=rs.getString("USERNAME")%> </a>
                                </td>
                            </tr>
                        
                    
                                   
                    <%        }                     
                            }
                    %>
                        </tbody>
                    </table>
                </div>                                    
                 
                <div id="menu3" class="tab-pane fade" style="height:500px; font:16px/26px Georgia, Garamond, Serif;overflow:auto;">
                    <table id="myBids" class="table table-striped table-bordered" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th class="th-sm">Item</th>
                                <th class="th-sm">Expires</th>

                              </th>
                            </tr>
                        </thead>
                        <tbody>   
                    <%
                            pst2 = conn.prepareStatement("select * from TED.AUCTIONS a,TED.BIDS b where a.ITEM_ID=b.ITEM_ID and b.USERNAME='"+session.getAttribute("username")+"'"); 
                            rs = pst2.executeQuery();  
                            while(rs.next())
                            {
                                if(  current_time.before(rs.getTimestamp("ENDS")) )
                                {
                    %>
                    
                            <tr>
                                <td>
                                    <a href="current_bids.jsp?item_id=<%=rs.getString("ITEM_ID")%>"> <%=rs.getString("NAME")%> </a>  
                                </td>
                                <td>
                                    <%=rs.getString("ENDS")%>
                                </td>
                            </tr>
                                            
                    
                    <%
                                }
                            }
                    %>
                        </tbody>
                    </table>

                </div>
                <div id="menu1" class="tab-pane fade" style="height:500px; font:16px/26px Georgia, Garamond, Serif;overflow:auto;">
                    <table id="inactiveAuction" class="table table-striped table-bordered" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th class="th-sm">Item</th>                          

                              </th>
                            </tr>
                        </thead>
                        <tbody>   
                    <%
                            rs = pst.executeQuery();  
                            while(rs.next())
                            {
                                if(rs.getString("USERNAME").equals(session.getAttribute("username")) && (current_time.before(rs.getTimestamp("STARTED"))||
                                        rs.getInt("NUMBER_OF_BIDS")==0 && current_time.before(rs.getTimestamp("ENDS")) ||
                                        rs.getTimestamp("STARTED").equals(rs.getTimestamp("ENDS"))))
                                {
                    %>
                    
                            <tr>
                                <td>
                                    <a href="profile_auction_update_delete.jsp?item_id=<%=rs.getString("ITEM_ID")%>"> <%=rs.getString("NAME")%> </a>  
                                </td>
                            </tr>
                                            
                    
                    <%
                                }
                            }
                    %>
                        </tbody>
                    </table>

                </div>
                <div id="menu2" class="tab-pane fade" style="height:500px; font:16px/26px Georgia, Garamond, Serif;overflow:auto;">
                    <table id="inactiveAuctionStart" class="table table-striped table-bordered" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th class="th-sm">Item</th>                          

                              </th>
                            </tr>
                        </thead>
                        <tbody>   
                <%
                          rs = pst.executeQuery();  
                          while(rs.next())
                          {
                              if(rs.getString("USERNAME").equals(session.getAttribute("username")) && 
                                    rs.getTimestamp("STARTED").equals(rs.getTimestamp("ENDS")))
                              {
                  %>

                            <tr>
                                <td>
                                    <a href="profile_auction_start.jsp?item_id=<%=rs.getString("ITEM_ID")%>"> <%=rs.getString("NAME")%> </a>  
                                </td>
                            </tr>
                        
                    
                   
                    
                    <%
                              }
                          }
                        
                    %>
                 
                    </tbody>
                 </table>
            </div> 
             <div id="menu4" class="tab-pane fade" style="height:500px; font:16px/26px Georgia, Garamond, Serif;overflow:auto;">
                    <table id="history" class="table table-striped table-bordered" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th class="th-sm">Item</th>

                              </th>
                            </tr>
                        </thead>
                        <tbody>   
                    <%
                            pst2 = conn.prepareStatement("select * from TED.AUCTIONS a where a.BUYER='"+session.getAttribute("username")+"'"); 
                            rs = pst2.executeQuery();  
                            while(rs.next())
                            {
                                
                    %>
                    
                            <tr>
                                <td>
                                    <a href="profile_auction.jsp?item_id=<%=rs.getString("ITEM_ID")%>"> <%=rs.getString("NAME")%> </a>  
                                </td>
                                
                            </tr>
                                            
                    
                    <%
                                
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
                        </tbody>
                    </table>

            </div>
            <footer>
                <div class="row">
                    <div class="col-lg-12">
                        <p>Copyright &copy; Your Website 2019</p>
                    </div>
                </div>
            </footer> 
        </div>
    </body>
    <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/datatables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#dtBasicExample').DataTable({
                responsive: true
            });
            $('#inactiveAuction').DataTable({
                responsive: true
            });
            $('#inactiveAuctionStart').DataTable({
                responsive: true
            });
            $('#myBids').DataTable({
                responsive: true
            });
            $('#history').DataTable({
                responsive: true
            });
            $('.dataTables_length').addClass('bs-select');
        });
    </script>
</html>
