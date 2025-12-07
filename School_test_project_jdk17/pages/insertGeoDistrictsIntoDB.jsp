<%@ page import="java.sql.*" %>
<%@ page import="com.school.pillar.DBConnection" %>
<%@ page import="java.net.URL, java.net.URI, java.net.HttpURLConnection, java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>



<%!
    	JSONArray getDistricts(String stateGeoId, String userName, Connection DBconn) {
        StringBuilder resultHTML = new StringBuilder();
        JSONArray districts = null; 
        try {
            String apiUrl = "http://api.geonames.org/childrenJSON?geonameId=" + stateGeoId + "&username=" + userName;

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
            districts = json.getJSONArray("geonames");
           
			
                       
        } catch (Exception e) {
            resultHTML.append("Error: ").append(e.getMessage());
        }
        return districts;
    } 
%>

<HTML>


<%

String stateDetailsQry = "SELECT STATE_ID_SEQ.NEXTVAL, STATE_ID,GEOID FROM STATES, DUAL ";
String distSeqQry = "SELECT DIST_ID_SEQ.NEXTVAL FROM DUAL";

// get DB Connection

Connection conn = null;
Statement stateDetailsST = null;
ResultSet stateDetailsRS = null;

PreparedStatement insertDistPS = null;

PreparedStatement distSeqPS = null;
ResultSet distSeqRS = null;


//String countryGeoId ="1269750";
String userName = "SrujanaDanda";
int stateId = 0;
String stateGeoId = null;
String distGeoId = null;
String distName = null;

int stateSeqVal = 0;
int distSeqVal = 0;
int distLen =0;
String insertDistQry= null;

try{
	
	//get connection
	conn = DBConnection.getConn();
	stateDetailsST = conn.createStatement();
	distSeqPS = conn.prepareStatement(distSeqQry);
	
	stateDetailsRS = stateDetailsST.executeQuery(stateDetailsQry);
	
	while(stateDetailsRS.next()){
		
		stateSeqVal = stateDetailsRS.getInt(1);
		stateId = stateDetailsRS.getInt("state_id");
		stateGeoId = ""+stateDetailsRS.getInt("geoid");
        
        	
  		JSONArray districts = getDistricts(stateGeoId, userName, conn);
  		distLen = districts.length();
  		insertDistQry = "INSERT INTO districts (state_id,dist_id,dist_name,geoid) VALUES ";
  		
  		
  		for (int j = 0; j < distLen; j++) {
  	        JSONObject district = districts.getJSONObject(j);
  	        distName = district.getString("name");
  	        
  	        // insert districts of each state into database
  	        distGeoId = ""+district.getInt("geonameId");
  	  		//out.println("District name "+distName);
  	  		
  	 		
  	  		distSeqRS = distSeqPS.executeQuery();
  	  		
  	  		if (distSeqRS.next()) {
  	            distSeqVal = distSeqRS.getInt(1);
  	        }  		
  	  		distSeqRS.close(); 
  	  		
	  	  	if (j == distLen-1) {
	        	insertDistQry = insertDistQry + "("+stateId+","+distSeqVal+",'"+distName+"',"+distGeoId+")";
	        }
	        else {
	        	insertDistQry = insertDistQry + "("+stateId+","+distSeqVal+",'"+distName+"',"+distGeoId+"),";
	        }
	  	  	
        
  	 	 }
  		
  		out.println(insertDistQry+"<br>");
  		insertDistPS = conn.prepareStatement(insertDistQry);
  		//int distRes = 0;
  		int distRes = insertDistPS.executeUpdate();
  		if (distRes>0) {out.println("Data inserted successfully!");
  		} else { out.println("Failed to insert data."); }

  	}
}catch(SQLException e){
  			 //Print stack trace
  		    e.printStackTrace();

	

    
		} finally{
			
						
			try{ if (stateDetailsRS != null) stateDetailsRS.close(); } catch (Exception e) { e.printStackTrace(); }
			try{ if (distSeqRS != null) distSeqRS.close(); } catch (Exception e) { e.printStackTrace(); }
			try{ if (insertDistPS != null) insertDistPS.close(); } catch (Exception e) { e.printStackTrace(); }
			try{ if (distSeqRS != null) distSeqRS.close(); } catch (Exception e) { e.printStackTrace(); }
			try{ if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
	}

%>
<body>
<p> </p>
</body>
</HTML>
