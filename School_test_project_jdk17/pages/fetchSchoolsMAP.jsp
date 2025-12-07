<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.school.pillar.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>

<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <%
        String searchTextParam = request.getParameter("searchText");
        String cityLatt = request.getParameter("latt");
        String cityLongit = request.getParameter("longit");
        
        double latt = 0;  
        double longit = 0;
        
        if(cityLatt != null && !cityLatt.trim().isEmpty()) {
            latt = Double.parseDouble(cityLatt);
        }
        if(cityLongit != null && !cityLongit.trim().isEmpty()) {
            longit = Double.parseDouble(cityLongit);
        }
        
        String schoolsJSONStr = "[]";
        String APIKey = "";
        
        if(searchTextParam != null && !searchTextParam.trim().isEmpty()) {
            SearchText sText = new SearchText();
            sText.setSearchText(searchTextParam);
            schoolsJSONStr = sText.getSchoolsJSONArr();
            APIKey = APIKeyDetails.getAPIKey();
        }
    %>
    
    <script>
        window.schoolsData = <%= schoolsJSONStr != null ? schoolsJSONStr : "[]" %>;
        window.apiKey = '<%= APIKey.replace("'", "\\'") %>';
        window.centerLat = <%= latt %>;
        window.centerLng = <%= longit %>;
    </script>
    
    <script async defer 
            src="https://maps.googleapis.com/maps/api/js?key=<%=APIKey%>&libraries=marker&callback=initMap">
    </script>
    
    <script type="text/javascript">
    function initMap() {
        console.log('Map init - Center:', window.centerLat, window.centerLng);
        
        const map = new google.maps.Map(document.getElementById('map'), {
            zoom: 12,
            center: { lat: window.centerLat, lng: window.centerLng }
        });
        
        const places = window.schoolsData;  // Limit 10
        //const places = window.schoolsData.slice(0, 10);
        const infoWindow = new google.maps.InfoWindow();
        
        
        places.forEach((place, index) => {
            const lat = parseFloat(place.location.latitude);
            const lng = parseFloat(place.location.longitude);
            
            const markerData = {
                schoolName: place.displayName.text || 'No Name',
                address: place.formattedAddress || 'No address',
                phone: place.nationalPhoneNumber || 'No phone' 
            };
            
            const marker = new google.maps.Marker({
                position: { lat, lng },
                map: map,
                title: markerData.schoolName,
                label: '' + (index + 1)
            });
            
            marker.userData = markerData;
            
            marker.addListener('click', function() {
                // ✅ NO template literals = NO JSP EL parsing!
                const content = '<div style="max-width: 280px; padding: 15px; font-family: Arial;">' +
                    '<div style="font-size: 16px; font-weight: bold; color: #2c3e50; margin-bottom: 10px;">' +
                    this.userData.schoolName +
                    '</div>' +
                    '<div style="color: #666; font-size: 14px; margin-bottom: 8px;">' +
                    '📍 ' + this.userData.address +
                    '</div>' +
                    '<div style="color: #27ae60; font-size: 16px; font-weight: bold;">' +  // Green for phone
                    '📞 ' + this.userData.phone +
                    '</div>' +
                    '</div>';
                
                //const infoWindow = new google.maps.InfoWindow({ content: content });
                infoWindow.setContent(content);
                infoWindow.open(map, this);
            });
        });

    }
    </script>
</head>
<body>
    <div id="map" style="height: 700px; width: 100%;"></div>
    
    <div class="MAPcontent">
        <b>YOU SEARCHED FOR: <%= searchTextParam %> (Center: <%= latt %>, <%= longit %>)</b>
    </div>
</body>
</html>
