<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.school.pillar.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Schools and Colleges</title>
  
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mainPageUI.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/imagesUI.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/flowAnimate.css">
    <style>
    .container {
        display: flex;
        gap: 20px;
    }
    
   .custBtn {
  width: 225px;          
  height: 38px;         
}
   
    
  
    </style>
 </head>
 
<body>

<div class="container">
   	<div class="cs-div-left-up"></div>
   	
	<div class = "cs-div-right">
      	  	<p class = "phead">Course Streams</p> 
	    <button class= "custBtn" onclick ="showScienceFlow()"> SCIENCE </button>
	    <button class= "custBtn" onclick ="showCommerceFlow()"> COMMERCE </button>
	    <button class= "custBtn" onclick ="showArtsFlow()"> ARTS </button>
	    <button class= "custBtn" onclick ="showVocationalFlow()"> VOCATIONAL </button>
	</div>
</div>
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    	<button class= "home" onclick="window.location.href='displayMainPage.jsp'"> Home </button>
    	
	  <div class = "flowchart-container">
	  	 <button id="subject-btn" class="hidden-btn" onclick="buildSubjectFlow()">SUBJECTS</button> <br>
		 <div class="flowchart" id="subject-flowchart" >
	       
		    <%
		        int stepsCount = 5;
		        for(int i = 0; i < stepsCount; i++) {
		    %>
		            <div class="step" data-step="<%=i%>"></div>
		            <% if(i < stepsCount-1) { %>
		            <div class="arrow" data-arrow="<%=i%>"></div>
		            <% } %>
		    <%
		        }
		    %>
	    </div> <!-- subject flowchart -->
	    <button id="elective-btn" class="hidden-btn" onclick="showElectives()">ELECTIVES</button> <br>
    </div>
    
    <div class = "flowchart-container">
	    <button id="group-btn" class="hidden-btn" onclick="buildGroupFlow()">GROUPS</button> <br>
	    <div class="flowchart" id="group-flowchart">
	        
		    <%
		        stepsCount = 5;
		        for(int i = 0; i < stepsCount; i++) {
		    %>
		            <div class="step" data-step="<%=i%>"></div>
		            <% if(i < stepsCount-1) { %>
		            <div class="arrow" data-arrow="<%=i%>"></div>
		            <% } %>
		    <%
		        }
		    %>
	    </div> <!-- group flowchart -->
    </div>
    
    
    <div class = "flowchart-container">
	    <button id="career-btn" class="hidden-btn" onclick="buildCareerFlow()">CAREERS</button> <br>
	    <div class="flowchart" id="career-flowchart">
	        
		    <%
		        stepsCount = 5;
		        for(int i = 0; i < stepsCount; i++) {
		    %>
		            <div class="step" data-step="<%=i%>"></div>
		            <% if(i < stepsCount-1) { %>
		            <div class="arrow" data-arrow="<%=i%>"></div>
		            <% } %>
		    <%
		        }
		    %>
	    </div> <!-- career flowchart -->
	    
	</div> 
    
    <div id="customInfoWindow" class="info-window" style="display: none;">
	    <div class="info-content">
	        <span id="info-close">&times;</span>
	        <div id="info-body">Click a flowchart step for details!</div>
	    </div>
	</div>
    
    <script src="${pageContext.request.contextPath}/pages/stream.js"></script> 
    
    
  </body>
</html>
