import os

APP_NAME = os.environ['APP_NAME']
DBUSERNAME = os.environ['DBUSERNAME']
DBUSERPASSWORD = os.environ['DBUSERPASSWORD']
POSTGRES_PASSWORD = os.environ['POSTGRES_PASSWORD']
DBNAME = os.environ['DBNAME']

# logger settings
# LOGGERS = [
#     "warning:stdout"
# ]  # syntax "severity:filename" filename can be stderr or stdout

LOGGERS = os.environ.get('LOGGERS', "warning:stdout").split(';')
