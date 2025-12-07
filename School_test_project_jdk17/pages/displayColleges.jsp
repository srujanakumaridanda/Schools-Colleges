<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.school.pillar.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Schools and Colleges</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/displaySchoolUI.css">
  <style>
  
  .container {
    display: flex;
    gap: 20px;
}



</style>
  
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    	var sortButton = 0;
    	var schoolTypeSelected = "";
    	
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
	    
		function setSchoolTypeSelected(clkbtn){
			schoolTypeSelected = clkbtn.id;
			 
			const buttons = document.querySelectorAll('.sc-btn');

			buttons.forEach(function(btn) {
				  btn.disabled = false;
				  btn.classList.remove('sc-btn-selected');
				  btn.classList.add('sc-btn');
				});
			
			const selected_buttons = document.querySelectorAll('.sc-btn-selected');

			selected_buttons.forEach(function(btn) {
				  btn.disabled = false;
				  btn.classList.remove('sc-btn-selected');
				  btn.classList.add('sc-btn');
				});
			
			clkbtn.disabled = true;
			clkbtn.classList.add('sc-btn-selected');
			clkbtn.classList.remove('sc-btn');
			
		}
		
        function loadDistrictsDropdown() {
        	
            var stateSelectedValue = $('#statesDropdown').val();
            
            $.ajax({
                url: 'fetchDistricts.jsp',
                type: 'GET',
                data: { selectedState : stateSelectedValue },
                success: function (response) {
                    $('#distDropdown').html(response);
                },
                error: function () {
                    alert('Error loading Colleges');
                }
            });
        }
        
		function loadCityDropdown() {
        
            var distSelectedValue = $('#distDropdown').val();
            var stateSelectedValue = $('#statesDropdown').val();
                      
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
			if (statesDropdown.selectedIndex == 0) {
				stateSelectedValue = "";
				alert("Select State");
			}
		            
            var distSelectedValue = distDropdown.options[distDropdown.selectedIndex].text;
            if (distDropdown.selectedIndex == 0) {
            	distSelectedValue = "";
				alert("Select District");
			}
			
            //var citySelectedValue = $('#cityDropdown').val();
            var citySelectedValue = cityDropdown.options[cityDropdown.selectedIndex].text;
            if (cityDropdown.selectedIndex == 0) {
            	citySelectedValue = "";
				alert("Select City");
			}
			
                    
                               
            var SearchText = schoolTypeSelected+ " Colleges in "+ citySelectedValue +", "
            					+distSelectedValue + "," + stateSelectedValue;
                 
            if(cityDropdown.selectedIndex != 0){  
            	
            $.ajax({
                url: 'fetchSchools.jsp',
                type: 'GET',
                data: { searchText : SearchText , btnSelect : sortButton, page: page },
                success: function (response) {
                    $('#schoolTableDiv').html(response);
                },
                error: function () {
                    alert('Error loading Colleges');
                }
            });
            } // if city selected
            
            
        }

	
		function loadSchoolsListMAP(page = 1) {
			
			var stateSelectedValue = statesDropdown.options[statesDropdown.selectedIndex].text;
			if (statesDropdown.selectedIndex == 0) {
				stateSelectedValue = "";
				alert("Select State");
			}
		            
            var distSelectedValue = distDropdown.options[distDropdown.selectedIndex].text;
            if (distDropdown.selectedIndex == 0) {
            	distSelectedValue = "";
				alert("Select District");
			}
			
            //var citySelectedValue = $('#cityDropdown').val();
            var citySelectedValue = cityDropdown.options[cityDropdown.selectedIndex].text;
            var cityLatt = cityDropdown.options[cityDropdown.selectedIndex].dataset.latt;
            var cityLongit = cityDropdown.options[cityDropdown.selectedIndex].dataset.longit;
            
            if (cityDropdown.selectedIndex == 0) {
            	citySelectedValue = "";
				alert("Select City");
			}
			
                    
                               
            var SearchText = schoolTypeSelected+ " Colleges in "+ citySelectedValue +", "
            					+distSelectedValue + "," + stateSelectedValue;
                 
            if(cityDropdown.selectedIndex != 0){  
            	
            $.ajax({
                url: 'fetchSchoolsMAP.jsp',
                type: 'GET',
                data: { searchText : SearchText , btnSelect : sortButton, latt :cityLatt, longit: cityLongit, page: page },
                success: function (response) {
                    $('#schoolTableDiv').html(response);
                },
                error: function () {
                    alert('Error loading Colleges');
                }
            });
            } // if city selected
            
            
        }

		
		
	</script>
</head>
<body>

<div class="container">
    <div class="cs-div-left">
    	<div class="cs-div-left-up"></div>
    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    	<button class= "home" onclick="window.location.href='displayMainPage.jsp'"> Home </button>
	</div>
    <div class="cs-div-right">
		<div class="cs-div-right-up">
			<button class="sc-btn" id = "ENGINEERING" onclick="setSchoolTypeSelected(this)">
				 ENGINEERING
			</button>
			<button class="sc-btn" id="MEDICAL" onclick="setSchoolTypeSelected(this)">
				 MEDICAL
			</button>
			<button class="sc-btn" id="LAW" onclick="setSchoolTypeSelected(this)">
				 LAW
			</button>
			<button class="sc-btn" id="MANAGEMENT" onclick="setSchoolTypeSelected(this)">
				 MANAGEMENT
			</button>
		</div>
    	<div class="cs-div-right-down">
    	<div id="select-div" class = "cs-select">
		    
		    <select class = "cs-select" id="statesDropdown" name="statesDropdown" onchange="loadDistrictsDropdown()">
				<option value="" >  Select State &#9660 </option>
		
					  
			<%
		  	//Connection conn = DBConnection.getConn();
			Connection conn = DBConnection.getConn(getServletContext());
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
		        <option value=""> Select District &#9660 </option>
		    </select>
		    
		   
		    <select class = "cs-select" id="cityDropdown" name="cityDropdown" >
		        <option value=""> Select City &#9660</option>
		    </select>
		  
		  </div>  <!--  end of select div  -->
		  </div>  <!--  end of cs div right down  -->
	
	
			<button align = center class="search-btn" onclick="loadSchoolsList()">
						Click to SEARCH COLLEGES
			</button>
			
			<button align = right class="map-btn" onclick="loadSchoolsListMAP()">
						MAP VIEW	<img src="../images/map.png" alt="Clickable Button" style="width:30px;">
			</button>
		</div>  <!-- end of cs right div -->
    <!--  div class="cs-div-adv">Right Div </div>  -->
</div>  
    <div id="schoolTableDiv">
    </div>
   
</body>
</html>
