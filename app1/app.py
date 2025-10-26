from flask import Flask, render_template
import socket
import os
from datetime import datetime

# Create a Flask application
app = Flask(__name__)

# Define a route for the root URL
@app.route('/')
def index():
    """Main page with deployment information"""
    
    # Get deployment information
    deployment_info = {
        'app_name': 'App1 - Flask Demo',
        'version': 'v1.0.0',
        'cluster_name': os.getenv('CLUSTER_NAME', 'GKE Cluster'),
        'environment': os.getenv('ENVIRONMENT', 'Development'),
        'hostname': socket.gethostname(),
        'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC')
    }
    
    return render_template('index.html', **deployment_info)

@app.route('/health')
def health():
    """Health check endpoint for Kubernetes"""
    return {'status': 'healthy', 'app': 'app1'}, 200

@app.route('/api/info')
def info():
    """API endpoint with deployment info"""
    return {
        'app': 'app1',
        'version': 'v1.0.0',
        'hostname': socket.gethostname(),
        'cluster': os.getenv('CLUSTER_NAME', 'unknown'),
        'environment': os.getenv('ENVIRONMENT', 'development')
    }

# Run the Flask application if this file is executed directly
if __name__ == '__main__':
    app.run(debug=True, port=8080, host='0.0.0.0')
