#!/bin/bash
echo "New Relic Integration Installer"

if [ "$EUID" -ne 0 ]
  then echo "Please run with sudo or as root"
  exit
fi

echo "Stopping NR Infrastructure Agent"
if [ -f /etc/systemd/system/newrelic-infra.service ]; then
    echo "SYSTEMD"
    service newrelic-infra stop
fi
if [ -f /etc/init/newrelic-infra.conf ]; then
    echo "INITCTL"
    initctl stop newrelic-infra
fi

echo "Copying Files"
cp ./nri-docker-config.yml /etc/newrelic-infra/integrations.d/
cp ./nri-docker-def-nix.yml /var/db/newrelic-infra/custom-integrations/
cp ./nri-docker /var/db/newrelic-infra/custom-integrations/

echo "Starting NR Infrastructure Agent"
if [ -f /etc/systemd/system/newrelic-infra.service ]; then
    service newrelic-infra start
fi
if [ -f /etc/init/newrelic-infra.conf ]; then
    initctl start newrelic-infra
fi