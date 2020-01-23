<%@page import="java.util.Vector"%>
<%@page import="Auction.TopAuctions"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Result Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/auction_management.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.11.3.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
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
                        <li><a href="search.jsp">Navigate/Search</a>
                        </li>
                        <li class="active">Results</li>
                    </ol>
                </div>
            </div>
            <ul class="nav nav-tabs">
                <%
                if(session.getAttribute("TopAuctions")!=null)
                {
                %>
                    <li><a data-toggle="tab" href="#home1">Recommendations</a></li>
                <%
                }
                %>
                <li class="active"><a data-toggle="tab" href="#home">1</a></li>
                <%
                    String s=(String) session.getAttribute("count");
        
                    int count= Integer.parseInt(s);
                    //int count=10;
                    String str= (String) session.getAttribute("Results_per_page");
                    int Results_per_page=Integer.parseInt(str);
                    count-=Results_per_page;
                    int c=1;
                    while(count>0)
                    {
                        c++;
                        str="#menu"+c;
                        
                %>
                
                <li><a data-toggle="tab" href="<%=str%>"><%=c%></a></li>
                
                <%
                        
                        
                        count-=Results_per_page;
                        
                    }
                    count= Integer.parseInt(s);
                %>
                
            </ul>
            <div class="tab-content" >                   
                <div id="home" class="tab-pane fade in active" style="height:500px; font:16px/26px Georgia, Garamond, Serif;overflow:auto;">
                    
                <%
                       
                    if(count==0)
                    {
                %>
                   
                    
                    
                    <fieldset class="row1">
                        <h3>
                            There are no results
                        </h3>
                    </fieldset>
                    
                <%
                    }
                    boolean status = false; 
                    Connection conn = null;  
                    PreparedStatement pst = null;  

          
                    try 
                    {
                        Calendar calendar = Calendar.getInstance();
                        java.sql.Timestamp current_time = new java.sql.Timestamp(calendar.getTime().getTime());
                        
                        String from_amount=(String) session.getAttribute("from_amount");
                        String to_amount=(String) session.getAttribute("to_amount");
                        String country=(String) session.getAttribute("country");
                        String description=(String) session.getAttribute("description");
                        String category=(String) session.getAttribute("category");
                        
                        DbConnection db = new DbConnection();
                        conn = db.getConn();   
                        ResultSet rs;
                        ResultSet rs2;
                        pst = conn.prepareStatement("select * from TED.AUCTIONS");  

                        rs = pst.executeQuery();  
                        int c1=1;
                        count=0;
                        while(rs.next())
                        {
                            if(!category.equals("Select Category"))
                            {
                                pst = conn.prepareStatement("select * from TED.ITEM_TO_CATEGORY where ITEM_ID=? and CATEGORY=?");
                                pst.setString(1, rs.getString("ITEM_ID"));
                                pst.setString(2, category);
                                rs2 = pst.executeQuery();
                                if(!rs2.next())
                                {
                                    continue;
                                }
                            }

                            if(!country.equals(""))
                            {
                                if(!country.equals(rs.getString("COUNTRY")))
                                {
                                    continue;
                                }
                            }

                            if(!description.equals(""))
                            {
                                str=rs.getString("DESCRIPTION");
                                if(!str.contains(description))
                                {
                                    continue;
                                }
                            }

                            if(!from_amount.equals(""))
                            {
                                Double d1=Double.parseDouble(from_amount);;
                                if(d1>rs.getDouble("CURRENTLY"))
                                {
                                    continue;
                                }
                            }

                            if(!to_amount.equals(""))
                            {
                                Double d2=Double.parseDouble(to_amount);;
                                if(d2<rs.getDouble("CURRENTLY"))
                                {
                                    continue;
                                }
                            }
                            if(current_time.after(rs.getTimestamp("STARTED")) && current_time.before(rs.getTimestamp("ENDS"))&& rs.getDouble("CURRENTLY")!=rs.getDouble("BUY_PRICE"))                       
                            {
                                count++;
                                //ektupwsi
                                if(session.getAttribute("name") == null)//visitor
                                {
                                    
                %>
                
                    <fieldset class="row1">
                        <form class="login active" action="profile_auction.jsp" method="post">   
                            <input type="hidden" name="item_id" value="<%=rs.getString("ITEM_ID")%>"/>
                            <div class="column">
                                <input type="submit" value="<%=rs.getString("NAME")%>"></input> 
                            </div>
                        </form>
                    </fieldset>
                    
                <%
                                }else if(rs.getString("USERNAME").equals((String)session.getAttribute("username"))){
                               
                %>

                    <fieldset class="row1">
                        <form class="login active" action="profile_auction.jsp" method="post">   
                            <input type="hidden" name="item_id" value="<%=rs.getString("ITEM_ID")%>"/>
                            <div class="column">
                                <input type="submit" value="<%=rs.getString("NAME")%>"></input> 
                            </div>
                        </form>
                    </fieldset>
                    
                    
                <% 
                                }else{
                                    %>
                    
                    
                    <fieldset class="row1">
                        <form class="login active" action="profile_auction_bid.jsp" method="post">   
                            <input type="hidden" name="item_id" value="<%=rs.getString("ITEM_ID")%>"/>
                            <div class="column">
                                <input type="submit" value="<%=rs.getString("NAME")%>"></input> 
                            </div>
                        </form>
                    </fieldset>
                    
                    <%
                                }
                    
                    
                    
                                if(count==Results_per_page && c1<=c && c!=1)
                                {
                                    count=0;
                                    c1++;
                                    str="menu"+c1;
                                    //kleinei t div kai anoigei t epomeno

                                    %>
                    
                </div>
                                    
                <div id="<%=str%>" class="tab-pane fade" style="height:500px; font:16px/26px Georgia, Garamond, Serif;overflow:auto;">
                                    
                    
                    <%                                    
                                }
                            }
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
                    }  
                %>

   
                </div>               
                <div id="home1" class="tab-pane fade" style="height:500px; font:16px/26px Georgia, Garamond, Serif;overflow:auto;">
                    <%
                    if(session.getAttribute("TopAuctions")!=null)
                    {
                        Vector<TopAuctions> tp= (Vector<TopAuctions>) session.getAttribute("TopAuctions");
                        for(int i=0;i<tp.size();++i)
                        {
                    %>
                    <fieldset class="row1">
                        <form class="login active" action="profile_auction.jsp" method="post">   
                            <input type="hidden" name="item_id" value="<%=tp.get(i).id%>"/>
                            <div class="column">
                                <input type="submit" value="<%=tp.get(i).name%>"></input> 
                            </div>
                        </form>
                    </fieldset>
                    <%
                        }
                        if(tp.size()==0)
                        {
                    %>
                    <fieldset class="row1">
                        <h3>
                            There are no recommendations
                        </h3>
                    </fieldset>
                    <%
                        }
                    }
                    %>                  
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
