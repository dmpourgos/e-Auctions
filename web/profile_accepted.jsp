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
    <title>User's Profile</title>

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

                String u=request.getParameter("usr");
                try {  
                    DbConnection db = new DbConnection();
                    conn = db.getConn();  
                    pst = conn.prepareStatement("select * from TED.USERS where USERNAME=?"); 
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
                                            <li class="active">User's Profile</li>
                                        </ol>
                                    </div>
                                </div>
                                <div class="wrapper">
                                    <h1><br> </h1>
                                    <div class="content">
                                        <div id="form_wrapper" class="form_wrapper">
                                                <h3>Profile</h3>
                                                <fieldset class="row1">
                                                    <legend>Account Information</legend>
                                                    <div class="column">
                                                        <div>
                                                            <label>Username</label>
                                                            <input type="text" value="<%=rs.getString("USERNAME") %>" readonly="readonly"/>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                                <fieldset class="row1">
                                                    <legend>Personal Information</legend>
                                                    <div class="column">
                                                        <div>
                                                            <label>Name</label>
                                                            <input type="text" value="<%= rs.getString("name") %>" readonly="readonly"/>
                                                        </div>
                                                        <div>
                                                            <label>A.F.M</label>
                                                            <input type="text" value="<%= rs.getString("afm") %>" readonly="readonly"/>
                                                        </div>
                                                        <div>
                                                            <label>E-mail</label>
                                                            <input type="text" value="<%=rs.getString("email") %>" readonly="readonly"/>                
                                                        </div>
                                                    </div>
                                                    <div class="column">
                                                        <div>
                                                            <label>Surname</label>
                                                            <input type="text" value="<%=rs.getString("surname") %>" readonly="readonly"/>
                                                        </div>
                                                        <div>
                                                            <label>Phone</label>
                                                            <input type="text" value="<%=rs.getString("phone") %>" readonly="readonly"/>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                                <fieldset class="row1">
                                                    <legend>Location Information</legend>
                                                   <div class="column">
                                                        <div>
                                                            <label>Country</label>
                                                            <input type="text" value="<%= rs.getString("country") %>" readonly="readonly"/>
                                                        </div>

                                                        <div>
                                                            <label>Location</label>
                                                            <input type="text" name="location" value="<%= rs.getString("location") %>" readonly="readonly"/>
                                                        </div>

                                                        <div>
                                                            <label>Address</label>
                                                            <input type="text" name="address" value="<%= rs.getString("address") %>" readonly="readonly"/>
                                                        </div>

                                                    </div>
                                                    <div class="column">
                                                        <div>
                                                            <label>City</label>
                                                           <input type="text" name="city" value="<%= rs.getString("city") %>" readonly="readonly"/>

                                                        </div>
                                                        <div>
                                                           <label>Postcode</label>
                                                           <input type="text" name="tk" value="<%= rs.getInt("tk") %>" readonly="readonly"/>

                                                        </div>
                                                        <div>
                                                            <label>Number</label>
                                                            <input type="text" name="number" value="<%= rs.getInt("number") %>" readonly="readonly"/>

                                                        </div>
                                                    </div>
                                                </fieldset>
                                                <fieldset class="row1">
                                                    <legend>Rating Information</legend>
                                                    <div class="column">
                                                        <div>
                                                            <label>Seller Rating</label>
                                                            <input type="text" value="<%= rs.getInt("s_rating") %>" readonly="readonly"/>
                                                        </div>                                 
                                                    </div>
                                                    <div class="column">
                                                        <div>
                                                            <label>Buyer Rating</label>
                                                           <input type="text" name="city" value="<%= rs.getInt("b_rating") %>" readonly="readonly"/>

                                                        </div>                                  
                                                    </div>
                                                </fieldset>

                                                <div class="bottom">
                                                    <form class="login active" action="updateServlet" method="post" >
                                                        <input type="hidden" name="usr1" value=<%=rs.getString("USERNAME")%>></input> 
                                                        <%
                                                            if(rs.getInt("ACCEPTED")==0)
                                                            {
                                                        %>
                                                        <input type="submit" value="Accept"/>  
                                                        <%
                                                            }else{                                                                                           
                                                        %>
                                                        <a href="admin_home_page.jsp" rel="login" class="linkform">This person is already accepted! Back to Home Page >></a>
                                                        <%
                                                            }
                                                        %>
                                                        <div class="clear"></div>
                                                    </form>                         
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

 
