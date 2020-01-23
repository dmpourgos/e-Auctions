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
    <title>User's Profile</title>

    
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link href="css/modern-business.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <link href="css/profile.css" rel="stylesheet" type="text/css"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type= "text/javascript" src = "js/cities.js"></script>
    <script src="js/bootstrap.min.js"></script> 
        
    <script src="js/jquery.js"></script> 

    <script type="text/javascript" src="js/countries.js"></script>

</head>

<body>
    <%
    //allow access only if session exists
    if(session.getAttribute("name") == null){
        response.sendRedirect("index.jsp");
    }
    %>
    <jsp:include page="login_menu.jsp" />
    <!-- Navigation -->
    

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
                                        <input type="text" value="<%= session.getAttribute("username") %>" readonly="readonly"/>
                                    </div>
                                </div>
                            </fieldset>
                            <fieldset class="row1">
                                <legend>Personal Information</legend>
                                <div class="column">
                                    <div>
                                        <label>Name</label>
                                        <input type="text" value="<%= session.getAttribute("name") %>" readonly="readonly"/>
                                    </div>
                                    <div>
                                        <label>A.F.M</label>
                                        <input type="text" value="<%= session.getAttribute("afm") %>" readonly="readonly"/>
                                    </div>
                                    <div>
                                        <label>E-mail</label>
                                        <input type="text" value="<%= session.getAttribute("email") %>" readonly="readonly"/>                
                                    </div>
                                </div>
                                <div class="column">
                                    <div>
                                        <label>Surname</label>
                                        <input type="text" value="<%= session.getAttribute("surname") %>" readonly="readonly"/>
                                    </div>
                                    <div>
                                        <label>Phone</label>
                                        <input type="text" value="<%= session.getAttribute("phone") %>" readonly="readonly"/>
                                    </div>
                                </div>
                            </fieldset>
                            <fieldset class="row1">
                                <legend>Location Information</legend>
                                <div class="column">
                                    <div>
                                        <label>Country</label>
                                        <input type="text" value="<%= session.getAttribute("country") %>" readonly="readonly"/>
                                    </div>

                                    <div>
                                        <label>Location</label>
                                        <input type="text" name="location" value="<%= session.getAttribute("location") %>" readonly="readonly"/>
                                    </div>

                                    <div>
                                        <label>Address</label>
                                        <input type="text" name="address" value="<%= session.getAttribute("address") %>" readonly="readonly"/>
                                    </div>

                                </div>
                                <div class="column">
                                    <div>
                                        <label>City</label>
                                       <input type="text" name="city" value="<%= session.getAttribute("city") %>" readonly="readonly"/>

                                    </div>
                                    <div>
                                       <label>Postcode</label>
                                       <input type="text" name="tk" value="<%= session.getAttribute("tk") %>" readonly="readonly"/>

                                    </div>
                                    <div>
                                        <label>Number</label>
                                        <input type="text" name="number" value="<%= session.getAttribute("number") %>" readonly="readonly"/>

                                    </div>
                                </div>
                            </fieldset>
                            <fieldset class="row1">
                                <legend>Rating Information</legend>
                                <div class="column">
                                    <div>
                                        <label>Seller Rating</label>
                                        <input type="text" value="<%= session.getAttribute("s_rating") %>" readonly="readonly"/>
                                    </div>                                 
                                </div>
                                <div class="column">
                                    <div>
                                        <label>Buyer Rating</label>
                                       <input type="text" name="city" value="<%= session.getAttribute("b_rating") %>" readonly="readonly"/>

                                    </div>                                  
                                </div>
                            </fieldset>
                            <div class="bottom">
                                    <a href="index_login.jsp" rel="login" class="linkform">Back to Home Page >></a>
                                    <div class="clear"></div>
                            </div>

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
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
    
</body>

</html>

 