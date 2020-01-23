<%@page import="javax.lang.model.element.Element"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">


<html>

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <META HTTP-EQUIV="CONTENT-TYPE"CONTENT="TEXT/HTML;CHARSET=ISO-8859-7">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>Sign Up Page</title>

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
        <script src="js/jquery-2.1.3.min.js"></script> 
        
        <script src="js/bootstrap.min.js"></script> 
        
        <script type="text/javascript" src="js/countries.js"></script>

    </head>

    <body>
        <%
        //allow access only if session doesn't exists
        if(session.getAttribute("name") != null){
            response.sendRedirect("index_login.jsp");
        }
        if(session.getAttribute("name1") == null){
            session.setAttribute("username", "");
            session.setAttribute("password", "");
            session.setAttribute("name1", "");
            session.setAttribute("afm", "");
            session.setAttribute("email", "");
            session.setAttribute("surname", "");
            session.setAttribute("phone", "");
            session.setAttribute("address", "");
            session.setAttribute("tk", "");
            session.setAttribute("number", "");
            session.setAttribute("username_span","");
            session.setAttribute("password_span","");
            session.setAttribute("name_span","");
            session.setAttribute("surname_span","");
            session.setAttribute("address_span","");
            session.setAttribute("tk_span","");
            session.setAttribute("number_span","");
            session.setAttribute("afm_span","");
            session.setAttribute("email_span","");
            session.setAttribute("phone_span","");
            session.setAttribute("color","");
            session.setAttribute("password1","");
            session.setAttribute("location","");
        }
        %>
        
        <!-- Navigation -->
        <jsp:include page="menu.jsp" />

        <div class="container">
             <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">

                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="index.jsp">Home</a></li>
                        <li class="active">Sign Up</li>
                    </ol>
                </div>
            </div>
            <div class="wrapper">
                <h1><br> </h1>
                <div class="content">
                    <div id="form_wrapper" class="form_wrapper">
                        <form class="register" action="SignUpServlet" method="post">
                            <h3>Sign Up</h3>
                            <fieldset class="row1">
                                <legend>Account Information</legend>
                                <div class="column">
                                    <div>
                                        <label>Username</label>
                                        <input type="text" name="username" value="<%= session.getAttribute("username") %>" required/>
                                        <span class="username_span" style=<%= session.getAttribute("color") %>><%= session.getAttribute("username_span") %></span>  
                                    </div>
                                    <div>
                                        <label>Password</label>
                                        <input type="password" id="password" name="password" value="<%= session.getAttribute("password") %>" required/>
                                        <span class="span" style="color:red"><%= session.getAttribute("password_span") %></span> 
                                    </div>
                                </div>
                                <div class="column">
                                    <label>Password Confirmation</label>
                                    <input type="password" id="confirm_password" name="password1" value="<%= session.getAttribute("password1") %>" required/> 
                                </div>
                            </fieldset>
                            <fieldset class="row1">
                                <legend>Personal Information</legend>
                                <div class="column">
                                    <div>
                                        <label>Name </label>
                                        <input type="text" name="name" value="<%= session.getAttribute("name1") %>" required/>
                                    </div>
                                    <div>
                                        <label>A.F.M</label>
                                        <input type="text" name="afm" value="<%= session.getAttribute("afm") %>" required/>
                                    </div>
                                    <div>
                                        <label>E-mail</label>
                                        <input type="email" name="email" value="<%= session.getAttribute("email") %>" required/>
                                    </div>
                                </div>
                                <div class="column">
                                    <div>
                                        <label>Surname</label>
                                        <input type="text" name="surname" value="<%= session.getAttribute("surname") %>" required/>
                                    </div>
                                    <div>
                                        <label>Phone</label>
                                        <input type="text" name="phone" value="<%= session.getAttribute("phone") %>" required/>
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
                                        <label>Location</label>
                                        <input type="text" name="location" value="<%= session.getAttribute("location") %>"/>
                                        <span class="span" style="color:orange">**This field is optional.</span>
                                    </div>
                                    <div>
                                        <label>Address</label>
                                        <input type="text" name="address"  value="<%= session.getAttribute("address") %>" required/>
                                    </div>
                                    
                                </div>
                                <div class="column">
                                    <div>
                                        <label>City</label>
                                        <select name ="city" id ="city" required></select>
                                        <script language="javascript">print_country("country");</script>
                                    </div>
                                    <div>
                                       <label>Postcode</label>
                                       <input type="number" name="tk" value="<%= session.getAttribute("tk") %>" required/>
                                    </div>
                                    <div>
                                        <label>Number</label>
                                        <input type="number" name="number" value="<%= session.getAttribute("number") %>" required/>
                                    </div>
                                </div>
                            </fieldset>

                            <div class="bottom">
                                    <label>**All domains must be filled</label>
                                    
                                    <input type="submit" value="Sign Up" />
                                    <a href="login.jsp" rel="login" class="linkform">Already have an account? Login here!</a>
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
                session.removeAttribute("username");
                session.removeAttribute("password");
                session.removeAttribute("name1");
                session.removeAttribute("afm");
                session.removeAttribute("email");
                session.removeAttribute("surname");
                session.removeAttribute("phone");
                session.removeAttribute("address");
                session.removeAttribute("tk");
                session.removeAttribute("number");
                session.removeAttribute("username_span");
                session.removeAttribute("password_span");
                session.removeAttribute("name_span");
                session.removeAttribute("surname_span");
                session.removeAttribute("address_span");
                session.removeAttribute("tk_span");
                session.removeAttribute("number_span");
                session.removeAttribute("afm_span");
                session.removeAttribute("email_span");
                session.removeAttribute("phone_span");
                session.removeAttribute("color");
                session.removeAttribute("password1");
                session.removeAttribute("location");
                session.invalidate();
            }
        %>
    </body>
         
    
    <script>
            var password = document.getElementById("password"), confirm_password = document.getElementById("confirm_password");

            function validatePassword(){
                if(password.value != confirm_password.value) {
                    confirm_password.setCustomValidity("Passwords Don't Match");
                } else {
                    confirm_password.setCustomValidity('');
                }
            }

            password.onchange = validatePassword;
            confirm_password.onkeyup = validatePassword;
        </script>
</html>

 