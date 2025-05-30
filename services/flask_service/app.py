from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({"message": "Welcome to Flask Service"})

@app.route('/health')
def health():
    return jsonify({"status": "healthy"})

@app.route('/info')
def info():
    return jsonify({
        "service": "Flask Microservice",
        "version": "1.0.0",
        "status": "running"
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000) 