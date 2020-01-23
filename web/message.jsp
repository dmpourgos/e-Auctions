<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
        <title>Message Management Page</title>
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
                        <li><a href="index.jsp">Home</a>
                        </li>
                        <li class="active">Message Management Page</li>
                    </ol>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">                   
                    <a  class="breadcrumb" href="createNewMessage.jsp">New Message</a>
                    <h1>
                    </h1>
                </div>
            </div>     
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#home">Received Messages</a></li>
                <li><a data-toggle="tab" href="#menu1">Sent Messages</a></li>                 
            </ul>
            
            <div class="tab-content">
               
                <div id="home" class="tab-pane fade in active" style="height:500px; font:16px/26px Georgia, Garamond, Serif;overflow:auto;">
                     <table id="receiveMessage" class="table table-striped table-bordered" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th class="th-sm">Theme</th>
                                <th class="th-sm">From</th>
                                <th class="th-sm">Time</th>

                              </th>
                            </tr>
                        </thead>
                        <tbody>
                    <%
                        boolean status = false; 
                        Connection conn = null;  
                        PreparedStatement pst = null;  
                        ResultSet rs = null;  

                        

                        try {  
                            DbConnection db = new DbConnection();
                            conn = db.getConn();  
                            pst = conn.prepareStatement("select * from TED.MESSAGES ORDER BY TIME DESC");  
                            
                            rs = pst.executeQuery();  
                            while(rs.next())
                            {      
                                if(rs.getString("receiver").equals(session.getAttribute("username")))
                                {
                                    
                                    if(rs.getInt("is_read")==0)
                                    {
                    
                                         if(rs.getInt("deleted_receiver")==0)
                                         {
                    %>
                                       
                            <tr>            
                                <td>
                                    <a href="profile_message.jsp?message_id=<%=rs.getString("message_id")%>" style="color: blue"> <%=rs.getString("theme")%> </a>  
                                </td>
                                <td>
                                    <%=rs.getString("Sender")%>
                                </td>
                                <td>
                                    <%=rs.getString("time")%>
                                </td>
                            </tr>
                                   
                    <%                    }
                                   }else{
                                          if(rs.getInt("deleted_receiver")==0)
                                          {
                    %>
                             <tr>            
                                <td>
                                    <a href="profile_message.jsp?message_id=<%=rs.getString("message_id")%>" style="color: gray"> <%=rs.getString("theme")%> </a>  
                                </td>
                                <td>
                                    <%=rs.getString("Sender")%>
                                </td>
                                <td>
                                    <%=rs.getString("time")%>
                                </td>
                             </tr>
                     
                     <%                 }
                                    }
                     
                                }
                            }
                    %>
                                </tbody>
                            </table>
                            </div>                     
                            <div id="menu1" class="tab-pane fade" style="height:500px; font:16px/26px Georgia, Garamond, Serif;overflow:auto;">
                                <table id="sendMessage" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                    <thead>
                                        <tr>
                                            <th class="th-sm">Theme</th>
                                            <th class="th-sm">To</th>
                                            <th class="th-sm">Time</th>

                                          </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                    <%
                            rs = pst.executeQuery();  
                            while(rs.next())
                            {
                                if(rs.getString("sender").equals(session.getAttribute("username")))
                                {
                                    
                                    if(rs.getInt("deleted_sender")==0)
                                    {
                    %>
                          <tr>            
                                <td>
                                    <a href="profile_message_simple.jsp?message_id=<%=rs.getString("message_id")%>" style="color: gray"> <%=rs.getString("theme")%> </a>  
                                </td>
                                <td>
                                    <%=rs.getString("Receiver")%>
                                </td>
                                <td>
                                    <%=rs.getString("time")%>
                                </td>
                            </tr>          
                    
                    
                    <%              }
                                }
                            }
                    %>
                        </tbody>
                    </table>
                </div>
              
                    
                    <%                             
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
           
            $('#receiveMessage').DataTable({
                responsive: true,
                "order": [[ 2, "desc" ]]
            });
            $('#sendMessage').DataTable({
                responsive: true,
                "order": [[ 2, "desc" ]]
            });
            $('.dataTables_length').addClass('bs-select');
        });
    </script>
</html>
