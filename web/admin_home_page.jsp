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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>Admin's Home Page</title>
    
    <link href="css/admin_homepage.css" rel="stylesheet" type="text/css"/>
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/modern-business.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <link rel="stylesheet" type="text/css" href="css/datatables.min.css"/>

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
    <!-- Navigation -->
    <jsp:include page="login_menu.jsp" />

    <!-- Page Content -->
    <div class="container">
        <%@page import="java.sql.*" %>
        
        <div class="row">
            <hr>
            <div class="col-lg-12">
                <div class="jumbotron"> 
                    <p align="center">Welcome to the administrator page!</p>
                </div>
            </div>

        </div>
        <%
                boolean status = false; 
                Connection conn = null;  
                PreparedStatement pst = null;  
                ResultSet rs = null;  

                try {  
                    DbConnection db = new DbConnection();
                    conn = db.getConn();     
                    Statement statement = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                    
        
                    %>                       

        <div class="wrapper">
            <div class="content">
                <div id="form_wrapper" class="form_wrapper">
                    <h3>List Of Users</h3>
                <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th class="th-sm">Username</th>
                            <th class="th-sm">Accepted</th>


                          </th>
                        </tr>
                    </thead>
                    <tbody>
                        
                    
                
        <%
               
                    if(session.getAttribute("n_users") == null)
                    {
                        statement.setMaxRows(1000);
                    }else{
                        int nrow=Integer.parseInt((String)session.getAttribute("n_users"));
                        statement.setMaxRows((nrow));
                    }
                    String query = "select * from TED.USERS order by ACCEPTED";             
                    int i=0;
                     

                    rs = statement.executeQuery(query); 
                    while(rs.next())
                    {
                            if(rs.getInt("ROLE")== 2 && !rs.getString("USERNAME").equals("null"))
                            {
        %>
                        <tr>
                            <td>
                                <a href="profile_accepted.jsp?usr=<%=rs.getString("USERNAME")%>"> <%=rs.getString("USERNAME")%> </a>  
                            </td>
                            <td>
                                <%if(rs.getString("ACCEPTED").equals("1")){%>
                                <!--<div class="fill" style="background-image:url(images/tickYes.jpg);"></div>-->
                                    <img src="images/tickYes.jpg" alt=""  height=15 width=15/>
                                <% }else{%>
                                    <img src="images/wait.png" alt=""  height=15 width=15/>
                                <% } %>
                            </td>
                        </tr>
                    
               
                        
        <%                  }                         
                        i++;
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
                    <!--/div-->
                </div>
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
    <!-- /.container -->

    <!-- jQuery -->
    <script src="js/jquery-3.1.1.min.js" type="text/javascript"></script>    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/datatables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#dtBasicExample').DataTable({
                responsive: true
            });
            $('.dataTables_length').addClass('bs-select');
        });
    </script>

</body>
