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
    <button class= "custBtn"> COMMERCE </button>
    <button class= "custBtn"> ARTS </button>
    <button class= "custBtn"> VOCATIONAL </button>
	
    </div>
</div>
	
  
	 <div class="flowchart-container">
        <button id="science-btn" class="hidden-btn" onclick="buildFlowchart()">Build Flowchart Live</button>
      
        <div class="flowchart" id="flowchart">
    <%
        int steps = 5;
        for(int i = 0; i < steps; i++) {
    %>
            <div class="step" data-step="<%=i%>"></div>
            <% if(i < steps-1) { %>
            <div class="arrow" data-arrow="<%=i%>"></div>
            <% } %>
    <%
        }
    %>
</div>
    </div>

    <script>
    
    	function showScienceFlow() {
    		var subjects = document.getElementById('science-btn');
            subjects.classList.remove('hidden-btn');
            subjects.classList.add('play-btn');
    	}
        
        
        function buildFlowchart() {
            var steps = document.querySelectorAll('.step');
            var arrows = document.querySelectorAll('.arrow');
            var stepTexts = ['Start', 'Process', 'Decision', 'Finish','add'];
            
            // Reset
            steps.forEach(function(s) { 
                s.classList.remove('visible', 'highlight');
                s.textContent = '';
            });
            arrows.forEach(function(a) { 
                a.classList.remove('visible', 'highlight');
            });
            
            var sequence = [
                // Build Step 1
                {type: 'step', index: 0, text: 'Start'},
                // Arrow 1
                {type: 'arrow', index: 0},
                // Build Step 2
                {type: 'step', index: 1, text: 'Process'},
                // Arrow 2
                {type: 'arrow', index: 1},
                // Build Step 3
                {type: 'step', index: 2, text: 'Decision'},
                // Arrow 3
                {type: 'arrow', index: 2},
                // Build Step 4
                {type: 'step', index: 3, text: 'Finish'},
                // Highlight sequence
                {type: 'arrow', index: 3},
                // Build Step 4
                {type: 'step', index: 4, text: 'add'},
                // Highlight sequence
        
                
                {type: 'highlight', index: 0},
                {type: 'highlight', index: 0},
                {type: 'highlight', index: 1},
                {type: 'highlight', index: 1},
                {type: 'highlight', index: 2},
                {type: 'highlight', index: 2},
                {type: 'highlight', index: 3},
                {type: 'highlight', index: 3},
                {type: 'highlight', index: 4}
            ];
            
            var i = 0;
            var timer = setInterval(function() {
                if (i < sequence.length) {
                    var action = sequence[i];
                    
                    if (action.type === 'step') {
                        steps[action.index].textContent = action.text;
                        steps[action.index].classList.add('visible');
                    } else if (action.type === 'arrow') {
                        arrows[action.index].classList.add('visible');
                    } else if (action.type === 'highlight') {
                        // Remove previous highlights
                        steps.forEach(function(s) { s.classList.remove('highlight'); });
                        arrows.forEach(function(a) { a.classList.remove('highlight'); });
                        // Add current highlight
                        if (action.index < steps.length) {
                            steps[action.index].classList.add('highlight');
                        } else {
                            arrows[action.index - steps.length].classList.add('highlight');
                        }
                    }
                    
                    i++;
                } else {
                    clearInterval(timer);
                }
            }, 600);
        }
    </script>
</body>
</html>
