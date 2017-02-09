##
# PostgreSQL 9.3
# PostGIS 2.1
##

# base image
FROM ubuntu:trusty

# maintainer
MAINTAINER Sandro Santilli <strk@keybit.net>

# set pg version
ENV PGVER=9.3
ENV PGVER_SHORT=93

# TODO: find a way to report version at build time
RUN echo PGVER is ${PGVER}

# install tools
RUN apt-get update -y && apt-get -y install wget fish htop

# get repos
RUN wget --quiet --no-check-certificate -O - \
    https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list
RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

# install postgresql
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
  echo "log_line_prefix = '%t %a [%p-%l] %q%u@%d '"; \
  echo "ssl = false"; \
) >> /etc/postgresql/${PGVER}/main/postgresql.conf

# pgtune
RUN ( \
  PGVER_SHORT=`echo ${PGVER} | tr -d .`; \
  echo "max_connections = 100"; \
  echo "shared_buffers = 4GB"; \
  echo "effective_cache_size = 12GB"; \
  echo "work_mem = 20971kB"; \
  echo "maintenance_work_mem = 2GB"; \
  if test ${PGVER_SHORT} -lt 95; then \
    echo "checkpoint_segments = 128"; \
  fi; \
  echo "checkpoint_completion_target = 0.9"; \
  echo "wal_buffers = 16MB"; \
  echo "default_statistics_target = 500"; \
) >> /etc/postgresql/${PGVER}/main/postgresql.conf

# TODO: stop relying on service start/stop to fix /var/run/postgresql
RUN service postgresql start && service postgresql stop

# expose port
EXPOSE 5432

# set terminal
ENV TERM xterm

# add start script
ADD start.sh /start.sh
RUN chmod 0755 /start.sh

# add restore scripts
ADD restore_databases.sh /restore_databases.sh
RUN chmod 0755 /restore_databases.sh

# add extensions script
ADD update_extensions.sh /update_extensions.sh
RUN chmod 0755 /update_extensions.sh

# install extras
RUN apt-get -y update && apt-get -y install \
  make \
  postgresql-server-dev-${PGVER}
ADD mapic-postgresql/ /mapic-postgresql
RUN cd /mapic-postgresql && make install && cd -;

# set version
ENV PGVER ${PGVER}

# entrypoint
CMD /start.sh ${PGVER}

# set env
ENV PGUSER postgres
ENV PGDATABASE template1
ENV PGHOST localhost

