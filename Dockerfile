# ============================
# 1️⃣ Build Stage
# ============================
FROM python:3.11-slim AS builder

WORKDIR /app

# Install build dependencies

RUN apt-get update && apt-get install -y build-essential

# Copy dependency file
COPY requirements.txt .

# Install Python dependencies into a temporary folder
RUN pip install --no-cache-dir --upgrade pip && \ 
    pip install --prefix=/install -r requirements.txt
    
# ============================
# 2️⃣ Runtime Stage
# ============================
FROM python:3.11-slim

WORKDIR /app

# Copy installed packages from builder stage
COPY --from=builder /install /usr/local

# Copy only necessary files
COPY . .

# Set environment variables
ENV FLASK_APP=run.py
ENV FLASK_ENV=production
ENV PYTHONUNBUFFERED=1

# Expose Flask default port
EXPOSE 5000

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
# Health check (optional but recommended)
HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
  CMD curl --fail http://localhost:5000/api/v1/healthcheck || exit 1


# Run the Flask app
CMD ["python", "run.py"]