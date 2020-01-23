<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="Database.DbConnection"%>
<%
 
  int iNumPhoto ;
 
  
  if ( request.getParameter("image_id") != null )
  {
   
    iNumPhoto = Integer.parseInt(request.getParameter("image_id")) ; 
    Connection conn = null;  
    PreparedStatement pst = null;  
    ResultSet rs = null;  
  
    try
    {  
        DbConnection db = new DbConnection();
        conn = db.getConn();  
        // get the image from the database
       // byte[] imgData = photo.getPhoto( conn, iNumPhoto  ) ; 
        String req = "" ;
        Blob img ;
        byte[] imgData = null ;
        Statement stmt = conn.createStatement ();

        // Query
        req = "Select IMAGE From TED.IMAGES Where IMAGE_ID = " + iNumPhoto ;

        ResultSet rset  = stmt.executeQuery ( req ); 

        while (rset.next ())
        {    
          img = rset.getBlob(1);
          imgData = img.getBytes(1,(int)img.length());
        }    

        rset.close();
        stmt.close();
        // display the image
        response.setContentType("image/jpg");
        OutputStream o = response.getOutputStream();
        o.write(imgData);
        o.flush(); 
        o.close();
    }
    catch (Exception e)
    {
      e.printStackTrace();
      throw e;
    }
    finally
    {
        
    }  
  }
%>
