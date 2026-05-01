from flask import jsonify, render_template
from app import app
from app.metrics import get_metrics

@app.route('/')
def dashboard():
    metrics = get_metrics()
    return render_template('dashboard.html', metrics=metrics)

@app.route('/health')
def health():
    return jsonify({"status": "healthy"}), 200

@app.route('/metrics')
def metrics():
    return jsonify(get_metrics()), 200