
from sqlalchemy.orm import Session
from fastapi import Depends, HTTPException

from .main import app
from . import settings
from .common import logger
from .database import crud, schema

# from .database.model import model, get_db

from .database.model import model
get_db = model.get_db


@app.get("/")
async def root():
    return {"message": "Hello World"}

# CREATE

@app.post("/evento/", response_model=schema.Evento)
def create_evento(evento: schema.EventoCreate, db: Session = Depends(get_db)):
    """ """
    return crud.Evento.create(db=db, parameters=evento.model_dump())

@app.post("/segnalazione/", response_model=schema.Segnalazione)
def create_segnalazione(segnalazione: schema.SegnalazioneCreate, db: Session = Depends(get_db)):
    """ """
    return crud.Segnalazione.create(db=db, parameters=segnalazione.model_dump())

# READ

@app.get("/evento/{evento_id}", response_model=schema.Evento)
def fetch_one_evento(evento_id: int, db: Session = Depends(get_db)):
    """ """
    db_evento = crud.Evento.fetch_one(db=db, record_id=evento_id)
    try:
        assert not db_evento is None
    except AssertionError:
        raise HTTPException(status_code=404, detail="File not found")
    else:
        return db_evento

@app.get("/segnalazione/{segnalazione_id}", response_model=schema.Segnalazione)
def fetch_one_segnalazione(segnalazione_id: int, db: Session = Depends(get_db)):
    db_segnalazione = crud.Segnalazione.fetch_one(db=db, record_id=segnalazione_id)
    try:
        assert not db_segnalazione is None
    except AssertionError:
        raise HTTPException(status_code=404, detail="File not found")
    else:
        return db_segnalazione


@app.get("/evento/", response_model=list[schema.Evento])
def fetch_evento(offset: int = 0, limit: int = 20, db: Session = Depends(get_db)):
    """ """
    logger.warning("Controller evento (fetch all) called")
    result = crud.Evento.fetch(offset=offset, limit=limit, db=db)
    return result

@app.get("/segnalazione/", response_model=list[schema.Segnalazione])
def fetch_segnalazione(offset: int = 0, limit: int = 20, db: Session = Depends(get_db)):
    result = crud.Segnalazione.fetch(offset=offset, limit=limit, db=db)
    return result

# UPDATE (TODO)

# DELETE

@app.delete("/evento/{evento_id}", response_model=schema.Evento)
def delete_one_evento(evento_id: int, db: Session = Depends(get_db)):
    """ """
    result = crud.Evento.delete_one(db=db, record_id=evento_id)
    try:
        assert not result is None
    except AssertionError:
        raise HTTPException(status_code=404, detail="File not found")
    else:
        return result

@app.delete("/segnalazione/{segnalazione_id}", response_model=schema.Segnalazione)
def delete_one_segnalazione(segnalazione_id: int, db: Session = Depends(get_db)):
    """ """
    result = crud.Segnalazione.delete_one(db=db, record_id=segnalazione_id)
    try:
        assert not result is None
    except AssertionError:
        raise HTTPException(status_code=404, detail="File not found")
    else:
        return result
