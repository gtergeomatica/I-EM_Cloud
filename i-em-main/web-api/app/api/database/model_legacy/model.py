from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine

from ... import settings

# SQLALCHEMY_DATABASE_URL = "sqlite:///./sql_app.db"
SQLALCHEMY_DATABASE_URL = f"postgresql://postgres:{settings.POSTGRES_PASSWORD}@dbms.{settings.APP_NAME}/{settings.DBNAME}"

Base = automap_base()

engine = create_engine(
    SQLALCHEMY_DATABASE_URL,
    # connect_args={"check_same_thread": False}
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# reflect the tables
Base.prepare(autoload_with=engine)

# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# ########## ########## ########## ########## ########## ########## ##########
# Add elements here under directly defined from the reflected tables
# ########## ########## ########## ########## ########## ########## ##########

Evento = Base.classes.evento
Segnalazione = Base.classes.segnalazione
