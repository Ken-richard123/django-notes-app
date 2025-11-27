FROM python:3.9

# Set working directory
WORKDIR /app/backend

# Copy requirements
COPY requirements.txt .

# Install system dependencies
RUN apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Make all files writable (fix CrashLoopBackOff for SQLite)
RUN chmod -R 777 /app/backend

# Expose port
EXPOSE 8000

# Default command to run Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

