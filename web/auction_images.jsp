<<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

    <title>Create Auction-Images Page</title>
    
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
        <div class="row">
            <hr>
            <div class="col-lg-12">
                <div class="jumbotron"> 
                    <p align="center">Your auction has been submitted succesfully! Add one or more photos if you like!</p>
                </div>
            </div>
            <div class="col-lg-12">
                <h1 class="page-header">

                </h1>
                <ol class="breadcrumb">
                    <li><a href="index_login.jsp">Home</a></li>
                    <li><a href="auction_management.jsp">Auctions Management</a></li>
                    <li class="active">Create Auction</li>
                    <li class="active">Create Auction-Images Page</li>
                </ol>
            </div>
        </div>
        
        <div class="wrapper">
            <h1><br> </h1>
            <div class="content">
                <div id="form_wrapper" class="form_wrapper">
                    <form class="register" action="Auction_Image_Servlet" method="post" enctype="multipart/form-data">
                        <h3>Auction</h3>
                        <fieldset class="row1">
                            <legend>Images</legend>
                            <div class="column">
                                <div>                
                                    <input type="file" name="photo" style="padding-left: 24px" size="50" accept="image/*" multiple/>                                         
                                </div>
                            </div>                           
                        </fieldset>
                        <div class="bottom">
                            <input type="submit" value="Submit" />
                            <a href="index_login.jsp" rel="register" class="linkform">If you dont want to add images, go back to home page!</a>
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
    <!-- /.container -->

    <!-- jQuery -->
    <script src="js/jquery-1.11.3.js" type="text/javascript"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

</body>

