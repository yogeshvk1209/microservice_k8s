FROM python:3.9-slim

WORKDIR /app
COPY server.py .
COPY static/ static/

EXPOSE 3000
CMD ["python3", "server.py"] 
