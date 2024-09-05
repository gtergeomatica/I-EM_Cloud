from pydantic import BaseModel
from datetime import datetime

# EVENTO

class EventoBase(BaseModel):
    """ """
    title: str
    label: str
    description: str

    started_on: datetime
    ended_on: datetime
    suspended_until: datetime

    is_active: bool
    created_on: datetime
    updated_on: datetime
    created_by: str
    updated_by: str


class EventoCreate(EventoBase):
    """ """


class Evento(EventoBase):
    """ """
    id: int
    
    class Config:
        # UserWarning: Valid config keys have changed in V2:
        # * 'orm_mode' has been renamed to 'from_attributes'
        # orm_mode = True
        from_attributes = True


# SEGNALAZIONE

class SegnalazioneBase(BaseModel):
    """
    -- TODO
	-- reference: operatore che prende in carico
	-- reference: civico coinvolto
	-- reference: municipio di afferenza
 
	-- ??
	-- uo_ins
	-- numero verde
    """
    title: str
    label: str
    description: str
    
    started_on: datetime
    note: str
    evento_id: int

    is_active: bool
    created_on: datetime
    updated_on: datetime
    created_by: str
    updated_by: str


class SegnalazioneCreate(SegnalazioneBase):
    """ """


class Segnalazione(SegnalazioneBase):
    """ """
    id: int
    
    class Config:
        from_attributes = True