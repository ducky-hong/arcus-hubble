#!/bin/bash

if [ -z $HUBBLE_ZOOKEEPER_HOSTS ]; then
    echo "HUBBLE_ZOOKEEPER_HOSTS is empty."
    exit 1
fi

TEMPLATE_REGEX='s/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg'
function TEMPLATE
{
  TEMPLATE_TARGET=$1
  # Replace ${ENVIRONMENT_VARIABLE} to actual values.
  perl -p -e "$TEMPLATE_REGEX" "$TEMPLATE_TARGET.template" > "$TEMPLATE_TARGET"
}

CONFIG_FILES=(
  conf/conf-orbiter.json
  conf/conf-rrd.json
  conf/conf-view.json
  view/modules/config.js
)

# Modify configurations
for file in ${CONFIG_FILES[@]}; do
  echo $file
  TEMPLATE $file
done

# Wait until the first zookeeper host is reachable.
ZK_HOSTS=(${HUBBLE_ZOOKEEPER_HOSTS//,/ })
ZK_FIRST_HOST=${ZK_HOSTS[0]}
ZK_ENDPOINT=/dev/tcp/${ZK_FIRST_HOST//:/\/}
until timeout 1 bash -c "cat < /dev/null > $ZK_ENDPOINT"; do
    >&2 echo "$ZK_FIRST_HOST is unavailable - waiting"
    sleep 1
done

eval "$@"
