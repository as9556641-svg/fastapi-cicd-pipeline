FROM python:3.11-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt ./
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --prefix=/install -r requirements.txt

FROM python:3.11-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY --from=builder /install /usr/local
COPY main.py ./

RUN addgroup --system app && adduser --system --group app && chown -R app:app /app

USER app

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
