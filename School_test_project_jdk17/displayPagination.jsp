<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.school.pillar.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Schools and Colleges</title>
  <style>
  <link rel="stylesheet" type="text/css" href="/css/displaySchoolUI.css">
  .container {
    display: flex;
    gap: 20px;
}

div.cs-div-left-up {
  /* left div smaller */
  background: #f2f2f2;
  width: 135px;
  height: 135px;
  background-image: url("images/college_degree_hat.png");
  padding: 5px 10px 5px 10px;
  border: 1px solid #aaa;
  border-radius: 6px;
  background-repeat: no-repeat;
  background-position: right 10px center;
  background-size: contain;
  cursor: pointer;
}
div.cs-div-left-down {
  /* left div smaller */
  background: #f2f2f2;
  width: 135px;
  height: 75px;
  background-image: url("images/college_degree_hat.png");
  padding: 5px 10px 5px 10px;
  border: 1px solid #aaa;
  border-radius: 6px;
  background-repeat: no-repeat;
  background-position: right 10px center;
  background-size: contain;
  cursor: pointer;
}

div.cs-div-right {
    width: 75%;      /* right div larger */
    height: 135px;
    background: #e0e0e0;
}
  
div.cs-div-right-up {
    width: 100%;      /* right div larger */
    height: 145px;
    background: #e0e0fd;
}

div.cs-div-right-down {
    width: 100%;      /* right div larger */
    height: 100px;
    background: #e0e0ef;
}
div.cs-div-adv {
  width: 235px;
  height: 235px;
  background-image: url("images/college_degree_hat.png");
  padding: 5px 10px 5px 10px;
  border: 1px solid #aaa;
  border-radius: 6px;
  background-repeat: no-repeat;
  background-position: right 10px center;
  background-size: contain;
  cursor: pointer;
}


  select.cs-select {
  width: 220px;
  height: 35px;
  font-family: Verdana, sans-serif;
  font-size: 14px;
  padding: 5px 40px 5px 10px;
  border: 1px solid #aaa;
  border-radius: 6px;
  background-color: #ffc;
  background-image: url("arrow-down.svg");
  background-repeat: no-repeat;
  background-position: right 10px center;
  background-size: 16px;
  appearance: none;
  cursor: pointer;
}

table.schoolTable {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    table-layout: fixed; /* Add this */
}

table.schoolTable th {
    background-color: #4CAF50;
    color: white;
    padding: 10px;
    overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
}

table.schoolTable td {
    border: 1px solid #ddd;
    padding: 8px;
    overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
}

table.schoolTable tr:nth-child(even) {
    background-color: #f2f2f2;
}

table.schoolTable tr:hover {
    background-color: #ddd;
}

table.schoolTable td.truncate {
      cursor: pointer;
      position: relative;
    }

    /* On hover, expand and show full content */
table.schoolTable td.truncate:hover {
      white-space: normal; /* Allow wrap */
      overflow: visible;
      background-color: #ffffcc; /* Highlight */
      z-index: 1;
      position: relative;
    }
</style>
  
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    	var sortButton = 0;
	    //call schools list on page links
	    $(document).on('click', '.pagination-link', function(e) {
	        e.preventDefault();
	        var page = $(this).data('page');
	        loadSchoolsList(page);
	    });
      
	    
	    function sortdown() {
            sortButton =1;   
            loadSchoolsList(1);
    	 }
     
		function sortup() {
			sortButton =2;	
			loadSchoolsList(1);
		}
	    
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
        
            var distSelectedValue = $('#distDropdown').val();
            alert("dist" + distSelectedValue);
            var stateSelectedValue = $('#statesDropdown').val();
            alert("state" + stateSelectedValue);
            
            $.ajax({
                url: 'fetchCities.jsp',
                type: 'POST',
                data: { selectedState : stateSelectedValue, selectedDistrict : distSelectedValue },
                success: function (response) {
                    $('#cityDropdown').html(response);
                },
                error: function () {
                    alert('Error loading second dropdown');
                }
            });
        }
		
		function loadSchoolsList(page = 1) {
			
			var stateSelectedValue = statesDropdown.options[statesDropdown.selectedIndex].text;
            alert("state selected" + stateSelectedValue);
            
            var distSelectedValue = distDropdown.options[distDropdown.selectedIndex].text;
            alert("dist selected" + distSelectedValue);
            
            var citySelectedValue = $('#cityDropdown').val();
            alert("NEW CitySelecte"+citySelectedValue);
            
                    
                               
            var SearchText = " Collges in "+ citySelectedValue +", "
            					+distSelectedValue + "," + stateSelectedValue;
                 
            
            $.ajax({
                url: 'fetchSchools.jsp',
                type: 'GET',
                data: { searchText : SearchText , btnSelect : sortButton, page: page },
                success: function (response) {
                    $('#schoolTableDiv').html(response);
                },
                error: function () {
                    alert('Error loading second dropdown');
                }
            });
            
            
        }
    </script>
</head>
<body>

<div class="container">
    <div class="cs-div-left">
    	<div class="cs-div-left-up"></div>
    	<div class="cs-div-left-down"></div>
	</div>
    <div class="cs-div-right">
		<div class="cs-div-right-up"></div>
    	<div class="cs-div-right-down"></div>
	</div>
    <div class="cs-div-adv">Right Div </div>
</div>


<div id="select-div" class = "cs-select">
    
    <select class = "cs-select" id="statesDropdown" name="statesDropdown" onchange="loadDistrictsDropdown()">
		<option value="">  Select State  </option>

			  
	<%
  	Connection conn = DBConnection.getConn();
    String statesQuery = "Select state_id,state_name from states"; 
    Statement statesST = null;
	ResultSet statesRS = null;
	
	try
	{
		statesST = conn.createStatement();
		statesRS = statesST.executeQuery(statesQuery);
		
		while (statesRS.next()){
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

    <select class = "cs-select" id="distDropdown" name="distDropdown" onchange="loadCityDropdown()">
        <option value=""> Select District </option>
    </select>
    
   
    <select class = "cs-select" id="cityDropdown" name="cityDropdown" onchange="loadSchoolsList()">
        <option value=""> Select City</option>
    </select>
  </div>  
  
    <div id="schoolTableDiv">
    </div>
   
</body>
</html>
