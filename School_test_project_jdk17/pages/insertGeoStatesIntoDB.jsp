<%@ page import="java.sql.*" %>
<%@ page import="com.school.pillar.DBConnection" %>
<%@ page import="java.net.URL, java.net.URI, java.net.HttpURLConnection, java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>


<%!
    	JSONArray getStatesByCountryId(String countryGeoId, String userName) {
        StringBuilder resultHTML = new StringBuilder();
        JSONArray states = null; 
        try {
            String apiUrl = "http://api.geonames.org/childrenJSON?geonameId=" + countryGeoId + "&username=" + userName;

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
            states = json.getJSONArray("geonames");
			
                       
        } catch (Exception e) {
            resultHTML.append("Error: ").append(e.getMessage());
        }
        return states;
    }
%>

<%!
    /*	JSONArray getDistricts(String stateGeoId, String userName, Connection DBconn) {
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
    } */
%>
%>
<HTML>


<%

String qry = "INSERT INTO states (state_id,state_name,geoId) VALUES ";
String distQry = null;
String stateSeqQry = "SELECT STATE_ID_SEQ.NEXTVAL FROM DUAL";
String distSeqQry = "SELECT DIST_ID_SEQ.NEXTVAL FROM DUAL";

// get DB Connection

Connection conn = null;
PreparedStatement ps = null;
PreparedStatement distPS = null;
PreparedStatement stateSeqPS = null;
PreparedStatement distSeqPS = null;
ResultSet rs = null;
ResultSet stateSeqRS = null;
ResultSet distSeqRS = null;
String stateName = null;
String countryGeoId ="1269750";
String userName = "SrujanaDanda";
String stateGeoId = null;
String distGeoId = null;
String distName = null;
int stateSeqVal = 0;
int distSeqVal = 0;
try{
	
	//get connection
	conn = DBConnection.getConn();
	stateSeqPS = conn.prepareStatement(stateSeqQry);
	distSeqPS = conn.prepareStatement(distSeqQry);
	
	//get States from geo names	
	JSONArray states = getStatesByCountryId(countryGeoId, userName);
	int len = states.length();
	int distLen = 0;
    for (int i = 0; i < len ; i++) {
        JSONObject state = states.getJSONObject(i);
        stateName = state.getString("name");
        
        // insert districts of each state into database
        stateGeoId = ""+state.getInt("geonameId");
  		//out.println(stateGeoId+"");
  		
  		stateSeqRS = stateSeqPS.executeQuery();
  		
  		if (stateSeqRS.next()) {
            stateSeqVal = stateSeqRS.getInt(1);
        }  		
  		stateSeqRS.close(); 
  		
  		/*
  		JSONArray districts = getDistricts(stateGeoId, userName, conn);
  		distLen = districts.length();
  		distQry = "INSERT INTO districts (state_id,dist_id,dist_name,geoid) VALUES ";
  		
  		
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
	        	distQry = distQry + "("+stateSeqVal+","+distSeqVal+",'"+distName+"',"+distGeoId+")";
	        }
	        else {
	        	distQry = distQry + "("+stateSeqVal+","+distSeqVal+",'"+distName+"',"+distGeoId+"),";
	        }
        
  	 	 }
  		
  		out.println(distQry+"<br>");
  		distPS = conn.prepareStatement(distQry);
  		int distRes = distPS.executeUpdate();
  		
  		*/
  		
  		// get state_id_seq from dual
  		
  		
  		
  		
  		if (i == len-1) {
        	qry = qry + "("+stateSeqVal+",'"+stateName+"',"+stateGeoId+")";
        }
        else {
        	qry = qry + "("+stateSeqVal+",'"+stateName+"',"+stateGeoId+"),";
        }
        
    }
    out.println(qry);
   
    ps  = conn.prepareStatement(qry);  
    //int result = 0;
	int result  = ps.executeUpdate();
	

    if (result>0) {out.println("Data inserted successfully!");
	} else { out.println("Failed to insert data."); }

 	}catch(SQLException e){
		 //Print stack trace
	    e.printStackTrace();
} finally{
	
		try{ if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
		try{ if (stateSeqRS != null) stateSeqRS.close(); } catch (Exception e) { e.printStackTrace(); }
		try{ if (distSeqRS != null) distSeqRS.close(); } catch (Exception e) { e.printStackTrace(); }
		try{ if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
		try{ if (distPS != null) distPS.close(); } catch (Exception e) { e.printStackTrace(); }
		try{ if (stateSeqPS != null) stateSeqPS.close(); } catch (Exception e) { e.printStackTrace(); }
		try{ if (distSeqPS != null) distSeqPS.close(); } catch (Exception e) { e.printStackTrace(); }
		try{ if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
}

%>
<body>
<p> </p>
</body>
</HTML>
