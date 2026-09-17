# ============================================================
# STAGE 1: BUILD
# ============================================================

FROM python:3.8-slim AS builder

WORKDIR /build

# Copy requirements
COPY requirement.txt .

# Install dependencies into /install
RUN pip install --no-cache-dir --prefix=/install -r requirement.txt


# ============================================================
# STAGE 2: RUNTIME
# ============================================================

FROM python:3.8-slim

WORKDIR /app

# Copy installed dependencies
COPY --from=builder /install /usr/local

# Copy application
COPY app.py .
COPY model.pkl .
COPY house.py .
COPY house_data.csv .
COPY templates ./templates
COPY static ./static

# Flask port
EXPOSE 5000

# Start application
CMD ["python", "app.py"]
