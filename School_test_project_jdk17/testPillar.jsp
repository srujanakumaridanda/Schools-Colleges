<%@page import="com.school.pillar.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test Connection</title>
</head>
<body>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try{
	conn = DBConnection.getConn();
	pstmt  = conn.prepareStatement("SELECT CURRENT_DATE FROM DUAL");
	rs = pstmt.executeQuery();
	
	if (rs.next()) {
	    out.println("Current Date from Autonomous DB: " + rs.getDate(1));
	}
	}catch(SQLException e){
		// Print stack trace
	    e.printStackTrace();
	}
	finally{
		try{ if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
		try{ if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
		try{ if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
	}
%>


</body>
</html>