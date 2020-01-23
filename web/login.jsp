<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>Log In Page</title>
    
    <link rel="stylesheet" type="text/css" href="css/style.css"/>

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
    if(session.getAttribute("name") != null){
        response.sendRedirect("index_login.jsp");
    }
    %>
    <!-- Navigation -->
    <jsp:include page="menu.jsp" />
    <div class="wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">
                    
                </h1>
                <ol class="breadcrumb">
                    <li><a href="index.jsp">Home</a>
                    </li>
                    <li class="active">Log In</li>
                </ol>
            </div>
        </div>
        <h1><br> </h1>
        <div class="content">
            <div id="form_wrapper" class="form_wrapper">
                <form class="login active" action="LoginServlet" method="post">
                    <h3>Log In</h3>
                    <div>
                            <label>Username:</label>
                            <input type="text" name="username" required/>
                    </div>
                    <div>
                            <label>Password:</label>
                            <input type="password" name="password" required/>
                    </div>
                    <div class="bottom">
                            <!--<div class="remember"><input type="checkbox" /><span>Keep me logged in</span></div>-->
                            <input type="submit" value="Submit"></input>
                            <a href="signup.jsp" rel="register" class="linkform">Do you want to create an account? Sign up here!</a>
                            <div class="clear"></div>
                    </div>
                </form>
            </div>   
        </div>
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