FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/usr/local/bin:$PATH"

WORKDIR /app

# Install Python dependencies first for better layer caching
COPY requirements.txt ./
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cpu

# Copy application code
COPY . .

ENV PORT=8000
EXPOSE 8000

# Run migrations, collect static files, and start Gunicorn
CMD ["sh", "-c", "python manage.py migrate && python manage.py collectstatic --no-input && gunicorn youtube_to_text.wsgi:application --bind 0.0.0.0:8000 --timeout 300"]


