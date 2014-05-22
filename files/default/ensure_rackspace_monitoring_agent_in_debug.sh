#!/bin/sh

IN_DEBUG_MODE=`tail -n 15 /var/log/rackspace-monitoring-agent.log | grep DBG`
if [ -z "$IN_DEBUG_MODE" ]
then
  pgrep -f rackspace-monitoring-agent | xargs kill -SIGUSR2
fi
chmod 755 /var/log/rackspace-monitoring-agent.log
