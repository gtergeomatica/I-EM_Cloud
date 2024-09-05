from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine

Base = automap_base()

class ModelReader(object):

    def __init__(self, database_url):
        
        self.engine = create_engine(
            database_url,
            # connect_args={"check_same_thread": False}
        )
        self.session = sessionmaker(autocommit=False, autoflush=False, bind=self.engine)
        Base.prepare(autoload_with=self.engine)

        # ########## ########## ########## ########## ########## ########## ##########
        # Add elements here under directly defined from the reflected tables
        # ########## ########## ########## ########## ########## ########## ##########

        self.Evento = Base.classes.evento
        self.Segnalazione = Base.classes.segnalazione
    
    def get_db(self):
        db = self.session()
        try:
            yield db
        finally:
            db.close()
