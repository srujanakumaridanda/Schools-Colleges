<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.school.pillar.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>

<html>
<head>
<!--  link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/loading.css"> -->
<link rel="stylesheet" type="text/css" href="../css/loading.css">
</head>
<body>
<div class="loading" id="loading">
    <div class="spinner"></div>
    <div>Loading schools...</div>
</div>

<div class="content" id="mainContent">

<table class="schoolTable">

<thead>
    <tr>
        <th class="truncate">Name</th>
        <th style="width: 150px;"><button id = "UP" value = "UP" onclick="sortup()">&#9650;</button> User Rating <button id = "DOWN" value ="DOWN" onclick="sortdown()">&#9660;</button></th>
        <th style="width: 200px;">WebSite</th>
        <th style="width: 150px;">Phone</th>
        <th>Address</th>
    </tr>
</thead>
<tbody id="schoolTableBody">
<%!
   public void displaySortedUPlist(){
	
	
}
%>

<%!
public void displaySortedDOWNlist(){
	
}
%>
<div class="ancor" align="right">
<%
	 String searchTextParam = request.getParameter("searchText");
     out.println("YOU SEARCHED FOR  "+searchTextParam);
     out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
     
     String buttonSelected = request.getParameter("btnSelect");
        
    // get the Results for the searchText
    SearchText sText = new SearchText();
    sText.setSearchText(searchTextParam);
    
    String schoolsJSONStr = sText.getSchoolsJSONArr();
    // out.println("json string "+schoolsJSONStr);
    
	//JSONObject jsonObj = new JSONObject(schoolsJSONStr);
	
	//JSONArray schools = jsonObj.getJSONArray("places");
	JSONArray schools = new JSONArray(schoolsJSONStr);
	
	if (buttonSelected.equalsIgnoreCase("1") ) {
		schools = sText.sortJSONArrayDOWN(schools);
	} else if (buttonSelected.equalsIgnoreCase("2")) {
		schools = sText.sortJSONArrayUP(schools);
	}  
	// get page start and end lengths
    int totalRows = schools.length();
    int pageSize = 15;

    // Get current page from request
    int currentPage = 1;
    if (request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }

    int start = (currentPage - 1) * pageSize;
    int end = Math.min(start + pageSize, totalRows);
	String escapeFormattedAddress = null;
	%>
	
	<% 
		 if (end < totalRows) {
	%>
		<a href="#" class="pagination-link" data-page="<%= currentPage + 1 %>">  Next </a>
	 <%
		 }
		     out.println("   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ");   
		   
        if (currentPage > 1) {
     %>
        <a href="#" class="pagination-link" data-page="<%= currentPage - 1 %>">   Previous </a>

    <%	
    	out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
    	}
	%>
 </div>      
<%
   for (int i = start; i < end; i++) {
            JSONObject place = schools.getJSONObject(i);
            String placeId = place.optString("id", "N/A"); 
			JSONObject location = place.getJSONObject("location");
			double lat = location.getDouble("latitude");
			double lng = location.getDouble("longitude");
			String rating = place.optString("rating","N/A");
			String phone = place.optString("nationalPhoneNumber","N/A");
			String price = place.optString("priceLevel", "N/A");
            String website = place.optString("websiteUri", "N/A");
            JSONObject displayName = place.getJSONObject("displayName");
            escapeFormattedAddress = HelperClass.escapeString(place.getString("formattedAddress"));
   
	    	out.println("<tr><td class=\"truncate\">" + displayName.getString("text") +"</td>");     
	    	out.println("<td class=\"truncate\" style=\"text-align: center; width: 150px;\">" + rating + "</td>");
	    	if (website == "N/A") out.println("<td class=\"truncate\"> N/A </td>");
	    	else out.println("<td class=\"truncate\" style=\"width: 200px;\"><a href =  ' " + website + " ' target= '_blank' >" +website + " </a></td>");
	    	out.println("<td class=\"truncate\" style=\"width: 150px;\">" + phone + "</td>");
	        out.println("<td class=\"truncate\"> " +  escapeFormattedAddress  +"</td></tr>" );
	        
	}
	   
	    %>
 </tbody>
</table>
</div>
 <!-- ✅ jQuery + Pagination + Loading script -->
<script>
$(document).ready(function() {
	
	
    setTimeout(function() {
        $('#loading').hide();
        $('#mainContent').addClass('loaded');
    }, 200);
});
</script>
</body>
</html>