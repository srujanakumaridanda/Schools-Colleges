<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<%@ page import="com.school.pillar.DBConnection" %>
<%@ page import="java.net.URL, java.net.URI, java.net.HttpURLConnection, java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>
<%@ page import="com.school.pillar.DBConnection" %>
<%!

public JSONObject getCityLatLang(int geoId,String userName){
	
	 StringBuilder resultHTML = new StringBuilder();
     JSONObject json = null;
     try {
         String apiUrl = "http://api.geonames.org/getJSON?geonameId="+geoId+"&username="+ userName;

         URI uri = new URI(apiUrl);
         URL url = uri.toURL();
        
         HttpURLConnection conn = (HttpURLConnection) url.openConnection();
         conn.setRequestMethod("GET");

         BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
         String inputLine;
         StringBuffer apiResponse = new StringBuffer();
         while ((inputLine = in.readLine()) != null) {
             apiResponse.append(inputLine);
         }
         in.close();
         json = new JSONObject(apiResponse.toString());
                          
     } catch (Exception e) {
         resultHTML.append("Error: ").append(e.getMessage());
     }
     return json;
}
%>
<%!
    	JSONArray getCities(String distGeoId, String userName) {
        StringBuilder resultHTML = new StringBuilder();
        JSONArray cities = null; 
        try {
            String apiUrl = "http://api.geonames.org/childrenJSON?geonameId=" + distGeoId + "&username=" + userName;

            URI uri = new URI(apiUrl);
            URL url = uri.toURL();
           
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuffer apiResponse = new StringBuffer();
            while ((inputLine = in.readLine()) != null) {
                apiResponse.append(inputLine);
            }
            in.close();

            JSONObject json = new JSONObject(apiResponse.toString());
            cities = json.getJSONArray("geonames");
                       
        } catch (Exception e) {
            resultHTML.append("Error: ").append(e.getMessage());
        }
        return cities;
    } 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
  String userName = "SrujanaDanda";	
  String distDetailsQry = "SELECT distinct STATE_ID, DIST_ID, GEOID FROM DISTRICTS where state_id =148 ORDER BY STATE_ID, DIST_ID ";
  Statement distDetailsST = null;
  ResultSet distDetailsRS = null;
  
  String insertCityQry = "INSERT INTO CITY (CITY_ID_SEQ.NEXTVAL,DIST_ID,STATE_ID,CITY_NAME,CITY_LATT,CITY_LONGIT,GEOID) VALUES ";
  PreparedStatement insertCityPS = null;
  
  String citySeqQry = "SELECT CITY_ID_SEQ.NEXTVAL FROM DUAL";
  PreparedStatement citySeqPS = null;
  ResultSet citySeqRS = null;
  int citySeqVal =0;
  
  int cityGeoId = 0;
  String cityName = null;
  Double cityLat = null;
  Double cityLng = null;
  String fclName = null;
  int len = 0;
  
  int stateId = 0;
  int distId =0;
  String distGeoId = null;
  JSONArray cities = null;
  
  try {
	  
	  Connection conn = DBConnection.getConn();
	  
	  distDetailsST = conn.createStatement();
	  distDetailsRS = distDetailsST.executeQuery(distDetailsQry);
	  
	  while (distDetailsRS.next()) {
		  stateId = distDetailsRS.getInt("STATE_ID");
		  distId = distDetailsRS.getInt("DIST_ID");
		  distGeoId = ""+distDetailsRS.getInt("GEOID");
		 
	  	  cities = getCities(distGeoId,userName);
	  	  len = cities.length();
	      
	  	   
	  	  
	  	  insertCityQry = "INSERT INTO CITY (CITY_ID,DIST_ID,STATE_ID,CITY_NAME,CITY_LATT,CITY_LONGIT,GEOID) VALUES ";
	  	  
	  	  for (int i = 0; i < len-2 ; i++) {
	         JSONObject city = cities.getJSONObject(i);
	         cityName = city.getString("name");
	         cityGeoId = city.getInt("geonameId");
	         cityLat = city.getDouble("lat");
	         cityLng = city.getDouble("lng");
	         fclName = city.getString("fclName");
	         
	         citySeqPS = conn.prepareStatement(citySeqQry);
		  	  citySeqRS = citySeqPS.executeQuery();
		  		
		  	  if (citySeqRS.next()) {
		            citySeqVal = citySeqRS.getInt(1);
		      }  		
		  	  citySeqRS.close();
	         
	         insertCityQry = insertCityQry +"("+citySeqVal+","+ distId +","+stateId +",'"+ cityName +"'," + cityLat +"," + cityLng +"," +cityGeoId+"),";
  			
	  	  }
	  	JSONObject city = cities.getJSONObject(len-1);
        cityName = city.getString("name");
        cityGeoId = city.getInt("geonameId");
        cityLat = city.getDouble("lat");
        cityLng = city.getDouble("lng");
        fclName = city.getString("fclName");
        
        citySeqPS = conn.prepareStatement(citySeqQry);
	  	  citySeqRS = citySeqPS.executeQuery();
	  		
	  	  if (citySeqRS.next()) {
	            citySeqVal = citySeqRS.getInt(1);
	      }  		
	  	  citySeqRS.close();
        insertCityQry = insertCityQry +"("+citySeqVal+","+ distId +","+stateId +",'"+ cityName +"'," + cityLat +"," + cityLng +"," +cityGeoId+")";
			
	  	 out. println(insertCityQry);
	  	insertCityPS = conn.prepareStatement(insertCityQry);
  		//int cityRes = 0;
  		int cityRes = insertCityPS.executeUpdate();
  		if (cityRes>0) {out.println("Data inserted successfully!");
  		} else { out.println("Failed to insert data."); }

	  }
  
  
  } catch(Exception e) { e.printStackTrace(); }
  finally {
	  if (distDetailsST != null) {distDetailsST.close();}
	  if (distDetailsRS != null) {distDetailsRS.close();}
	  if (insertCityPS != null) {insertCityPS.close();}
  }
 
%>
</body>
</html>