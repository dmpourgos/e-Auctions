<%@page import="javax.lang.model.element.Element"%>
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
        <META HTTP-EQUIV="CONTENT-TYPE"CONTENT="TEXT/HTML;CHARSET=ISO-8859-7">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>Message Answer</title>

        <link rel="stylesheet" type="text/css" href="css/signup.css"/>

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
        
        <!-- Bootstrap Core JavaScript -->
        <script src="js/bootstrap.min.js"></script> 
        
        <script src="js/jquery.js"></script> 
        
        <script type="text/javascript" src="js/countries.js"></script>
        
    </head>

    <body>
        <%
        //allow access only if session doesn't exists
        if(session.getAttribute("name") == null){
            response.sendRedirect("index.jsp");
        }
        %>
        
        <!-- Navigation -->
        <jsp:include page="login_menu.jsp" />
        <%@page import="java.sql.*" %>
        
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">

                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="index_login.jsp">Home</a></li>
                        <li><a href="message.jsp">Message Management Page</a></li>
                        <li class="active">Message Answer</li>
                    </ol>
                </div>
            </div>
            <div class="wrapper">
                <h1><br> </h1>
                <div class="content">
                    <div id="form_wrapper" class="form_wrapper">
                        <form class="register" action="Create_Message_Servlet" method="post">
                            <h3>Profile Message</h3>
                             <fieldset class="row1">
                                <legend>Message Information</legend>                                                 
                                <div class="column">
                                    <div>
                                        <label>To</label>
                                        <select name="to">
                                        <%
                                            boolean status = false; 
                                            Connection conn = null;  
                                            PreparedStatement pst = null;  
                                            ResultSet rs = null;  
    
                                            try {  
                                                DbConnection db = new DbConnection();
                                                conn = db.getConn();   
                                                pst = conn.prepareStatement("select * from TED.USERS"); 

                                                rs = pst.executeQuery();
                                                while(rs.next())
                                                {
                                                    if(!rs.getString("USERNAME").equals("null") && !rs.getString("USERNAME").equals(session.getAttribute("username"))){
                                         %>
<!--                                            <input type="text" name="to" value="<%= request.getParameter("snd")%>"/>-->
                                            <option  value="<%=rs.getString("USERNAME")%>"><%=rs.getString("USERNAME")%></option>

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
                                        </select>
                                    </div>  
                                    <div>
                                        <label>Theme</label>
                                        <input type="text" name="theme" value="" required/>
                                    </div>                                                                     
                                    <div>
                                        <label>Text</label>
                                        <textarea maxlength="1000" name="text" style="height:150px; width: 640px;" required></textarea>
                                    </div>      
                                </div>
                                <div class="column">                                   
                                    <div>
                                        <label>From</label>
                                        <input type="text" name="from" value="<%= session.getAttribute("username")%>" readonly="readonly"/>
                                    </div>                                                       
                                </div>
                            </fieldset>
                           
                            
                            <div class="bottom">
                                     
                                <input type="submit" value="Send" />
                                <div class="clear"></div>
                            </div>
                        </form> 
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
    </body>
            
</html>

 
