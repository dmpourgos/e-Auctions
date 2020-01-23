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
    <title>Profile Auction Bid</title>

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
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
    
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
                    pst = conn.prepareStatement("select * from TED.AUCTIONS where ITEM_ID=?"); 
                    pst.setString(1, u);

                    rs = pst.executeQuery();
                    status = rs.next();  
                    if(status)
                    {
                        String usr=rs.getString("username");
     %>
                            <div class="container">         
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h1 class="page-header">

                                        </h1>
                                        <ol class="breadcrumb">
                                            <li><a href="index_login.jsp">Home</a></li>
                                            <li class="active">Profile Auction Bid</li>
                                        </ol>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-lg-12">   
                                        <form class="register" action="BidServlet" method="post">
                                            <label>Bid</label>
                                            <input type="text" class="breadcrumb" name="bid" required>                               
                                            <input type="submit" onclick="return confirm('Are you sure you want to continue')"  class="breadcrumb"  value="Submit"/>  
                                            <input type="hidden" name="item_id1"  value="<%= rs.getString("item_id")%>"/>
                                            <input type="hidden" name="cur"  value="<%= rs.getString("currently")%>"/>
                                            <input type="hidden" name="b_pr"  value="<%= rs.getString("buy_price")%>"/>
                                            <input type="hidden" name="ends"  value="<%= rs.getTimestamp("ends")%>"/>
                                            <input type="hidden" name="usrn"  value="<%= session.getAttribute("username")%>"/>
                                            <input type="hidden" name="auction_name"  value="<%= rs.getString("name")%>"/>
                                        </form>
                                    </div>
                                </div>
                                
                                <div class="wrapper">                                   
                                    <div class="content">
                                        <div id="form_wrapper" class="form_wrapper">
                                                <h3>Profile</h3>
                                                <fieldset class="row1">
                                                    <legend>Auction Information</legend>
                                                    <div class="column">
                                                        <div>
                                                            <label>Name</label>
                                                            <input type="text" value="<%=rs.getString("name") %>" readonly="readonly"/>
                                                        </div>
                                                        <%
                                                            if(rs.getDouble("buy_price")==0)
                                                            {
                                                        %>
                                                        <div>
                                                            <label>Buy Price</label>
                                                            <input type="text" value="" readonly="readonly"/>
                                                        </div> 
                                                        <%
                                                            }else{
                                                        %>
                                                        <div>
                                                            <label>Buy Price</label>
                                                            <input type="text" value="<%=rs.getString("buy_price") %>" readonly="readonly"/>
                                                        </div>  
                                                        <% }   %>
                                                        <div>
                                                            <label>Number Of Bids</label>
                                                            <input type="text" value="<%=rs.getString("number_of_bids") %>" readonly="readonly"/>
                                                        </div>   
                                                    </div>
                                                    <div class="column">
                                                        <div>
                                                            <label>First_Bid</label>
                                                            <input type="text" value="<%=rs.getString("first_bid") %>" readonly="readonly"/>
                                                        </div>       
                                                        <div>
                                                            <label>Currently</label>
                                                            <input type="text" value="<%=rs.getString("currently") %>" readonly="readonly"/>
                                                        </div>  
                                                        <div>
                                                            <label>End Time</label>
                                                            <input type="text" value="<%=rs.getTimestamp("ends") %>" readonly="readonly"/>
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
                                                            <label>Latitude</label>
                                                             <%
                                                                if(rs.getDouble("latitude")==0)
                                                                {
                                                            %>
                                                               <input type="text" value="" readonly="readonly"/>   
                                                            <%
                                                                }else{
                                                            %>
                                                                <input type="text" value="<%= rs.getString("latitude") %>" readonly="readonly"/>
                                                            <%
                                                                }
                                                            %>             
                                                            
                                                        </div>  
                                                        <%
                                                        if(rs.getDouble("latitude")!=0)
                                                        {
                                                        %>
                                                        <div>
                                                             <label>Map</label>
                                                            <div id="map" style=" height:250px; width:400px;"></div>
                                                            <script>
                                                                    function initMap() {
                                                                        var myLatLng = {lat: <%= rs.getString("latitude") %>, lng: <%=rs.getString("longitude") %> };

                                                                        var map = new google.maps.Map(document.getElementById('map'), {
                                                                          zoom: 4,
                                                                          center: myLatLng
                                                                        });

                                                                        var marker = new google.maps.Marker({
                                                                          position: myLatLng,
                                                                          map: map,
                                                                          title: 'Hello World!'
                                                                        });
                                                                      }
                                                            </script>
                                                            <script async defer src="https://maps.googleapis.com/maps/api/js?signed_in=true&callback=initMap"></script>
                                                        </div>
                                                        <%}%>              
                                                    </div>
                                                    <div class="column">
                                                        <div>
                                                            <label>Location</label>
                                                            <input type="text" value="<%=rs.getString("location") %>" readonly="readonly"/>
                                                        </div>
                                                        <div>
                                                            <label>Longitude</label>
                                                             <%
                                                                if(rs.getDouble("longitude")==0)
                                                                {
                                                            %>
                                                                <input type="text" value="" readonly="readonly"/>
                                                            <%
                                                                }else{
                                                            %>
                                                                 <input type="text" value="<%=rs.getString("longitude") %>" readonly="readonly"/>
                                                            <%
                                                                }
                                                            %>          
                                                            
                                                        </div>                                                       
                                                    </div>
                                                </fieldset>
                                                <fieldset class="row1">
                                                    <legend>Description</legend>
                                                   <div class="column">
                                                        <div>
                                                            <label>Description</label>
                                                            <textarea name="desc" maxlength="1000" style="height:200px; width: 643px;" readonly="readonly"><%= rs.getString("description") %></textarea>
                                                        </div>                                                       
                                                    </div>                                                   
                                                </fieldset>
                                                <fieldset class="row1">
                                                   <legend>Categories</legend>
                                                   <div class="column">
                                                        <div style="padding-left: 30px">
                                                            <select name="category" size="3" multiple disabled>
                                                                <%                           
                                                                pst = conn.prepareStatement("select * from TED.ITEM_TO_CATEGORY where ITEM_ID=?"); 
                                                                pst.setString(1, u);
                                                                rs = pst.executeQuery();
                                                                while(rs.next())
                                                                {
                                                                %>
                                                                   <option><%= rs.getString("category") %></option>
                                                                <%
                                                                }
                                                                %>
                                                            </select> 
                                                        </div>
                                                    </div> 
                                                </fieldset>
                                                        
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
                                                                <a href="image.jsp?image_id=<%=rs.getInt("IMAGE_ID")%>" target="_blank"><img src="image.jsp?image_id=<%=rs.getInt("IMAGE_ID")%>" width="140" height="100"></a> 
                                                            <%
                                                            }
                                                            %>
                                                            
                                                        </div>
                                                    </div> 
                                                </fieldset>
                                                <fieldset class="row1">
                                                    <legend>Seller Information</legend>
                                                    <div class="column">
                                                        <div>
                                                            <label>Username</label>
                                                            <input type="text"  name="usr" value="<%=usr%>" class="fieldvalues1" readonly="readonly"/>                                                            
                                                        </div>                                                       
                                                    </div>
                                                    <%
                                                        pst = conn.prepareStatement("select * from TED.USERS where USERNAME=?"); 
                                                        pst.setString(1, usr);
                                                        rs = pst.executeQuery();
                                                    
                                                        status = rs.next();  
                                                        if(status)
                                                        {
                                                    %>
                                                    <div class="column">
                                                        <div>
                                                            <label>Seller Rating</label>
                                                            <input type="text" id="FB" name="f_bid" value="<%=rs.getInt("s_rating")%>" class="fieldvalues1" readonly="readonly" required/>                                                            
                                                        </div>                    
                                                    </div>
                                                    <% } %>
                                                </fieldset>               
                                                <div class="bottom" style="height:70px;">                                    
                                                        <div class="clear"></div>                                                                     
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

 
