#!/bin/bash

set -e

cd $COLLECTD_HOME

TEMPLATE_REGEX='s/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg'
function TEMPLATE
{
  TEMPLATE_TARGET=$1
  # Replace ${ENVIRONMENT_VARIABLE} to actual values.
  perl -p -e "$TEMPLATE_REGEX" "$TEMPLATE_TARGET.template" > "$TEMPLATE_TARGET"
}

CONFIG_FILES=(
  collectd/collectd-arcus.conf
  collectd/collectd-arcus-prefix.conf
  collectd/collectd-listener-5s.conf
  collectd/collectd-listener-1m.conf
  collectd/collectd.conf
)

# Modify configurations
for file in ${CONFIG_FILES[@]}; do
  TEMPLATE $file
done

# Copy collectd stuffs
mkdir -p $COLLECTD_HOME/plugins/python
mkdir -p $COLLECTD_HOME/etc/collectd.conf.d
mkdir -p $COLLECTD_HOME/share/collectd

cp collectd/arcus_stat.py $COLLECTD_HOME/plugins/python
cp collectd/*.conf $COLLECTD_HOME/etc/collectd.conf.d
cp collectd/types.db $COLLECTD_HOME/share/collectd
mv $COLLECTD_HOME/etc/collectd.conf.d/collectd.conf $COLLECTD_HOME/etc

if [ "$SERVER" = "true" ]; then
    rm $COLLECTD_HOME/etc/collectd.conf.d/collectd-arcus*
else
    rm $COLLECTD_HOME/etc/collectd.conf.d/collectd-listener-*
fi

exec collectd -f -C $COLLECTD_HOME/etc/collectd.conf

