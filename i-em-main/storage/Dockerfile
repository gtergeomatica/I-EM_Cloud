FROM postgis/postgis:16-master
ARG DEBIAN_FRONTEND=noninteractive

COPY ./scripts/entrypoint.sh /docker-entrypoint-initdb.d/entrypoint.sh
RUN echo /docker-entrypoint-initdb.d/entrypoint.sh >> /usr/local/bin/docker-entrypoint.sh
# ENTRYPOINT ["/docker-entrypoint-initdb.d/entrypoint.sh"]

# COPY ./entrypoint.sh /docker-entrypoint-initdb.d/initdb.sh
# RUN chmod +x /docker-entrypoint-initdb.d/initdb.sh
