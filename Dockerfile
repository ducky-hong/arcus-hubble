FROM node:0.10

RUN apt-get update \
    && apt-get install -y --no-install-recommends librrd-dev python-pip \
    && pip install honcho

ENV HUBBLE_HOME /arcus-hubble

ENV HUBBLE_ORBITER_PORT 3000
ENV HUBBLE_RRD_SERVER_PORT 25832
ENV HUBBLE_WEB_PORT 8080

ENV COLLECTD_RRD_DATADIR /var/lib/collectd/rrd
ENV COLLECTD_LISTENER_IP localhost

RUN mkdir -p /arcus-hubble
WORKDIR /arcus-hubble

COPY package.json /arcus-hubble
RUN npm install
COPY . /arcus-hubble
RUN npm install /arcus-hubble/lib/node_rrd

ENTRYPOINT ["./entrypoint.sh"]
CMD ["honcho", "start"]
