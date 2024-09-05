from fastapi import FastAPI

# from .database.common import SessionLocal, engine, get_db
from . import settings
from .common import logger

app = FastAPI()

