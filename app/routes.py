from flask import render_template, jsonify
from app import app

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/status')
def status():
    return jsonify({
        "service": "Orbisect Satellite Security",
        "status": "active"
    })

@app.route('/api/telemetry')
def telemetry():
    from datetime import datetime
    import random
    return jsonify({
        "satellites": [
            {"id": "SAT-76B", "status": "secure", "signal": random.randint(85, 100)},
            {"id": "SAT-42C", "status": "warning", "signal": random.randint(60, 75)},
            {"id": "SAT-89D", "status": "critical", "signal": random.randint(30, 45)}
        ],
        "threats": [
            {"time": datetime.utcnow().strftime("%Y-%m-%d %H:%M:%SZ"),
             "satellite": "SAT-89D", 
             "type": "Signal Jamming", 
             "severity": "high"}
        ]
    })
