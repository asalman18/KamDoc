FROM debian:latest
RUN apt-get update
RUN apt-get -y install git
RUN apt-get -y install gcc g++
RUN apt-get -y install flex
RUN apt-get -y install bison
RUN apt-get -y install default-libmysqlclient-dev
RUN apt-get -y install make autoconf pkg-config

RUN apt-get -y install default-mysql-server

RUN echo "building Kamailio"
RUN mkdir -p /usr/local/src/kamailio-5.4
RUN cd /usr/local/src/kamailio-5.4 && git clone https://github.com/kamailio/kamailio.git kamailio && cd kamailio \
    && git checkout -b 5.4 origin/5.4 \
    && make include_modules="db_mysql" cfg \
    && make all \
    && make install \
    && PATH=$PATH:/usr/local/sbin \
    && export PATH \
    #&& make install-systemd-debian \
    #&& systemctl start kamailio

#RUN /usr/local/sbin/kamailio -P /var/run/kamailio/kamailio.pid -m 128 -M 12
