FROM ubuntu:18.04
RUN apt-get -y update
RUN apt-get install -y software-properties-common
RUN add-apt-repository main
RUN add-apt-repository universe
RUN add-apt-repository restricted
RUN add-apt-repository multiverse
RUN export DEBIAN_FRONTEND=noninteractive; \
    export DEBCONF_NONINTERACTIVE_SEEN=true; \
    echo 'tzdata tzdata/Areas select Etc' | debconf-set-selections; \
    echo 'tzdata tzdata/Zones/Etc select UTC' | debconf-set-selections; \
    apt-get update -qqy \
 && apt-get install -qqy --no-install-recommends \
        tzdata \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y python-setuptools
RUN apt-get -y install git
RUN apt-get -y install nodejs redis-server
RUN apt-get -y install gettext libproj-dev libgdal-dev build-essential python-pip python-dev
RUN apt-get -y install sendmail
RUN apt-get -y install libfreetype6-dev
# RUN apt-get -y install xvfb firefox
RUN apt-get -y install postgresql postgresql-server-dev-10 postgresql-contrib postgresql-10-postgis-2.4
RUN npm install --global yarn
COPY setup_postgres.sh .
RUN ./setup_postgres.sh
COPY setup_otm-core.sh .
RUN ./setup_otm-core.sh
