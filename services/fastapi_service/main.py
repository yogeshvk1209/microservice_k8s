from fastapi import FastAPI
from typing import Dict

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Welcome to FastAPI Service"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}

@app.get("/info")
def get_info():
    return {
        "service": "FastAPI Microservice",
        "version": "1.0.0",
        "status": "running"
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000) 