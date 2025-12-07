<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.school.pillar.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Dependent Dropdown Using AJAX</title>
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function loadDistrictsDropdown() {
        	
            var stateSelectedValue = $('#statesDropdown').val();
            alert("SateSelecte"+stateSelectedValue);
            $.ajax({
                url: 'fetchDistricts.jsp',
                type: 'GET',
                data: { selectedState : stateSelectedValue },
                success: function (response) {
                    $('#distDropdown').html(response);
                },
                error: function () {
                    alert('Error loading second dropdown');
                }
            });
        }
        
		function loadCityDropdown() {
        	alert("inside");
            var distSelectedValue = $('#distDropdown').val();
            alert("dist" + distSelectedValue);
            var stateSelectedValue = $('#statesDropdown').val();
            alert("state" + stateSelectedValue);
            
            alert("CitySelecte"+distSelectedValue);
            $.ajax({
                url: 'fetchCities.jsp',
                type: 'GET',
                data: { selectedState : stateSelectedValue, selectedDistrict : distSelectedValue },
                success: function (response) {
                    $('#cityDropdown').html(response);
                },
                error: function () {
                    alert('Error loading second dropdown');
                }
            });
        }
    </script>
</head>
<body>

<h2>Select Category and Item</h2>


<select id="statesDropdown" name="statesDropdown" onchange="loadDistrictsDropdown()">
			  <option value="">-- Select Category --</option>

			  
<%
  	Connection conn = DBConnection.getConn();
    String statesQuery = "Select state_id,state_name from states"; 
    Statement statesST = null;
	ResultSet statesRS = null;
	
	String distQuery = "select dist_id, dist_name from districts where state_id = 134";
	PreparedStatement distPS = null;
	ResultSet distRS = null;
	
	try
	{
		statesST = conn.createStatement();
		statesRS = statesST.executeQuery(statesQuery);
		while (statesRS.next()){
			//out.println("inside the loop"+statesRS.getInt(1)+statesRS.getString(2)); 
			%>
			<option value=" <%= statesRS.getInt(1)%>"> <%=statesRS.getString(2) %>
			
			</option>
			<%
		}
	}
	catch (Exception e ) {e.printStackTrace();}
	finally {
		if (statesST != null) statesST.close();
		if (statesRS != null) statesRS.close();
		if (conn != null ) conn.close();
		
	}
	
  
%>
</select>
 <h2>Second dropdown populated from database</h2>
    <select id="distDropdown" name="distDropdown" onchange="loadCityDropdown()">
        <option value="">-- Select Value --</option>
    </select>
    
    <h2>Second cities populated from database</h2>
    <select id="cityDropdown" name="cityDropdown">
        <option value="">-- Select Value --</option>
    </select>
</body>
</html>
