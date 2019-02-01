FROM ubuntu:18.04
RUN apt-get -y update
RUN apt-get -y install python-setuptools software-properties-common git
RUN apt-get -y install nodejs redis-server
RUN apt-get -y install gettext libproj-dev libgdal-dev build-essential python-pip python-dev
RUN apt-get -y install sendmail
RUN apt-get -y install libfreetype6-dev
# RUN apt-get -y install xvfb firefox
RUN apt-get -y install postgresql postgresql-server-dev-10 postgresql-contrib postgresql-10-postgis-2.4
COPY setup_postgres.sh .
RUN ./setup_postgres.sh
COPY setup_otm-core.sh .
RUN ./setup_otm-core.sh
