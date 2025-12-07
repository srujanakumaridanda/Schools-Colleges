var course = null;
var customTexts = null;
var buildSubject = false;
var buildGroup = false;
var buildCareer = false;

function showScienceFlow() {
    var btn = document.getElementById('subject-btn');
    btn.classList.remove('hidden-btn');
    btn.classList.add('play-btn');
	
	var scienceGroupBtn = document.getElementById('group-btn');
	scienceGroupBtn.classList.remove('hidden-btn');
	scienceGroupBtn.classList.add('play-btn');
	
	var scienceCareerBtn = document.getElementById('career-btn');
	scienceCareerBtn.classList.remove('hidden-btn');
	scienceCareerBtn.classList.add('play-btn');
	
	course = "SCIENCE";
	
	if (buildSubject == true) {
		buildSubjectFlow();
	}
	
	if (buildGroup == true) {
			buildGroupFlow();
	}
	
	if (buildCareer == true) {
			buildCareerFlow();
	}
		
}


function showCommerceFlow() {
    var btn = document.getElementById('subject-btn');
    btn.classList.remove('hidden-btn');
    btn.classList.add('play-btn');
	
	var scienceGroupBtn = document.getElementById('group-btn');
	scienceGroupBtn.classList.remove('hidden-btn');
	scienceGroupBtn.classList.add('play-btn');
	
	var scienceCareerBtn = document.getElementById('career-btn');
	scienceCareerBtn.classList.remove('hidden-btn');
	scienceCareerBtn.classList.add('play-btn');
	
	course = "COMMERCE";
	
	if (buildSubject == true) {
			buildSubjectFlow();
	}
	
	if (buildGroup == true) {
			buildGroupFlow();
	}
	
	if (buildCareer == true) {
			buildCareerFlow();
	}
}


function showArtsFlow() {
    var btn = document.getElementById('subject-btn');
    btn.classList.remove('hidden-btn');
    btn.classList.add('play-btn');
	
	var scienceGroupBtn = document.getElementById('group-btn');
	scienceGroupBtn.classList.remove('hidden-btn');
	scienceGroupBtn.classList.add('play-btn');
	
	var scienceCareerBtn = document.getElementById('career-btn');
	scienceCareerBtn.classList.remove('hidden-btn');
	scienceCareerBtn.classList.add('play-btn');
	
	course = "ARTS";
	
	if (buildSubject == true) {
			buildSubjectFlow();
	}
	
	if (buildGroup == true) {
			buildGroupFlow();
	}
	
	if (buildCareer == true) {
			buildCareerFlow();
	}
}


function showVocationalFlow() {
	// remove elective-btn
	var electiveBtn = document.getElementById("elective-btn");
	if (electiveBtn != null ) {
		electiveBtn.classList.add('hidden-btn');
		electiveBtn.classList.remove('play-btn');
	}
	
    var btn = document.getElementById('subject-btn');
    btn.classList.remove('hidden-btn');
    btn.classList.add('play-btn');
	
	var scienceGroupBtn = document.getElementById('group-btn');
	scienceGroupBtn.classList.remove('hidden-btn');
	scienceGroupBtn.classList.add('play-btn');
	
	var scienceCareerBtn = document.getElementById('career-btn');
	scienceCareerBtn.classList.remove('hidden-btn');
	scienceCareerBtn.classList.add('play-btn');
	
	course = "VOCATIONAL";
	
	if (buildSubject == true) {
			buildSubjectFlow();
	}
	
	if (buildGroup == true) {
			buildGroupFlow();
	}
	
	if (buildCareer == true) {
			buildCareerFlow();
	}
} 

function buildSubjectFlow() {
	
	
	var electiveBtn = document.getElementById("elective-btn");
	
	if (electiveBtn != null ) {
		electiveBtn.classList.add('hidden-btn');
		electiveBtn.classList.remove('play-btn');
	}
	
	
	
	buildSubject = true;
	var container = "subject-flowchart";
	var stepLen = 4;
	
	clearContainer(container);
	
	
	if (course == "SCIENCE") 
		{
    		customTexts = ['Physics(P)', 'Chemistry(C)', 'Maths(M)', 'Biology(B)'];
			
		}
	if (course == "COMMERCE")
		{
			customTexts = ['Accountancy', 'Business Studies', 'Economics', 'Maths/Applied'];
			
		}
	if (course == "ARTS")
		{
			customTexts = ['History', 'Political Science', 'Geography', 'Economics', 'Sociology','Psychology'];
			stepLen = 6;
		}
		
	if (course == "VOCATIONAL")
		{
			customTexts = ['ITI', 'Polytechnic','NSQF','PMKVY etc','NAPS','Paramedical Diploma', 'Media ','Tourism & Hospitality'];
			stepLen = 8;
		}
    var sequence = generateSequence(stepLen, customTexts);
    playAnimation(sequence,container);
	
}

function buildGroupFlow() {
	
	buildGroup = true;
	var container = "group-flowchart";
	clearContainer(container);
	
    var stepLen = 4;
	
	if (course == "SCIENCE") 
		{
    		customTexts = ['PCM', 'PCB', 'PCMB', 'PCM/PCB+Elective'];
		}
	if (course == "COMMERCE")
		{
			customTexts = ['Comm + Math', 'Comm W/o Math', 'Comm +IT', 'Comm + Elective'];
		}
	if (course == "ARTS")
		{
			customTexts = ['HEPS', 'HEPP', 'CEPS', 'HPP', 'HEG','Language Grp','FineArts Grp'];
			stepLen = 7;
		}
		
	if (course == "VOCATIONAL")
		{
			stepLen = 8;
			customTexts = ['ITI', 'Polytechnic','NSQF','PMKVY etc','NAPS','Paramedical Diploma', 'Media ','Tourism & Hospitality'];
		}
   
	var sequence = generateSequence(stepLen, customTexts);
	playAnimation(sequence,container);
}

function buildCareerFlow() {
	
	buildCareer = true;
	var container = "career-flowchart";
	clearContainer(container);
	
	var stepLen = 4;
    
	if (course == "SCIENCE") 
		{
    		customTexts = ['Engineer', 'Doctor', 'Scientist', 'Professor', 'Defence','Architect','Analyst','Govt jobs'];
			stepLen = 8;
		}
	if (course == "COMMERCE")
		{
			customTexts = ['CA/CS/CFA/CMA', 'Finance', 'Tax/Accounting', 'Management', 'Marketing','Professor','Govt Jobs'];
			stepLen = 7;
		}
	if (course == "ARTS")
		{
			customTexts = ['Govt Jobs', 'Law & Legal', 'Journalism', 'Design/FineArts', 'Teaching','Hospitality','International Relations','Archeaology','Film & Media'];
			stepLen = 9;
		}
		
	if (course == "VOCATIONAL")
		{
			customTexts = ['Direct Job / Higher Studies', 'Healthcare Jobs', 'Business/ Office jobs', 'Media', 'Rural & Agricultural','Hospitality & Tourism','IT & Computer'];
			stepLen = 7;
		}
    var sequence = generateSequence(stepLen, customTexts);
	
	playAnimation(sequence,container);
}

function clearContainer(containerTxt) {
    var container = document.getElementById(containerTxt);
    while (container.firstChild) {
        container.removeChild(container.firstChild);
    }
}

function generateSequence(stepsCount, customTexts) {
    var sequence = [];
    var texts = customTexts || [];
    for(var i = 0; i < stepsCount; i++) {
        texts[i] = texts[i] || 'Step ' + (i+1);
    }
    
    for(var i = 0; i < stepsCount; i++) {
        sequence.push({type: 'step', index: i, text: texts[i]});
        if(i < stepsCount - 1) {
            sequence.push({type: 'arrow', index: i});
        }
    }
    
    for(var i = 0; i < stepsCount; i++) {
        sequence.push({type: 'highlight-step', index: i});
        sequence.push({type: 'highlight-step', index: i});
    }
    
    sequence.push({type: 'clear-highlights'});
    return sequence;
}

function playAnimation(sequence,containerTxt) {
	var container = document.getElementById(containerTxt);
    //var steps = container.querySelectorAll('.step');
    //var arrows = container.querySelectorAll('.arrow');
	
	// Dynamically create steps and arrows
	 var stepCount = 0;
	 sequence.forEach(function(action) {
	     if (action.type === 'step') stepCount = Math.max(stepCount, action.index + 1);
	 });
	 
	 var steps = [];
	 var arrows = [];
	 for (var i = 0; i < stepCount; i++) {
	     var step = document.createElement('div');
	     step.className = 'step';
	     container.appendChild(step);
	     steps.push(step);
	     
	     if (i < stepCount - 1) {
	         var arrow = document.createElement('div');
	         arrow.className = 'arrow';
	         container.appendChild(arrow);
	         arrows.push(arrow);
	     }
	 }
    
    var i = 0;
    var timer = setInterval(function() {
        if(i >= sequence.length) {
            clearInterval(timer);
			
			var electiveBtn = document.getElementById("elective-btn");
				electiveBtn.classList.remove('hidden-btn');
				electiveBtn.classList.add('play-btn');
				
			if (course == "VOCATIONAL") {
					electiveBtn.classList.add('hidden-btn');
					electiveBtn.classList.remove('play-btn');
				}
				
            return;
        }
		
        
        var action = sequence[i];
        
        if(action.type === 'step') {
            steps[action.index].textContent = action.text;
            steps[action.index].classList.add('visible');
        } else if(action.type === 'arrow') {
            arrows[action.index].classList.add('visible');
        } else if(action.type === 'highlight-step') {
            steps.forEach(function(s) { s.classList.remove('highlight'); });
            arrows.forEach(function(a) { a.classList.remove('highlight'); });
            steps[action.index].classList.add('highlight');
        } else if(action.type === 'clear-highlights') {
            steps.forEach(function(s) { s.classList.remove('highlight'); });
            arrows.forEach(function(a) { a.classList.remove('highlight'); });
        }
        
        i++;
    }, 500);
}


document.getElementById('elective-btn').addEventListener('click', function(e) {
	
    var infoWindow = document.getElementById('customInfoWindow');
    var infoBody = document.getElementById('info-body');
	
	if (course == "SCIENCE")
    	infoBody.innerHTML = 'Computer Science <br> Informatics <br> Electronics <br> Biotechnology<br> Psychology'+
								'<br> Statistics <br> Geology <br> Engg Graphics <br> Home Science <br> Phsical Education <br> Astronomy '+
								'<br> Microbiology <br> Biochemistry <br> Environmental Science'; 

	if (course == "COMMERCE")
		infoBody.innerHTML = 'Computer Science <br> Enterpreneurship <br> Psychology <br> Sociology <br> Political Science ' +
								'<br> Geography <br> Physical Education <br> Home Science <br> Languages <br> Fine Arts'+
								'<br> Financial Market Managment <br> Business Maths '; 
							
	if (course == "ARTS")
			infoBody.innerHTML = 'Philosophy <br> Anthropology <br>  Languages <br> Fine Arts <br> Music <br> Dance <br> Theatre/Drama' +
									'<br> Home Science <br> Physical Education <br> Fashion Studies <br> Media <br> Legal Studies  ' +
									'<br> Entrepreneurship <br> Computer Science ';
									
		
    infoWindow.style.display = 'block';
    
	infoWindow.onclick = function() { this.style.display = 'none'; };
    // Position near button (optional Maps-like)
    var rect = e.target.getBoundingClientRect();
    infoWindow.style.top = (rect.bottom -100) + 'px';
    infoWindow.style.left = (rect.left +160) + 'px';
    infoWindow.style.transform = 'none';
});

// Close handler
document.getElementById('info-close').addEventListener('click', function() {
    document.getElementById('customInfoWindow').style.display = 'none';
});

