<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
  <title>Nearby Schools in New Delhi with Map Highlights</title>
  <style>
    #map {
      height: 400px;
      width: 100%;
      margin-bottom: 10px;
    }
    #results {
      font-family: Arial, sans-serif;
      max-width: 400px;
    }
    #results div {
      margin-bottom: 8px;
    }
  </style>
</head>
<body>
  <h1>Nearby Schools in New Delhi</h1>

  <div id="map"></div>

  <div id="results">
    <c:forEach var="place" items="${places}">
      <c:choose>
        <c:when test="${not empty place.displayName}">
          ${place.displayName.text}
        </c:when>
        <c:otherwise>
          No name
        </c:otherwise>
      </c:choose>
      <br/>
    </c:forEach>
  </div>

  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCzY98IYPNy6N4IISMhWrWUx8qQ-0uEqLo&libraries=marker"></script>
  <script>
  alert("am in");
    // The 'places' data should come from your backend, e.g. set as JSP attribute and serialized to JSON:
   // const places = ${fn:escapeXml(placesJson)}; // Replace 'placesJson' with your JSON string of places from backend
const places = [
    {
      "displayName": { "text": "Greenwood High School" },
      "formattedAddress": "123 Maple St, New Delhi",
      "location": { "latitude": 28.6139, "longitude": 77.2090 }
    },
    {
      "displayName": { "text": "Riverdale Secondary School" },
      "formattedAddress": "456 River Rd, New Delhi",
      "location": { "latitude": 28.6145, "longitude": 77.2105 }
    },
    {
      "displayName": { "text": "Sunshine Public School" },
      "formattedAddress": "789 Sunset Blvd, New Delhi",
      "location": { "latitude": 28.6157, "longitude": 77.2080 }
    }
  ];
    function initMap() {
     
      const center = { lat: 28.6139, lng: 77.2090 };
      const map = new google.maps.Map(document.getElementById('map'), {
        zoom: 13,
        center: center,
        mapId: "d9d82490aa2580c6700ecd59"
      });

      places.forEach((place, index) => {
        if (place.location) {
          const position = {
            lat: place.location.latitude,
            lng: place.location.longitude
          };

          /*
          const marker = new google.maps.Marker({
            position: position,
            map: map,
            title: place.displayName ? place.displayName.text : 'No name',
            label: `${index + 1}`
          });
		  */
		  
		  const marker = new google.maps.marker.AdvancedMarkerElement({
			    map: map, // Your map instance
			    position: position, // LatLng object
			    title: place.displayName ? place.displayName.text : 'No name',
			    content: null // optional: you can provide a custom HTMLElement if you want a fully custom marker
			});
		  
          const infoWindow = new google.maps.InfoWindow({
            content: `<strong>${marker.title}</strong><br>${place.formattedAddress || 'No address'}`
          });

          marker.addListener('click', () => {
            infoWindow.open(map, marker);
          });
        }
      });
    }

    window.onload = initMap;
  </script>
</body>
</html>
