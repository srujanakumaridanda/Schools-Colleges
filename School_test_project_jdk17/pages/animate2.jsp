<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            margin: 0;
            padding: 20px;
            background: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        
        .flowchart-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 50px;
            max-width: 1000px;
            margin: 0 auto;
        }
        
        .play-btn {
            background: linear-gradient(45deg, #007bff, #0056b3);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 50px;
            font-size: 18px;
            cursor: pointer;
            margin-bottom: 40px;
            box-shadow: 0 4px 15px rgba(0,123,255,0.3);
        }
        
        .play-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,123,255,0.4);
        }
        
        .main-flow {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 30px;
        }
        
        .branch-container {
            display: flex;
            align-items: center;
            gap: 20px;
            position: relative;
        }
        
        .branch {
            display: flex;
            align-items: center;
            gap: 15px;
            min-width: 200px;
        }
        
        .step {
            width: 0;
            height: 0;
            background: transparent;
            border: 3px solid transparent;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 12px;
            opacity: 0;
            transform: scale(0);
            transition: all 0.6s ease;
            min-width: 80px;
            padding: 5px;
        }
        
        .step.visible {
            width: 100px;
            height: 40px;
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            border-color: #2196f3;
            opacity: 1;
            transform: scale(1);
        }
        
        .step.highlight {
            background: linear-gradient(135deg, #fff176, #ffeb3b) !important;
            box-shadow: 0 0 20px #ffc107 !important;
            transform: scale(1.2) !important;
        }
        
        .arrow {
            width: 0;
            height: 3px;
            background: transparent;
            position: relative;
            opacity: 0;
            transition: all 0.5s ease;
        }
        
        .arrow.visible {
            width: 40px;
            background: linear-gradient(90deg, #666, #999);
            opacity: 1;
        }
        
        .arrow.highlight {
            background: linear-gradient(90deg, #ff5722, #ff8a50) !important;
            box-shadow: 0 0 15px #ff5722 !important;
        }
        
        .arrow:after {
            content: '>';
            position: absolute;
            right: -8px;
            top: -5px;
            font-size: 14px;
            color: transparent;
            transition: all 0.5s ease;
        }
        
        .arrow.visible:after {
            color: #666;
        }
        
        .arrow.highlight:after {
            color: #ff5722;
            animation: pulse 1s infinite;
        }
        
        .branch-arrow-down {
            width: 2px;
            height: 0;
            background: #666;
            opacity: 0;
            transition: all 0.5s ease;
        }
        
        .branch-arrow-down.visible {
            height: 25px;
            opacity: 1;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(2); }
        }
    </style>
</head>
<body>
    <div class="flowchart-container">
        <button class="play-btn" onclick="buildFlowchart()">Play Vertical Flowchart</button>
        
        <div class="main-flow" id="flowchart">
            <!-- Main Vertical Path -->
            <div class="step" data-step="0"></div>
            <div class="arrow" data-arrow="0"></div>
            <div class="step" data-step="1"></div>
            
            <!-- Branch 1 -->
            <div class="branch-container">
                <div class="branch-arrow-down" data-branch-arrow="0"></div>
                <div class="branch">
                    <div class="step" data-step="2"></div>
                    <div class="arrow" data-arrow="1"></div>
                    <div class="step" data-step="3"></div>
                </div>
            </div>
            
            <!-- Branch 2 -->
            <div class="branch-container">
                <div class="branch-arrow-down" data-branch-arrow="1"></div>
                <div class="branch">
                    <div class="step" data-step="4"></div>
                    <div class="arrow" data-arrow="2"></div>
                    <div class="step" data-step="5"></div>
                </div>
            </div>
            
            <!-- Branch 3 -->
            <div class="branch-container">
                <div class="branch-arrow-down" data-branch-arrow="2"></div>
                <div class="branch">
                    <div class="step" data-step="6"></div>
                    <div class="arrow" data-arrow="3"></div>
                    <div class="step" data-step="7"></div>
                </div>
            </div>
            
            <!-- Branch 4 -->
            <div class="branch-container">
                <div class="branch-arrow-down" data-branch-arrow="3"></div>
                <div class="branch">
                    <div class="step" data-step="8"></div>
                    <div class="arrow" data-arrow="4"></div>
                    <div class="step" data-step="9"></div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function buildFlowchart() {
            var steps = document.querySelectorAll('.step');
            var arrows = document.querySelectorAll('.arrow');
            var branchArrows = document.querySelectorAll('.branch-arrow-down');
            
            var stepTexts = [
                'Start', 'Split', 
                'Branch 1', 'End1',
                'Branch 2', 'End2',
                'Branch 3', 'End3',
                'Branch 4', 'End4'
            ];
            
            // Reset
            steps.forEach(function(s) { 
                s.classList.remove('visible', 'highlight');
                s.textContent = '';
            });
            arrows.forEach(function(a) { 
                a.classList.remove('visible', 'highlight');
            });
            branchArrows.forEach(function(a) { 
                a.classList.remove('visible');
            });
            
            var sequence = [
                // Main path
                {type: 'step', index: 0, text: 'Start'},
                {type: 'arrow', index: 0},
                {type: 'step', index: 1, text: 'Split'},
                
                // Branch 1
                {type: 'branch-arrow', index: 0},
                {type: 'step', index: 2, text: 'Branch 1'},
                {type: 'arrow', index: 1},
                {type: 'step', index: 3, text: 'End1'},
                
                // Branch 2
                {type: 'branch-arrow', index: 1},
                {type: 'step', index: 4, text: 'Branch 2'},
                {type: 'arrow', index: 2},
                {type: 'step', index: 5, text: 'End2'},
                
                // Branch 3
                {type: 'branch-arrow', index: 2},
                {type: 'step', index: 6, text: 'Branch 3'},
                {type: 'arrow', index: 3},
                {type: 'step', index: 7, text: 'End3'},
                
                // Branch 4
                {type: 'branch-arrow', index: 3},
                {type: 'step', index: 8, text: 'Branch 4'},
                {type: 'arrow', index: 4},
                {type: 'step', index: 9, text: 'End4'},
                
                // Highlight cycle
                {type: 'highlight-step', index: 0},
                {type: 'highlight-step', index: 1},
                {type: 'highlight-step', index: 2},
                {type: 'highlight-step', index: 4},
                {type: 'highlight-step', index: 6},
                {type: 'highlight-step', index: 8},
                
                {type: 'restart'}
            ];
            
            var i = 0;
            var timer = setInterval(function() {
                if (i >= sequence.length) {
                    clearInterval(timer);
                    return;
                }
                
                var action = sequence[i];
                
                if (action.type === 'step') {
                    steps[action.index].textContent = action.text;
                    steps[action.index].classList.add('visible');
                } 
                else if (action.type === 'arrow') {
                    arrows[action.index].classList.add('visible');
                }
                else if (action.type === 'branch-arrow') {
                    branchArrows[action.index].classList.add('visible');
                }
                else if (action.type === 'highlight-step') {
                    steps.forEach(function(s) { s.classList.remove('highlight'); });
                    arrows.forEach(function(a) { a.classList.remove('highlight'); });
                    steps[action.index].classList.add('highlight');
                }
                else if (action.type === 'restart') {
                    clearInterval(timer);
                    setTimeout(buildFlowchart, 2000);
                }
                
                i++;
            }, 600);
        }
    </script>
</body>
</html>
