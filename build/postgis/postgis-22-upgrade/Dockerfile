FROM systemapic/postgis:94-21

RUN apt-get -y update && apt-get install -y \
	autoconf \
	build-essential \
	docbook-xsl \
	libgdal-dev \
	libgeos-dev \
	libjson-c-dev \
	libproj-dev \
	libtool \
	libxml2-dev \
	postgresql-server-dev-9.4 \
	xsltproc

RUN wget https://github.com/postgis/postgis/archive/2.2.1.tar.gz

RUN tar xzf 2.2.1.tar.gz

RUN cd postgis-2.2.1 && \
  ./autogen.sh && ./configure && make install
