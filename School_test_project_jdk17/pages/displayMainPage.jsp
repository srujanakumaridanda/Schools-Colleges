<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.school.pillar.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Schools and Colleges</title>
  
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mainPageUI.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/imagesUI.css">
 
    <style>
    .container {
        display: flex;
        gap: 20px;
    }
    
   
    
  
    </style>
 </head>
<body>

<div class="container">
    <div class="cs-div-left">
    	<div class="cs-div-left-up"></div>
	</div>
	
	<div class = "cs-div-right">
    	<div class="cs-div-right-up">
    	  	<p class = "phead">Welcome to       SCHOOLS & COLLEGES of</p> 
    	  	<span class="phead_img"></span>
        </div>
	    <div class="cs-div-right-down" >
		    	<button class = searchBtn onclick="window.location.href='displaySchools.jsp'">Search SCHOOLS</button>
		    	<button class = searchBtn onclick="window.location.href='displayColleges.jsp'">Search COLLLEGES</button>
	    </div>
	    
    </div>
    <div class=cs-div-info> 
    <button class= "infoBtn" onclick="window.location.href='../DigitalBooks.html'"> Digital School Books</button><br><br>
    <button class= "infoBtn" onclick="window.location.href='../PreviousPapers.html'"> Previous Question Papers</button><br><br>
    <button class= "infoBtn" onclick="window.location.href='courseStreams.jsp'"> Guide on Course Streams</button><br><br>
    <button class= "infoBtn" onclick="window.open('https://www.nirfindia.org/','_blank')"> NRIF (Rankings)   </button><br><br>
    <button class= "infoBtn"  onclick="window.location.href='../Scholarships.html'"> Scholarships  </button>  
    </div>
    
    
</div>

	<button class= "custBtn"> Running Admissions </button>
    <button class= "custBtn"> Opportunities </button>
    <button class= "custBtn"> Colleges & Campus Interviews </button>
    <button class= "custBtn"> Competitive Exams </button>

	<div class="bg-image">
    </div>
	
  
	<script>
        function openLink() {
            const select = document.getElementById('stateSelect');
            const url = select.value;
            if (url) window.open(url, '_blank');
        }
    </script>
</body>
</html>
