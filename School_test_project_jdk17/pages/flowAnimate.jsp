<style>

.decision {
    clip-path: polygon(50% 0%, 100% 50%, 50% 100%, 0% 50%); /* Diamond */
    background: #ff9800;
}

.connector {
    border-radius: 50px; /* Curved line */
    height: 4px;
}

.branch-label {
    font-size: 12px;
    font-weight: bold;
}

.yes { color: green; }
.no { color: red; }

.io {
    transform: skew(20deg); /* Parallelogram */
}

.terminal {
    border-radius: 25px; /* Rounded ends */
    background: #4caf50;
}

</style>

<body>
<div class="flowchart">
    <!-- Terminal (Start) -->
    <div class="terminal" data-terminal="0">START</div>
    
    <!-- Arrow -->
    <div class="arrow" data-arrow="0"></div>
    
    <!-- Process -->
    <div class="process" data-process="0">Process Data</div>
    
    <!-- Arrow -->
    <div class="arrow" data-arrow="1"></div>
    
    <!-- Decision (Diamond) -->
    <div class="decision" data-decision="0">Valid?</div>
    
    <!-- Branch Labels -->
    <div class="branch-label yes" data-label="0">Yes</div>
    <div class="branch-label no" data-label="1">No</div>
    
    <!-- Connectors (Curved lines) -->
    <div class="connector" data-connector="0"></div>
    
    <!-- Input/Output -->
    <div class="io" data-io="0">Save File</div>
    
    <!-- Terminal (End) -->
    <div class="terminal" data-terminal="1">END</div>
</div>
</body>