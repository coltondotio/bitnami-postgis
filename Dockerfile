FROM bitnami/postgresql:10
USER root

RUN mkdir -p /var/lib/apt/lists/partial \
   && install_packages wget gcc make build-essential libxml2-dev libgeos-dev libproj-dev libgdal-dev postgresql-contrib libprotobuf-c1 libprotobuf-c-dev protobuf-c-compiler

ENV POSTGIS_VERSION 2.5.2

RUN wget -O /tmp/postgis.tar.gz "https://download.osgeo.org/postgis/source/postgis-$POSTGIS_VERSION.tar.gz"

RUN cd /tmp \
   && export C_INCLUDE_PATH=/opt/bitnami/postgresql/include/:/opt/bitnami/common/include/ \
   && export LIBRARY_PATH=/opt/bitnami/postgresql/lib/:/opt/bitnami/common/lib/ \
   && export LD_LIBRARY_PATH=/opt/bitnami/postgresql/lib/:/opt/bitnami/common/lib/ \
   && tar zxf postgis.tar.gz \
   && cd postgis-$POSTGIS_VERSION \
   && ./configure --with-pgconfig=/opt/bitnami/postgresql/bin/pg_config \
   && make \
   && make install
