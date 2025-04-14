# Use an official Python base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy the app code
COPY app/ ./app/
COPY app/requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 80
EXPOSE 80

# Run with Gunicorn
CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:80", "app.app:app"]
