<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

       <title>e-Auctions</title>

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
    
    <!-- jQuery -->
    
    <script src="js/jquery-2.1.3.min.js" type="text/javascript"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Script to Activate the Carousel -->
    <script>
    $('.carousel').carousel({
        interval: 5000 //changes the speed
    });
    </script>
    
    
    <jsp:include page="menu.jsp" />
     
    <!-- Header Carousel -->
    <header id="myCarousel" class="carousel slide">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner">
            <div class="item active">
                <div class="fill" style="background-image:url(images/image1.jpg);"></div>
                
            </div>
            <div class="item">
                <div class="fill" style="background-image:url(images/image3.jpg);"></div>
                
            </div>
            <div class="item">
                <div class="fill" style="background-image:url(images/image2.jpg);"></div>
                
            </div>
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="icon-prev"></span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="icon-next"></span>
        </a>
    </header>

    <!-- Page Content -->
    <div class="container">

        <!-- Features Section -->
        <div class="row">
            <div class="col-lg-12">
                <h2 class="page-header">Welcome to e-Auction</h2>
            </div>
            <div class="col-md-6">
                <p>The new application for smart Auctions.</p>
                <ul>
                    <li>Create Auctions</li>
                    <li>Have the highest profit</li>
                    <li>Find easily the Auctions that interest you</li>
                    <li>Text and rate other users</li>                 
                </ul>
                <p>Sign Up now in order to have all these and more experiences. Do not miss the chance to promote your items and even buy great ones.</p>
                <p>Enjoy your journey in the world of Auctions!</p>
            </div>
            
        </div>

        <hr>

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

    

</body>

</html>

    </body>
</html>
