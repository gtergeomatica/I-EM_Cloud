from sqlalchemy.orm import Session

from .model import model, Base
from . import schema

class __Actions(object):
    
    def __init__(self, mymodel: Base, myschema: schema.BaseModel):
        self.model = mymodel
        self.schema = myschema

    def create(self, db: Session, parameters: dict):
        record = self.model(**parameters)
        db.add(record)
        db.commit()
        db.refresh(record)
        return record

    def fetch_one(self, db: Session, record_id: int):
        return db.query(self.model).filter(self.model.id==record_id).first()

    def delete_one(self, db: Session, record_id: int):
        record = self.fetch_one(db=db, record_id=record_id)
        if record is None:
            return
        else:
            db.delete(record)
            db.commit()
            return record

    def fetch(self, db: Session, offset: int=0, limit: int=100):
        return db.query(self.model).offset(offset).limit(limit).all()

# def fetch_one_evento(db: Session, evento_id: int):
#     return db.query(model.Evento).filter(model.Evento.id == evento_id).first()

# def fetch_evento(db: Session, offset: int = 0, limit: int = 100):
#     return db.query(model.Evento).offset(offset).limit(limit).all()

# def create_evento(db: Session, evento: schema.EventoCreate):
#     """ """
#     db_evento = model.Evento(**evento.model_dump())
#     db.add(db_evento)
#     db.commit()
#     db.refresh(db_evento)
#     return db_evento

# def delete_one_evento(db: Session, evento_id: int):
#     """ """
#     db_evento = fetch_one_evento(db=db, evento_id=evento_id)
#     if db_evento is None:
#         return
#     else:
#         db.delete(db_evento) #.where(model.Evento.id==evento_id)
#         db.commit()
#         return db_evento


Evento = __Actions(mymodel = model.Evento, myschema = schema.Evento)
Segnalazione = __Actions(mymodel = model.Segnalazione, myschema = schema.Segnalazione)
