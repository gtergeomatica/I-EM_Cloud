FROM tiangolo/uvicorn-gunicorn:python3.10 as common

RUN python3 -m pip install --upgrade pip

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

FROM common as deploy
COPY ./app /app

FROM common as dev
COPY ./iemlib /iemlib
RUN python3 -m pip install -e /iemlib
COPY ./start.sh /start.sh

FROM common as scheduler-dev
COPY ./iemlib /iemlib
RUN python3 -m pip install -e /iemlib