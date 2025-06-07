from fastapi import FastAPI

from .database import engine, Base

Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Restaurant Ordering System API",
    description="API for menu display, order placement, and a Kitchen Order System (KOS)."
)

@app.get("/", tags=["Root"])
def read_root():
    return {"message": "Welcome to the Restaurant Ordering System API!"}
