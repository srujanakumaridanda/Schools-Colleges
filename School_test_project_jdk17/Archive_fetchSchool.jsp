<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.school.pillar.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%

	//String searchTextParam = request.getParameter("searchText");
    //out.println("search text is "+searchTextParam);
    
    String searchTextParam ="Medical Collges in Atmakur";
    
    // get the Results for the searchText
    SearchText sText = new SearchText();
    sText.setSearchText(searchTextParam);
    
    String schoolsJSONStr = sText.getSchoolsJSONArr();
   
	JSONObject jsonObj = new JSONObject(schoolsJSONStr);
	
	JSONArray schools = jsonObj.getJSONArray("places");
%>
<html>
<head>

<style>
table.schoolTable {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

table.schoolTable th {
    background-color: #4CAF50;
    color: white;
    padding: 10px;
}

table.schoolTable td {
    border: 1px solid #ddd;
    padding: 8px;
}

table.schoolTable tr:nth-child(even) {
    background-color: #f2f2f2;
}

table.schoolTable tr:hover {
    background-color: #ddd;
}
</style>
<script type="text/javascript">
$(document).ready(function () {

    let allPlaces = <%=schools%>;
    let currentPage = 1;
    const pageSize = 15;

    function showPage(page) {
        const start = (page - 1) * pageSize;
        const end = start + pageSize;
        const pageItems = allPlaces.slice(start, end);
        

        $("#schoolTableBody").html("");

        pageItems.forEach((place) => {
        	alert ("am inside"+place.formattedAddress);
            $("#schoolTableBody").append(`
                <tr>
                    <td>${place.formattedAddress}</td>
                    <td>${place.location.latitude}</td>
                    <td>${place.location.longitude}</td>
                    <td>${place.displayName.text}</td>
                </tr>
            `);
        });

        $("#pageNumber").text("Page " + page);
    }

    $("#nextBtn").click(function () {
        if ((currentPage * pageSize) < allPlaces.length) {
            currentPage++;
            showPage(currentPage);
        }
    });

    $("#prevBtn").click(function () {
        if (currentPage > 1) {
            currentPage--;
            showPage(currentPage);
        }
    });

    // Load first page
    showPage(currentPage);

});
</script>
<body>

<table class="schoolTable">
    <thead>
        <tr>
            <th>Address</th>
            <th>Latitude</th>
            <th>Longitude</th>
            <th>Name</th>
        </tr>
    </thead>
    <tbody id="schoolTableBody"></tbody>
</table>

<button id="prevBtn">Previous</button>
<span id="pageNumber">Page 1</span>
<button id="nextBtn">Next</button>
</body>
</html>
