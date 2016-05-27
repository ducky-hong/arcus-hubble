FROM node:0.12

RUN apt-get update \
        && apt-get install -y --no-install-recommends --no-install-suggests \
            librrd-dev \
            collectd libpython2.7 \
        && rm -rf /var/lib/apt/lists/*

ENV COLLECTD_HOME /arcus-collectd
RUN mkdir -p $COLLECTD_HOME \
        && mkdir -p $COLLECTD_HOME/plugins/python \
        && mkdir -p $COLLECTD_HOME/share/collectd \
        && ln -s /etc/collectd $COLLECTD_HOME/etc \
        && ln -s /usr/sbin $COLLECTD_HOME/lib

ENV HUBBLE_HOME /arcus-hubble
ENV COLLECTD_RRD_DATADIR /hubble_data
ENV HUBBLE_ZOOKEEPER_HOSTS arcus-zookeeper:2181

WORKDIR $HUBBLE_HOME

RUN npm install https://github.com/Orion98MC/node_rrd.git

ADD . $HUBBLE_HOME

EXPOSE 8080

RUN ./setup.sh
CMD ["./start.sh"]

