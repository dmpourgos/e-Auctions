<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Database.DbConnection"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    

<head>

    <script>
        function myFunction() {
            if(confirm("Do you want to log out?")){
                window.location="LogoutServlet";
            }
        }
    </script>
    
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Message's Profile </title>

    <link href="css/profile.css" rel="stylesheet" type="text/css"/>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/modern-business.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type= "text/javascript" src = "js/cities.js"></script>

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
    <!-- Navigation -->
    
    <%
                boolean status = false; 
                Connection conn = null;  
                PreparedStatement pst = null;  
                ResultSet rs = null;  
 
                String u=request.getParameter("message_id");
                try {  
                    DbConnection db = new DbConnection();
                    conn = db.getConn();    
                    pst = conn.prepareStatement("select * from TED.MESSAGES where MESSAGE_ID=?"); 
                    pst.setString(1, u);

                    rs = pst.executeQuery();
                    status = rs.next();  
                    if(status)
                    {
     %>
                            <div class="container">         
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h1 class="page-header">

                                        </h1>
                                        <ol class="breadcrumb">
                                            <li><a href="index_login.jsp">Home</a></li>
                                            <li><a href="message.jsp">Message Management Page</a></li>
                                            <li class="active">Message's Profile </li>
                                        </ol>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-lg-12">   
                                        <form class="register" action="Delete_Message_Servlet" method="post">
                                            <input type="submit"  class="breadcrumb"  value="Delete Message" />  
                                            <input type="hidden" name="msg_id"  value="<%= rs.getString("message_id")%>"/>
                                            <input type="hidden" name="send" value=<%=rs.getString("sender")%>></input> 
                                            <input type="hidden" name="recv" value=<%=rs.getString("receiver")%>></input> 
                                        </form>
                                    </div>
                                </div>
                                
                                <div class="wrapper">
                                    <h1><br> </h1>
                                    <div class="content">
                                        <div id="form_wrapper" class="form_wrapper">
                                                <h3>Profile Message</h3>
                                                <fieldset class="row1">
                                                    <legend>Message Information</legend>                                                 
                                                    <div class="column">
                                                        <div>
                                                            <label>Theme</label>
                                                            <input type="text" value="<%=rs.getString("theme") %>" readonly="readonly"/>
                                                        </div>
                                                        <div>
                                                            <label>To</label>
                                                            <input type="text" value="<%=rs.getString("receiver") %>" readonly="readonly"/>
                                                        </div> 
                                                        <div>
                                                            <label>Text</label>
                                                            <textarea maxlength="1000" style="height:150px; width: 640px;" readonly="readonly"><%= rs.getString("content") %></textarea>
                                                        </div>      
                                                    </div>
                                                    <div class="column">
                                                        <div>
                                                            <label>Time</label>
                                                            <input type="text" value="<%=rs.getTimestamp("time") %>" readonly="readonly"/>
                                                        </div>
                                                        <div>
                                                            <label>From</label>
                                                            <input type="text" value="<%=rs.getString("sender") %>" readonly="readonly"/>
                                                        </div>                                                       
                                                    </div>
                                                </fieldset>
                                                                                                                                              
                                                <div class="bottom">  
                                                        <a href="message.jsp" rel="login" class="linkform">Back to Message Management Page>></a>
                                                        <div class="clear"></div>                                                                     
                                                </div>
                                          
                                        </div>
                                        <div class="clear"></div>
                                    </div>
                                </div>

                                <!-- Footer -->
                                <footer>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <p>Copyright &copy; Your Website 2019</p>
                                        </div>
                                    </div>
                                </footer>

                        </div>
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

   
    <!-- /.container -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
    
</body>

</html>

 
