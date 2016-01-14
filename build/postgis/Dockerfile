# postgis 2.1 / posgresql PGVER / ubuntu trusty

FROM ubuntu:trusty
ARG PGVER

RUN test -n "${PGVER}" || ( \
  echo 'PGVER build arg is mandatory,' \
       'try --build-arg PGVER=9.3'; \
  exit 1; \
) >&2

# TODO: find a way to report version at build time
#RUN echo PGVER is ${PGVER}

MAINTAINER Sandro Santilli <strk@keybit.net>

RUN apt-get update && apt-get -y install wget
RUN wget --quiet --no-check-certificate -O - \
    https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list
RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
RUN apt-get -y update && apt-get install -y \
  postgresql-contrib-${PGVER} \
  postgresql-${PGVER} \
  postgresql-${PGVER}-postgis-2.1
# We do not install recommends because they could bring in
# non-wanted PostgreSQL versions.
# See https://github.com/systemapic/docker-systemapic/issues/13
RUN apt-get -y update && apt-get -y install --no-install-recommends postgis

# access configuration
RUN echo "host    all             all             0.0.0.0/0 md5" >> /etc/postgresql/${PGVER}/main/pg_hba.conf

# common config
RUN ( \
  echo "listen_addresses = '*'"; \
  echo "port = 5432"; \
  : echo "log_statement = ddl"; \
  echo "log_statement = none"; \ 
  : echo "log_statement = all"; \
  echo "log_min_error_statement = ERROR"; \
) >> /etc/postgresql/${PGVER}/main/postgresql.conf

# docker user creation
# TODO: use createuser shell command ?
RUN service postgresql start && \
    /bin/su postgres -c "createuser -d -s -r -l docker" && \
    /bin/su postgres -c "psql postgres -c \"ALTER USER docker WITH ENCRYPTED PASSWORD 'docker'\"" && \
    service postgresql stop

# pgtune
RUN ( \
  echo "max_connections = 100"; \
  echo "shared_buffers = 4GB"; \
  echo "effective_cache_size = 12GB"; \
  echo "work_mem = 20971kB"; \
  echo "maintenance_work_mem = 2GB"; \
  echo "checkpoint_segments = 128"; \
  echo "checkpoint_completion_target = 0.9"; \
  echo "wal_buffers = 16MB"; \
  echo "default_statistics_target = 500"; \
) >> /etc/postgresql/${PGVER}/main/postgresql.conf


EXPOSE 5432

ENV TERM xterm
RUN apt-get install -y fish htop

ADD start.sh /start.sh
RUN chmod 0755 /start.sh

ENV PGVER ${PGVER}
CMD /start.sh ${PGVER}
