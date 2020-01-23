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
   <script>
           var country_arr = new Array("Afghanistan", "Albania", "Algeria", "American Samoa", "Angola", "Anguilla", "Antartica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Ashmore and Cartier Island", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "British Virgin Islands", "Brunei", "Bulgaria", "Burkina Faso", "Burma", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Clipperton Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo, Democratic Republic of the", "Congo, Republic of the", "Cook Islands", "Costa Rica", "Cote d'Ivoire", "Croatia", "Cuba", "Cyprus", "Czeck Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Europa Island", "Falkland Islands (Islas Malvinas)", "Faroe Islands", "Fiji", "Finland", "France", "French Guiana", "French Polynesia", "French Southern and Antarctic Lands", "Gabon", "Gambia, The", "Gaza Strip", "Georgia", "Germany", "Ghana", "Gibraltar", "Glorioso Islands", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guernsey", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard Island and McDonald Islands", "Holy See (Vatican City)", "Honduras", "Hong Kong", "Howland Island", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Ireland, Northern", "Israel", "Italy", "Jamaica", "Jan Mayen", "Japan", "Jarvis Island", "Jersey", "Johnston Atoll", "Jordan", "Juan de Nova Island", "Kazakhstan", "Kenya", "Kiribati", "Korea, North", "Korea, South", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia, Former Yugoslav Republic of", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Man, Isle of", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Midway Islands", "Moldova", "Monaco", "Mongolia", "Montserrat", "Morocco", "Mozambique", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcaim Islands", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romainia", "Russia", "Rwanda", "Saint Helena", "Saint Kitts and Nevis", "Saint Lucia", "Saint Pierre and Miquelon", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Scotland", "Senegal", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia and South Sandwich Islands", "Spain", "Spratly Islands", "Sri Lanka", "Sudan", "Suriname", "Svalbard", "Swaziland", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Tobago", "Toga", "Tokelau", "Tonga", "Trinidad", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "Uruguay", "USA", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Virgin Islands", "Wales", "Wallis and Futuna", "West Bank", "Western Sahara", "Yemen", "Yugoslavia", "Zambia", "Zimbabwe");
           function print_country(country_id){
                    // given the id of the <select> tag as function argument, it inserts <option> tags
                    var option_str = document.getElementById(country_id);
                    option_str.length=0;
                    option_str.options[0] = new Option('Select Country','');
                    option_str.selectedIndex = 0;
                    for (var i=0; i<country_arr.length; i++) {
                            option_str.options[option_str.length] = new Option(country_arr[i],country_arr[i]);
                    }
            }
   </script>  
   <script  language="Javascript">	
            $(document).ready(function(){
                    // make edit buttons appear/disappear on click for personal and contact info

                    $(".editoptions").click(function(event){

                            $(".editbuttons").slideToggle("fast");
                            $(".editoptions").toggle();	
                            $("#submitchanges").toggle();
                            $("#updatechanges").toggle();
                           
                    });	
                    
                     $("#catbut").click(function(event){
                            $(".editoptions1").hide();	
                            $(".editoptions3").toggle();
                    });	
                    
                    $("#catbut11").click(function(event){
                            $(".editoptions11").hide();	
                            $(".editoptions31").toggle();
                    });	
	

                    // make fields lose css class after losing focus 

                    $(".fieldvalues1").blur(function(e){			
                            if ($(e.target).val() === ""){	// if field was left empty reset to its original value
                                    SingleReset(e.target.id);				
                            }

                            $(e.target).removeClass("edit");				
                            $(e.target).attr("readonly", true);

                    });   
                    
                     $(".fieldvalues2").blur(function(e){			
                            if ($(e.target).val() === ""){	// if field was left empty reset to its original value
                                    SingleReset(e.target.id);				
                            }
                            $(".editoptions1").show();	
                            $(".editoptions3").toggle();

                    });         
            });
    </script>
    <script>
        
        function Edit(fieldID){
                var field = document.getElementById(fieldID);
                if(field.readOnly){				
                        $(field).attr("readonly", false);				
                        $(field).addClass("edit");	
                        $(field).focus();
                }
        }
        
        function Edit2(fieldID){
                var field = document.getElementByClassName(fieldID);             				              	
                $(field).hide();
        }
        
        function Edit3(fieldID,fieldID2,id){
                var field = document.getElementsByClassName(fieldID);
                var field2 = document.getElementsByClassName(fieldID2);
                var field3 = document.getElementById(id);	
                $(field).hide();
                $(field2).show();
                field3.value = field3.defaultValue;
        }

        // when erase button is clicked the field erases its content, becomes editable and gets the cursor focus

        function Delete(fieldID){
                var field = document.getElementById(fieldID);				
                field.value = "";
                $(field).attr("readonly", false);				
                $(field).addClass("edit");	
                $(field).focus();						
        }

        // resets value of a single field

        function SingleReset(fieldID){
                var field = document.getElementById(fieldID);				
                field.value = field.defaultValue;
        }

        // resets value of a single field reset all change fields if not submit button has been clicked 

        function AllReset(){
                var fields = document.getElementsByClassName("fieldvalues1");
                var fields2 = document.getElementsByClassName("fieldvalues2");
                var fields3 = document.getElementsByClassName("editoptions3");
                var fields4 = document.getElementsByClassName("editoptions1");
                var fields31 = document.getElementsByClassName("editoptions31");
                var fields41 = document.getElementsByClassName("editoptions11");
                var fields12 = document.getElementById("country");
                var fields21 = document.getElementById("CAT2");
                var i;

                for (i=0;i<fields.length; i++) {		
                        fields[i].value = fields[i].defaultValue;
                }	
                for (i=0;i<fields2.length; i++) {		
                        fields2[i].value = fields2[i].defaultValue;
                }  
               	
                fields12.value = fields12.defaultValue;
                fields21.value = fields21.defaultValue;
                	
                $(fields3).hide();
                $(fields4).show();
                $(fields31).hide();
                $(fields41).show();
                
               
        }
    </script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Auction's Profile </title>

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
    session=request.getSession(true);
    if(session.getAttribute("b_price_span") == null || session.getAttribute("latitude") ==null){
        session.setAttribute("f_bid_span","");
        session.setAttribute("b_price_span","");
        session.setAttribute("latitude_span","");
        session.setAttribute("longitude_span","");
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
     %>
                            <div class="container">         
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h1 class="page-header">

                                        </h1>
                                        <ol class="breadcrumb">
                                            <li><a href="index_login.jsp">Home</a></li>
                                            <li><a href="auction_management.jsp">Auctions Management</a></li>
                                            <li class="active">Auction's Profile </li>
                                        </ol>
                                    </div>
                                </div>
                                
                                 <div class="row">
                                    <div class="col-lg-12">   
                                        <form class="register" action="DeleteServlet" method="post">
                                            <input type="submit"  class="breadcrumb"  value="Delete Auction" />  
                                            <input type="hidden" name="item_id1"  value="<%= rs.getString("item_id")%>"/>
                                            <input type="hidden" name="started"  value="<%= rs.getTimestamp("started")%>"/>
                                            <input type="hidden" name="ends"  value="<%= rs.getTimestamp("ends")%>"/>
                                        </form>
                                    </div>
                                </div>
                                
                                <div class="wrapper">
                                    <h1><br> </h1>
                                    <div class="content">
                                        <div id="form_wrapper" class="form_wrapper">
                                            <form class="register" action="UpdateServlet" method="post">
                                                <h3>Profile</h3>
                                                <fieldset class="row1">
                                                    <legend>Auction Information</legend>
                                                    <div class="column">
                                                        <div>
                                                            <label>Name</label>
                                                            <input type="text" id="Name" name="rname" value="<%=rs.getString("name") %>" class="fieldvalues1" readonly="readonly" required/> 
                                                            <input type="hidden" name="item_id1"  value="<%= rs.getString("item_id")%>"/>                                                              
                                                            <button  type="button" class="editbuttons"  onclick=Delete("Name") title="Delete Field"> <img src="images/eraser.png " width="16" height="16" /> </button>
                                                            <button  type="button" class="editbuttons"  onclick=Edit("Name") title="Edit Field"> <img src="images/pencil.png" width="16" height="16" /> </button>
                                                        </div>
                                                        <div>
                                                            <label>Buy Price</label>
                                                            <%
                                                                if(rs.getDouble("buy_price")==0)
                                                                {
                                                            %>
                                                                <input type="text" id="BP" name="b_price" value="" class="fieldvalues1" readonly="readonly"/>   
                                                            <%
                                                                }else{
                                                            %>
                                                                 <input type="text" id="BP" name="b_price" value="<%= rs.getString("buy_price")%>" class="fieldvalues1" readonly="readonly"/> 
                                                            <%
                                                                }
                                                            %>
                                                            <button  type="button" class="editbuttons"  onclick=Delete("BP") title="Delete Field"> <img src="images/eraser.png " width="16" height="16" /> </button>
                                                            <button  type="button" class="editbuttons"  onclick=Edit("BP") title="Edit Field"> <img src="images/pencil.png" width="16" height="16" /> </button>
                                                            <span class="span" style="color:red"><%= session.getAttribute("b_price_span") %></span>
                                                        </div>                            
                                                    </div>
                                                    <div class="column">
                                                        <div>
                                                            <label>First_Bid</label>
                                                            <input type="text" id="FB" name="f_bid" value="<%=rs.getString("first_bid") %>" class="fieldvalues1" readonly="readonly" required/>
                                                            <button  type="button" class="editbuttons"  onclick=Delete("FB") title="Delete Field"> <img src="images/eraser.png " width="16" height="16" /> </button>
                                                            <button  type="button" class="editbuttons"  onclick=Edit("FB") title="Edit Field"> <img src="images/pencil.png" width="16" height="16" /> </button>
                                                            <span class="span" style="color:red"><%= session.getAttribute("f_bid_span") %></span>
                                                        </div>                    
                                                    </div>
                                                </fieldset>                                               
                                                <fieldset class="row1">
                                                    <legend>Location Information</legend>                                                 
                                                    <div class="column">
                                                        <div class="editoptions11">
                                                            <label>Country</label>
                                                            <input type="text" id="CNTR" value="<%= rs.getString("country") %>" class="fieldvalues1" name="country1" readonly="readonly"/>
                                                            <button  type="button" class="editbuttons" id="catbut11"  onclick=Edit2("editoptions11") title="Edit Field"> <img src="images/pencil.png" width="16" height="16" /> </button>
                                                        </div>                                                       
                                                        <div style="display: none" class="editoptions31">
                                                            <label>Country</label>
                                                        </div>
                                                        <div style="padding-left: 30px; display: none; padding-top: 6px" class="editoptions31">                                              
                                                            <select onchange="print_state('city',this.selectedIndex);" id="country" name ="country"></select>   
                                                            <button  type="button" class="editbuttons" id="catbut2"  onclick=Edit3("editoptions31","editoptions11","country") title="Cancel"> <img src="images/cross.png" width="16" height="16" /> </button>
                                                        </div>
                                                       
                                                        <div>
                                                            <label>Latitude</label>
                                                            <%
                                                                if(rs.getDouble("latitude")==0)
                                                                {
                                                            %>
                                                                <input type="text" name="latitude" id="LAT" value="" class="fieldvalues1" readonly="readonly"/>   
                                                            <%
                                                                }else{
                                                            %>
                                                                 <input type="text" name="latitude" id="LAT" value="<%= rs.getString("latitude") %>" class="fieldvalues1" readonly="readonly"/>
                                                            <%
                                                                }
                                                            %>                                                      
                                                            <button  type="button" class="editbuttons"  onclick=Delete("LAT") title="Delete Field"> <img src="images/eraser.png " width="16" height="16" /> </button>
                                                            <button  type="button" class="editbuttons"  onclick=Edit("LAT") title="Edit Field"> <img src="images/pencil.png" width="16" height="16" /> </button>
                                                            <span class="span" style="color:red"><%= session.getAttribute("latitude_span") %></span>
                                                        </div>  
                                                        <%
                                                        if(rs.getDouble("latitude")!=0)
                                                        {
                                                        %>
                                                        <div>
                                                             <label>Map</label>
                                                            <div id="map" style=" height:250px; width:400px;"></div>
                                                            <script>
                                                                    var google;
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
                                                            <input type="text" name="location" id="LCT" value="<%=rs.getString("location") %>" class="fieldvalues1" readonly="readonly" required/>
                                                             <button  type="button" class="editbuttons"  onclick=Delete("LCT") title="Delete Field"> <img src="images/eraser.png " width="16" height="16" /> </button>
                                                            <button  type="button" class="editbuttons"  onclick=Edit("LCT") title="Edit Field"> <img src="images/pencil.png" width="16" height="16" /> </button>
                                                        </div>
                                                        <div>
                                                            <label>Longitude</label>
                                                            <%
                                                                if(rs.getDouble("longitude")==0)
                                                                {
                                                            %>
                                                                <input type="text" name="longitude" id="LNGT" value="" class="fieldvalues1" readonly="readonly" required/>
                                                            <%
                                                                }else{
                                                            %>
                                                                 <input type="text" name="longitude" id="LNGT" value="<%=rs.getString("longitude") %>" class="fieldvalues1" readonly="readonly" required/>
                                                            <%
                                                                }
                                                            %>          
                                                            
                                                            <button  type="button" class="editbuttons"  onclick=Delete("LNGT") title="Delete Field"> <img src="images/eraser.png " width="16" height="16" /> </button>
                                                            <button  type="button" class="editbuttons"  onclick=Edit("LNGT") title="Edit Field"> <img src="images/pencil.png" width="16" height="16" /> </button>
                                                            <span class="span" style="color:red"><%= session.getAttribute("longitude_span") %></span>
                                                        </div>
                                                        <div>                                                            
                                                            <script language="javascript">print_country("country");</script>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                                <fieldset class="row1">
                                                    <legend>Description</legend>
                                                   <div class="column">
                                                        <div>
                                                            <label>Description</label>
                                                            <textarea name="desc" id="DES" maxlength="1000" style="height:200px; width: 643px;" class="fieldvalues1" readonly="readonly" required><%= rs.getString("description") %></textarea>
                                                            <br /><br />
                                                            <button  type="button" class="editbuttons"  onclick=Delete("DES") title="Delete Field"> <img src="images/eraser.png " width="16" height="16"/> </button>
                                                            <button  type="button" class="editbuttons"  onclick=Edit("DES") title="Edit Field"> <img src="images/pencil.png" width="16" height="16" /> </button>
                                                        </div>                                                       
                                                    </div>                                                   
                                                </fieldset>
                                                <fieldset class="row1">
                                                   <legend>Categories</legend>
                                                   <div class="column">
                                                        <div style="padding-left: 30px;" class="editoptions1">
                                                            <select id="CAT" size="3" multiple class="fieldvalues2" name="category1" disabled>
                                                                <%      
                                                                int count=0;
                                                                pst = conn.prepareStatement("select * from TED.ITEM_TO_CATEGORY where ITEM_ID=?"); 
                                                                pst.setString(1, u);
                                                                rs = pst.executeQuery();
                                                                while(rs.next())
                                                                {
                                                                    count++;
                                                                %>
                                                                   <option><%= rs.getString("category") %></option>
                                                                <%
                                                                }
                                                                %>
                                                            </select> 
                                                            <input type="hidden" name="count"  value="<%=count%>"/>                                                         
                                                            <button  type="button" class="editbuttons" id="catbut"  onclick=Edit2("editoptions1") title="Edit Field"> <img src="images/pencil.png" width="16" height="16" /> </button>
                                                        </div>
                                                    </div> 
                                                    <div class="column">
                                                        <div style="padding-left: 30px; display: none" class="editoptions3">
                                                            <select name="category" id="CAT2" size="3" multiple>
                                                                <%                           
                                                                pst = conn.prepareStatement("select * from TED.CATEGORIES");                              
                                                                rs = pst.executeQuery();
                                                                while(rs.next())
                                                                {
                                                                %>
                                                                   <option><%= rs.getString("category") %></option>
                                                                <%
                                                                }
                                                                %>
                                                            </select>  
                                                            <button  type="button" class="editbuttons" id="catbut2"  onclick=Edit3("editoptions3","editoptions1","CAT2") title="Cancel"> <img src="images/cross.png" width="16" height="16" /> </button>

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
                                                <div class="bottom" style="height:70px;">                                                    
                                                        <input type="submit" id="submitchanges" class="signbutton" name="submitchanges" value="Update" />
                                                        <a id="cancelchanges" href="javaScript:void();" class="editoptions" onclick="AllReset()" >Cancel</a> 
                                                        <a id="updatechanges" href="UpdateImages.jsp?item_id=<%=u%>">Update images</a>
							<a id="changes" href="javaScript:void();" class="editoptions">Update Fields</a>                                                                                                                                                                  
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

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
    <%
        session=request.getSession(false);
        if(session!=null)
        {
            session.removeAttribute("f_bin_span");
            session.removeAttribute("b_price_span");
            session.removeAttribute("latitude_span");
            session.removeAttribute("longitude_span");
        }
     %>
</body>

</html>

 
