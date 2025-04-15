from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "🚀 @Brandevops on YouTube ! Go Subscribe to my channel"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
