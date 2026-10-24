from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI(
    title="FastAPI CI/CD Pipeline",
    version="1.0.0",
    description="Minimal FastAPI application for CI/CD pipeline demonstration.",
)

Instrumentator().instrument(app).expose(app, endpoint="/metrics", include_in_schema=False)


@app.get("/")
async def read_root():
    return {"status": "ok", "service": "fastapi-cicd-pipeline"}


@app.get("/health")
async def healthcheck():
    return {"status": "healthy"}


if __name__ == "__main__":
    import uvicorn

    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=False)
