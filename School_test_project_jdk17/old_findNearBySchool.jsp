<!DOCTYPE html>
<html>
<head>
  <title>Nearby Schools - New Places API</title>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCzY98IYPNy6N4IISMhWrWUx8qQ-0uEqLo&libraries=places"></script>
  <style>
    #map {
      font-family: Arial, sans-serif;
      max-width: 400px;
      max-height : 200x;
      margin-top: 20px;
      margin-left: 200px;
      border: 1px solid #ccc;
      padding: 300px;
    }
  </style>
</head>
<body>
  <h2>Pixel and Tile Coordinates for Chicago</h2>
  <div id="map"></div>
  <div id="info"></div>

  <script>
    const TILE_SIZE = 256;

    function initMap() {
      const chicago = new google.maps.LatLng(41.85, -87.65);
      //const vzm = new google.map.LatLng(75.87,81.45);
      const map = new google.maps.Map(document.getElementById('map'), {
        center: chicago,
        zoom: 3
      });

      const infoWindow = new google.maps.InfoWindow();
      infoWindow.setContent(createInfoWindowContent(chicago, map.getZoom()));
      infoWindow.setPosition(chicago);
      infoWindow.open(map);

      map.addListener('zoom_changed', () => {
        infoWindow.setContent(createInfoWindowContent(chicago, map.getZoom()));
        infoWindow.open(map);
      });

      updateInfoDiv(chicago, map.getZoom());
      map.addListener('zoom_changed', () => {
        updateInfoDiv(chicago, map.getZoom());
      });
    }

    function project(latLng) {
      let siny = Math.sin((latLng.lat() * Math.PI) / 180);
      siny = Math.min(Math.max(siny, -0.9999), 0.9999);

      return new google.maps.Point(
        TILE_SIZE * (0.5 + latLng.lng() / 360),
        TILE_SIZE * (0.5 - Math.log((1 + siny) / (1 - siny)) / (4 * Math.PI))
      );
    }

    function createInfoWindowContent(latLng, zoom) {
      const scale = 1 << zoom;
      const worldCoordinate = project(latLng);
      const pixelCoordinate = new google.maps.Point(
        Math.floor(worldCoordinate.x * scale),
        Math.floor(worldCoordinate.y * scale)
      );
      const tileCoordinate = new google.maps.Point(
        Math.floor(pixelCoordinate.x / TILE_SIZE),
        Math.floor(pixelCoordinate.y / TILE_SIZE)
      );

      return [
        'Chicago, IL',
        'LatLng: ' + latLng.toUrlValue(6),
        'Zoom level: ' + zoom,
        'World Coordinate: ' + worldCoordinate.toString(),
        'Pixel Coordinate: ' + pixelCoordinate.toString(),
        'Tile Coordinate: ' + tileCoordinate.toString()
      ].join('<br>');
    }

    function updateInfoDiv(latLng, zoom) {
      const scale = 1 << zoom;
      alert(scale);
      const worldCoordinate = project(latLng);
      const pixelCoordinate = new google.maps.Point(
        Math.floor(worldCoordinate.x * scale),
        Math.floor(worldCoordinate.y * scale)
      );
      const tileCoordinate = new google.maps.Point(
        Math.floor(pixelCoordinate.x / TILE_SIZE),
        Math.floor(pixelCoordinate.y / TILE_SIZE)
      );

      const infoDiv = document.getElementById('info');
      infoDiv.innerHTML = `
        <strong>LatLng:</strong> ${latLng.toUrlValue(6)}<br>
        <strong>Zoom level:</strong> ${zoom}<br>
        <strong>World Coordinate:</strong> ${worldCoordinate.toString()}<br>
        <strong>Pixel Coordinate:</strong> ${pixelCoordinate.toString()}<br>
        <strong>Tile Coordinate:</strong> ${tileCoordinate.toString()}
      `;
    }

    window.onload = initMap;
  </script>
</body>
</html>
