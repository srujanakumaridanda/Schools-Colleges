<!DOCTYPE html>
<html>
<head>
    <style>
        .flowchart-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 50px;
            background: #f8f9fa;
            min-height: 400px;
        }
        
        .play-btn {
            background: linear-gradient(45deg, #007bff, #0056b3);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 50px;
            font-size: 18px;
            cursor: pointer;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0,123,255,0.3);
        }
        
        .play-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,123,255,0.4);
        }
        
        .flowchart {
            display: flex;
            gap: 0;
            align-items: center;
            position: relative;
            height: 100px;
        }
        
        .step {
            width: 0;
            height: 0;
            background: transparent;
            border: 3px solid transparent;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            position: relative;
            opacity: 0;
            transform: scale(0);
            transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        }
        
        .step.visible {
            width: 120px;
            height: 60px;
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            border-color: #2196f3;
            opacity: 1;
            transform: scale(1);
        }
        
        .step.highlight {
            background: linear-gradient(135deg, #fff176, #ffeb3b) !important;
            box-shadow: 0 0 25px #ffc107;
            transform: scale(1.1);
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
            width: 50px;
            background: linear-gradient(90deg, #666, #999);
            opacity: 1;
        }
        
        .arrow.highlight {
            background: linear-gradient(90deg, #ff5722, #ff8a50) !important;
            box-shadow: 0 0 15px #ff5722;
        }
        
        .arrow:after {
            content: '>';
            position: absolute;
            right: -12px;
            top: -6px;
            font-size: 18px;
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
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.3); }
        }
    </style>
</head>
<body>
    <div class="flowchart-container">
        <button class="play-btn" onclick="buildFlowchart()">Build Flowchart Live</button>
        
        <div class="flowchart" id="flowchart">
            <div class="step" data-step="0"></div>
            <div class="arrow" data-arrow="0"></div>
            <div class="step" data-step="1"></div>
            <div class="arrow" data-arrow="1"></div>
            <div class="step" data-step="2"></div>
            <div class="arrow" data-arrow="2"></div>
            <div class="step" data-step="3"></div>
            <div class="arrow" data-arrow="3"></div>
            <div class="step" data-step="4"></div>
        </div>
    </div>

    <script>
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
