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
     <!-- jQuery -->
   <script src="js/jquery-2.1.3.min.js" type="text/javascript"></script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Images</title>

    <link href="css/profile_update.css" rel="stylesheet" type="text/css"/>
    
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

                
                String u;
                if(request.getParameter("item_id")!=null)
                    u= (String)request.getParameter("item_id");
                else
                    u=(String)session.getAttribute("item_id");
                try {  
                     DbConnection db = new DbConnection();
                     conn = db.getConn();             
     %>
                            <div class="container">         
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h1 class="page-header">

                                        </h1>
                                        <ol class="breadcrumb">
                                            <li><a href="index_login.jsp">Home</a></li>
                                            <li><a href="auction_management.jsp">Auctions Management</a></li>
                                            <li class="active">Update Images</li>
                                        </ol>
                                    </div>
                                </div>
                                
                                <div class="wrapper">
                                    <h1><br> </h1>
                                    <div class="content">
                                        <div id="form_wrapper" class="form_wrapper">
                                           
                                                <h3>Update Images</h3>                                                
                                                                                               
                                                 <fieldset class="row1">
                                                   <legend>Images</legend>
                                                   <div class="column">
                                                        <div>                                                                                                                   
                                                            <%                                                       
                                                            pst = conn.prepareStatement("select * from TED.IMAGES where ITEM_ID=?"); 
                                                            pst.setString(1, u);
                                                            rs = pst.executeQuery();
                                                            while(rs.next())
                                                            {
                                                            %>
                                                                <form class="register" action="DeleteImage" method="post">
                                                                    <a href="image.jsp?image_id=<%=rs.getInt("IMAGE_ID")%>" target="_blank"><img src="image.jsp?image_id=<%=rs.getInt("IMAGE_ID")%>" width="140" height="100"></a> 
                                                                    <input type="hidden" name="image_id"  value="<%= rs.getInt("IMAGE_ID")%>"/> 
                                                                    <input type="hidden" name="item_id"  value="<%= u%>"/> 
                                                                    <input type="submit" class="signbutton" name="submitchanges" value="Delete Image" />
                                                                </form>
                                                            <%
                                                            }
                                                            %>    
                                                            
                                                        </div>                                                       
                                                    </div>                                                     
                                                </fieldset>
                                                <form class="register" action="AddImageServlet" method="post" enctype="multipart/form-data">                                                    
                                                    <fieldset class="row1">               
                                                        <div class="column">
                                                            <div>                
                                                                <input type="file" name="photo2" style="padding-left: 24px" size="50" accept="image/*" multiple/>                                         
                                                            </div>
                                                        </div>                           
                                                    </fieldset>
                                                    <div class="bottom">
                                                        <input type="submit" value="Submit" />
                                                        <input type="hidden" name="item_id"  value="<%= u%>"/> 
                                                        <a href="profile_auction_update_delete.jsp?item_id=<%=u%>" rel="register" class="linkform">Go back to auction's profile update page >></a>
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

   
    <!-- /.container -->

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
</body>

</html>

 
