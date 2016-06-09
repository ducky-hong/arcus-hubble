#!/bin/sh

set -e

if [ -z "$COLLECTD_LISTENER_IP" ]; then
    echo "COLLECTD_LISTENER_IP must be set."
    exit 1
fi

sed -i "s/\${COLLECTD_LISTENER_IP}/$COLLECTD_LISTENER_IP/g" /etc/collectd/collectd.conf.d/collectd-arcus.conf
sed -i "s/\${COLLECTD_LISTENER_5S_PORT}/$COLLECTD_LISTENER_5S_PORT/g" /etc/collectd/collectd.conf.d/collectd-arcus.conf

sed -i "s/\${COLLECTD_LISTENER_IP}/$COLLECTD_LISTENER_IP/g" /etc/collectd/collectd.conf.d/collectd-arcus-prefix.conf
sed -i "s/\${COLLECTD_LISTENER_1M_PORT}/$COLLECTD_LISTENER_1M_PORT/g" /etc/collectd/collectd.conf.d/collectd-arcus-prefix.conf

collectd -C /etc/collectd/collectd.conf.d/collectd-arcus.conf
collectd -C /etc/collectd/collectd.conf.d/collectd-arcus-prefix.conf

exec "$@"
