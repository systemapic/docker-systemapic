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








# FROM postgres:9.6
# MAINTAINER Mike Dillon <mike@appropriate.io>

# ENV POSTGIS_MAJOR 2.3
# ENV POSTGIS_VERSION 2.3.1+dfsg-1.pgdg80+1

# # # tools
# # RUN apt-get update && apt-get -y install curl

# # # get packages
# # RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ "$(lsb_release -sc)"-pgdg main" >> /etc/apt/sources.list.d/pgdg.list
# # RUN curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc |  apt-key add -


# RUN apt-get update \
#       && apt-get install -y --no-install-recommends \
#            postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
#            postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts=$POSTGIS_VERSION \
#            postgis=$POSTGIS_VERSION \
#       && rm -rf /var/lib/apt/lists/*

# # RUN mkdir -p /docker-entrypoint-initdb.d
# # COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh

# # set locale
# RUN locale-gen --no-purge en_US.UTF-8
# ENV LC_ALL en_US.UTF-8
# RUN update-locale LANG=en_US.UTF-8


# # configure postresql
# ADD configure-postgresql.sh /tmp/
# RUN sh /tmp/configure-postgresql.sh

# EXPOSE 5432

# ADD update_extensions.sh /update_extensions.sh
# RUN chmod 0755 /update_extensions.sh

# ADD start.sh /start.sh
# RUN chmod 0755 /start.sh

# ADD restore_databases.sh /restore_databases.sh
# RUN chmod 0755 /restore_databases.sh

# ENV PGVER ${PG_VERSION}
# CMD /start.sh ${PG_VERSION}

# ENV PGUSER postgres
# ENV PGDATABASE template1
# ENV PGHOST localhost







#################
# FROM ubuntu:trusty

# # set versions
# ENV PG_VERSION=9.3
# ENV POSTGIS_VERSION=2.2
# ENV TERM xterm

# MAINTAINER Knut Ole Sjøli <knutole@mapic.io>

# # tools
# RUN apt-get update && apt-get -y install wget make build-essential fish htop curl

# # get packages
# RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ "$(lsb_release -sc)"-pgdg main" >> /etc/apt/sources.list.d/pgdg.list
# RUN curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc |  apt-key add -

# # install postgresql/postgis
# RUN apt-get update && apt-get -y install --no-install-recommends postgresql-$PG_VERSION postgresql-contrib-$PG_VERSION postgresql-server-dev-${PG_VERSION}
# RUN apt-get -y install --no-install-recommends postgis postgresql-$PG_VERSION-postgis-$POSTGIS_VERSION

# # set locale
# RUN locale-gen --no-purge en_US.UTF-8
# ENV LC_ALL en_US.UTF-8
# RUN update-locale LANG=en_US.UTF-8

# # ADD pg_hba.conf /etc/postgresql/$PG_VERSION/main/pg_hba.conf 
# # ADD postgresql.conf /etc/postgresql/$PG_VERSION/main/postgresql.conf

# # RUN sed -i "s/{{PG_VERSION}}/$PG_VERSION/" /etc/postgresql/$PG_VERSION/main/postgresql.conf


# # RUN mkdir -p /data

# # ENV POSTGRES="/usr/lib/postgresql/$PG_VERSION/bin/postgres"
# # ENV CONFIG_PATH="/etc/postgresql/$PG_VERSION/main/"

# # VOLUME ["/data"]

# # ADD configure_postgres.sh /etc/my_init.d/01_configure_postgres
# # ADD bootstrap.sh /etc/my_init.d/09_bootstrap
# # ADD start_postgres.sh /etc/my_init.d/99_start_postgres

# # #cleanup
# # RUN apt-get clean
# # RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# # configure postresql
# ADD configure-postgresql.sh /tmp/
# RUN sh /tmp/configure-postgresql.sh

# EXPOSE 5432

# ADD update_extensions.sh /update_extensions.sh
# RUN chmod 0755 /update_extensions.sh

# ADD start.sh /start.sh
# RUN chmod 0755 /start.sh

# ADD restore_databases.sh /restore_databases.sh
# RUN chmod 0755 /restore_databases.sh

# ENV PGVER ${PG_VERSION}
# CMD /start.sh ${PG_VERSION}

# ENV PGUSER postgres
# ENV PGDATABASE template1
# ENV PGHOST localhost

# # # postgres 9.3
# # # postgis 2.2.1


# # FROM ubuntu:trusty
# # ENV PGVER 9.3
# # ENV TERM xterm

# # # TODO: find a way to report version at build time
# # # RUN echo PGVER is ${PGVER}

# # MAINTAINER Sandro Santilli <strk@keybit.net>

# # # install tools
# # RUN apt-get update && apt-get -y install wget make build-essential fish htop

# # # get postgresql repo
# # # RUN wget --quiet --no-check-certificate -O - \
# # #     https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
# # # RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list
# # # RUN locale-gen --no-purge en_US.UTF-8
# # # ENV LC_ALL en_US.UTF-8
# # # RUN update-locale LANG=en_US.UTF-8

# # # install postgresql
# # # RUN apt-get -y update && apt-get install -y \
# # #   postgresql-contrib-${PGVER} \
# # #   postgresql-${PGVER} \
# # #   postgresql-${PGVER}-postgis-2.2
# #   # postgresql-${PGVER}-postgis-2.1
# # # We do not install recommends because they could bring in
# # # non-wanted PostgreSQL versions.
# # # See https://github.com/systemapic/docker-systemapic/issues/13
# # # RUN apt-get -y update && apt-get -y install --no-install-recommends postgis

# # # install postgresql
# # ADD ./install-postgresql-9.3.sh /tmp/
# # RUN sh /tmp/install-postgresql-9.3.sh   

# # # install postgis
# # ADD ./install-postgis-2.2.1.sh /tmp/
# # RUN sh /tmp/install-postgis-2.2.1.sh

# # # configure postresql
# # ADD ./configure-postgresql.sh /tmp/
# # RUN sh /tmp/configure-postgresql.sh

# # # # configure access
# # # RUN echo "host    all             all             0.0.0.0/0 md5" >> /etc/postgresql/${PGVER}/main/pg_hba.conf

# # # # configure postgresql
# # # RUN ( \
# # #   echo "listen_addresses = '*'"; \
# # #   echo "port = 5432"; \
# # #   : echo "log_statement = ddl"; \
# # #   echo "log_statement = none"; \ 
# # #   : echo "log_statement = all"; \
# # #   echo "log_min_error_statement = ERROR"; \
# # #   echo "log_line_prefix = '%t %a [%p-%l] %q%u@%d '"; \
# # #   echo "ssl = false"; \
# # # ) >> /etc/postgresql/${PGVER}/main/postgresql.conf

# # # # pgtune
# # # RUN ( \
# # #   PGVER_SHORT=`echo ${PGVER} | tr -d .`; \
# # #   echo "max_connections = 100"; \
# # #   echo "shared_buffers = 4GB"; \
# # #   echo "effective_cache_size = 12GB"; \
# # #   echo "work_mem = 20971kB"; \
# # #   echo "maintenance_work_mem = 2GB"; \
# # #   if test ${PGVER_SHORT} -lt 95; then \
# # #     echo "checkpoint_segments = 128"; \
# # #   fi; \
# # #   echo "checkpoint_completion_target = 0.9"; \
# # #   echo "wal_buffers = 16MB"; \
# # #   echo "default_statistics_target = 500"; \
# # # ) >> /etc/postgresql/${PGVER}/main/postgresql.conf


# # # # TODO: stop relying on service start/stop to fix /var/run/postgresql
# # # RUN service postgresql start && service postgresql stop

# # EXPOSE 5432

# # # RUN apt-get install -y fish htop

# # # RUN apt-get update && apt-get -y install \
# # #   postgresql-server-dev-${PGVER}
# # ADD mapic-postgresql/ /mapic-postgresql
# # RUN cd /mapic-postgresql && make install && cd -;

# # # ADD default_env.txt /systemapic/configs/env  # added by build_config.sh in /docks/config/... @strk: YES, we need a deafult 
# # # RUN chmod 0600 /systemapic/configs/env

# # ADD update_extensions.sh /update_extensions.sh
# # RUN chmod 0755 /update_extensions.sh

# # ADD start.sh /start.sh
# # RUN chmod 0755 /start.sh

# # ADD restore_databases.sh /restore_databases.sh
# # RUN chmod 0755 /restore_databases.sh

# # # ENV PGVER ${PGVER}
# # CMD /start.sh ${PGVER}

# # ENV PGUSER postgres
# # ENV PGDATABASE template1
# # ENV PGHOST localhost

