<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Database.DbConnection"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="css/modern-business.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        
         <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container" style="margin-top: 30px ">
                <!-- Brand and toggle get grouped for better mobile display -->

                

                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <%
                        if((Integer)session.getAttribute("role") == 1)
                        {
                    %>
                    <a class="navbar-brand" href="admin_home_page.jsp">e-Auctions</a>
                    <%
                        }else{   
                    %>
                    <a class="navbar-brand" href="index_login.jsp">e-Auctions</a>
                    <%
                        }
                    %>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                   <ul class="nav navbar-nav navbar-right">
                       <li>
                            <a> | </a>
                        </li>
                        <li>
                            <a href="profile.jsp" >Profile: <%= session.getAttribute("surname") %> <%= session.getAttribute("name") %></a>
                        </li>
                        <li>
                             <a style="cursor: pointer" onclick="myFunction()">Log Out</a>
                        </li>
                        
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="auction_management.jsp">Auctions Management</a>
                        </li>
                        <li>
                            <a href="search.jsp">Navigate/Search</a>
                        </li>
                        <%      
                        int count=0;
                        Connection conn = null;  
                        PreparedStatement pst = null;  
                        ResultSet rs = null;  

                        try {  
                            DbConnection db = new DbConnection();
                            conn = db.getConn();  
                            pst = conn.prepareStatement("select * from TED.MESSAGES where IS_READ=0 AND RECEIVER=?"); 
                            pst.setString(1, (String)session.getAttribute("username"));

                            rs = pst.executeQuery();
                            while(rs.next())  
                            {
                                count++;
                            }                     
                            pst.executeUpdate();  
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
                        if(count==0)
                        {
                        %>                       
                        <li>
                            <a href="message.jsp">Messages</a>
                        </li>
                        <%
                        }else{
                        %>
                         <li>
                            <a href="message.jsp">Messages(<%=count%>)</a>
                        </li>
                        <%}
                        %>                      
                    </ul>
                     
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container -->
        </nav>
    </body>
</html>
