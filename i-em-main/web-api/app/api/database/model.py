from .. import settings

from iemlib.database.model import ModelReader, Base

# SQLALCHEMY_DATABASE_URL = "sqlite:///./sql_app.db"
SQLALCHEMY_DATABASE_URL = f"postgresql://postgres:{settings.POSTGRES_PASSWORD}@dbms.{settings.APP_NAME}/{settings.DBNAME}"

model = ModelReader(SQLALCHEMY_DATABASE_URL)
