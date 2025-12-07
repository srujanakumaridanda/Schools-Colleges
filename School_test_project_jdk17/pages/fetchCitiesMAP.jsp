<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.school.pillar.*"%>
<%@ page import="java.sql.*" %>
  
<%

	String stateParam = request.getParameter("selectedState");
    String distParam = request.getParameter("selectedDistrict");
   
	int selectedState = Integer.parseInt(stateParam.trim());
	int selectedDistrict = Integer.parseInt(distParam.trim());
	
	if ( selectedState == 0 || selectedDistrict == 0) {
	    out.print("<option value=''>-- Select Value --</option>");
	    return;
	}
	

  	Connection conn = DBConnection.getConn();
    	
	String cityQuery = "select city_id, city_name, geoid , city_latt, city_longit from city where state_id = ? and dist_id= ?";
	PreparedStatement cityPS = null;
	ResultSet cityRS = null;
	int city_id = 0;
	String city_name = null;
	double city_latt = 0;
	double city_longit = 0;
	try
	{
		cityPS = conn.prepareStatement(cityQuery);
		cityPS.setInt(1,selectedState);
		cityPS.setInt(2,selectedDistrict);
		
		cityRS = cityPS.executeQuery();
		out.print("<option value= 'null'> -- Select City --</option>");
		while (cityRS.next()){
			city_id = cityRS.getInt(3);
			city_name = cityRS.getString(2);
			city_latt = cityRS.getDouble(4);
			city_longit = cityRS.getDouble(5);
			out.println("<option value='" + city_name + "' data-latt ="+city_latt+" data-longit = "+city_longit+">" + city_name + "</option>");
			
		}
	}
	catch (Exception e ) {e.printStackTrace();}
	finally {
		
		if (cityPS !=null) try{cityPS.close();} catch(Exception e){e.printStackTrace();}
		if (cityRS !=null) try{cityRS.close();} catch(Exception e){e.printStackTrace();}
		if (conn !=null) try{conn.close();} catch(Exception e){e.printStackTrace();}
	}
	
  
%>

