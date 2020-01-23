
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.lang.model.element.Element"%>
<%@ page import="Database.DbConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <META HTTP-EQUIV="CONTENT-TYPE"CONTENT="TEXT/HTML;CHARSET=ISO-8859-7">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <link rel="stylesheet" type="text/css" href="css/signup.css"/>

        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="css/modern-business.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

        <title>Search Page</title>
        
        <script src="js/jquery.js"></script> 
        
        <script type="text/javascript" src="js/countries.js"></script>
    </head>

    <body>
        <%
        if(session.getAttribute("name") != null){
        %>
        
         <jsp:include page="login_menu.jsp" />
        
        <%
        }else{
        %>
        
        <jsp:include page="menu.jsp" />
        
        <%
        }
        %>
        
        
        
        <!-- Navigation -->
        <div class="container">
             <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">

                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="index.jsp">Home</a>
                        </li>
                        <li class="active">Navigate/Search</li>
                    </ol>
                </div>
            </div>
            <div class="wrapper">
                <h1><br> </h1>
                <div class="content">
                    <div id="form_wrapper" class="form_wrapper">
                        <form class="register" action="SearchServlet" method="post">
                            <h3>Advanced Search</h3>
                            <fieldset class="row1">
                                <div class="column">
                                    <div>
                                        <label>Amount &nbsp; </label>
                                        <input type="text" name="from_amount" placeholder="From"/>
                                    </div>
                                    
                                    <div>
                                        <label>Location</label>
                                        <select  id="country" name ="country"></select>
                                        <script language="javascript">print_country("country");</script>
                                    </div>
                                    <div>
                                       <label>Description</label>
                                       <input type="text" name="description"/>
                                    </div>
                                </div>
                                <div class="column">
                                    <div>
                                        <label> &nbsp;</label>
                                        <input type="text" name="to_amount" placeholder="To"/>
                                    </div>
                                    <div>
                                            <label>Category</label>
                                            <select name="category">
                                                <option>Select Category</option>
                                            <%
                                              
                                                Connection conn = null;  
                                                PreparedStatement pst = null;  
                                                ResultSet rs = null;  
                                                
                                                try {  
                                                    DbConnection db = new DbConnection();
                                                    conn = db.getConn();  
                                                    pst = conn.prepareStatement("select * from TED.CATEGORIES"); 
                                                    
                                                    rs = pst.executeQuery();
                                                    while(rs.next())
                                                    {
                                            %>
                                                    <option><%= rs.getString("category") %></option>
                                            
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
                                        </select>            
                                    </div>
                                    <div>
                                       <label>Results per page</label>
                                       <select  name="Results_per_page">
                                           <option>5</option>
                                           <option>10</option>
                                           <option>15</option>
                                       </select>
                                    </div>
                                </div>
                            </fieldset>
                           
                            <div class="bottom">
                                    <label>**At least one domain must be filled</label>
                                    <input type="submit" value="Search" />
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

 