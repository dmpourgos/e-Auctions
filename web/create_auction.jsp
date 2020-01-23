<%@page import="javax.lang.model.element.Element"%>
<%@ page import="Database.DbConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        
        <title>Create Auction Page</title>

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
        session=request.getSession(true);
        if(session.getAttribute("aname") == null){
            session.setAttribute("aname", "");
            session.setAttribute("b_price", "");
            session.setAttribute("f_bid", "");
            session.setAttribute("alocation", "");
            session.setAttribute("latitude", "");
            session.setAttribute("longitude", "");
            session.setAttribute("desc", "");
            session.setAttribute("f_bid_span","");
            session.setAttribute("b_price_span","");
            session.setAttribute("latitude_span","");
            session.setAttribute("longitude_span","");
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
                        <li><a href="auction_management.jsp">Auctions Management</a></li>
                        <li class="active">Create Auction</li>
                    </ol>
                </div>
            </div>
            <div class="wrapper">
                <h1><br> </h1>
                <div class="content">
                    <div id="form_wrapper" class="form_wrapper">
                        <form class="register" action="Auction_Servlet" method="post">
                            <h3>Auction</h3>
                            <fieldset class="row1">
                                <legend>Auction Information</legend>
                                <div class="column">
                                    <div>
                                        <label>Name</label>
                                        <input type="text" name="rname" value="<%= session.getAttribute("aname") %>" required/>                                         
                                    </div>
                                    <div>
                                        <label>Buy Price</label>
                                        <input type="text" name="b_price" value="<%= session.getAttribute("b_price") %>"/>  
                                        <span class="span" style="color:orange">**This field is optional.</span><br />
                                        <span class="span" style="color:red"><%= session.getAttribute("b_price_span") %></span>
                                        
                                    </div>
                                </div>
                                <div class="column">
                                    <div>
                                        <label>First Bid</label>
                                        <input type="text" name="f_bid" value="<%= session.getAttribute("f_bid") %>" required/> 
                                        <span class="span" style="color:red"><%= session.getAttribute("f_bid_span") %></span>
                                    </div>
                                    <div>
                                        <label>Categories</label>
                                        <select name="category" size="3" multiple required>
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
                                   
                                </div>
                            </fieldset>
                            <fieldset class="row1">
                                <legend>Location Information</legend>
                                <div class="column">
                                    <div>
                                        <label>Country</label>
                                        <select onchange="print_state('city',this.selectedIndex);" id="country" name ="country" required></select>
                                    </div>  
                                    <div>
                                       <label>Latitude</label>
                                      
                                       <input type="text" name="latitude" value="<%= session.getAttribute("latitude") %>"/>
                                       <span class="span" style="color:orange">**This field is optional.</span><br />
                                       <span class="span" style="color:red"><%= session.getAttribute("latitude_span") %></span>
                                       
                                    </div>
                                </div>
                                <div class="column">
                                    <div>
                                        <label>Location</label>
                                        <input type="text" name="location" value="<%= session.getAttribute("alocation") %>" required/>
                                    </div>  
                                    <div>
                                        <label>Longitude</label>
                                        <input type="text" name="longitude" value="<%= session.getAttribute("longitude") %>"/>
                                        <span class="span" style="color:orange">**This field is optional.</span><br />
                                        <span class="span" style="color:red"><%= session.getAttribute("longitude_span") %></span>
                                        
                                    </div>
                                    <div> 
                                        <script language="javascript">print_country("country");</script>
                                    </div>
                                </div>
                            </fieldset>
                            <fieldset class="row1">
                                <legend>Description</legend>
                                <div>
                                    <label>Description</label>
                                    <textarea name="desc" maxlength="1000" style="height:200px; width: 643px;" required><%= session.getAttribute("desc") %></textarea> 
                                </div>
                                <div>
                                    <input type="hidden" name="usr"  value="<%= session.getAttribute("username") %>"/> 
                                </div>
                                
                            </fieldset>
                            
                            <div class="bottom">
                                     
                                <input type="submit" value="Submit" />
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
            session=request.getSession(false);
            if(session!=null)
            {
                session.removeAttribute("aname");
                session.removeAttribute("b_price");
                session.removeAttribute("f_bid");
                session.removeAttribute("alocation");
                session.removeAttribute("latitude");
                session.removeAttribute("longitude");
                session.removeAttribute("desc");
                session.removeAttribute("f_bin_span");
                session.removeAttribute("b_price_span");
                session.removeAttribute("latitude_span");
                session.removeAttribute("longitude_span");
            }
         %>
    </body>
            
</html>

 