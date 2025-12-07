<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.school.pillar.*"%>
<%@ page import="java.sql.*" %>
  
<%

	String reqParam = request.getParameter("selectedState");
	int selectedState = Integer.parseInt(reqParam.trim());
	if ( selectedState == 0) {
	    out.print("<option value=''>-- Select Value --</option>");
	    return;
	}
	

  	//Connection conn = DBConnection.getConn();
  	Connection conn = DBConnection.getConn(getServletContext());
    	
	String distQuery = "select dist_id, dist_name from districts where state_id = ?";
	PreparedStatement distPS = null;
	ResultSet distRS = null;
	int dist_id = 0;
	String dist_name = null;
	
	try
	{
		distPS = conn.prepareStatement(distQuery);
		distPS.setInt(1,selectedState);
		distRS = distPS.executeQuery();
		out.print("<option value= 'null'> -- Select District --</option>");
		while (distRS.next()){
			dist_id = distRS.getInt(1);
			dist_name = distRS.getString(2);
			 out.print("<option value='" + dist_id + "'>" + dist_name + "</option>");
			
		}
	}
	catch (Exception e ) {e.printStackTrace();}
	finally {
		
		if (distPS !=null) try{distPS.close();} catch(Exception e){e.printStackTrace();}
		if (distRS !=null) try{distRS.close();} catch(Exception e){e.printStackTrace();}
		if (conn !=null) try{conn.close();} catch(Exception e){e.printStackTrace();}
	}
	
  
%>

