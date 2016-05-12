#!/bin/bash

rstudio() {
  echo "Starting rstudio server..."
  /usr/lib/rstudio-server/bin/rserver --server-daemonize 0
}

rstudio & rstudio_pid=${!}

trap "{ kill $rstudio_pid; exit 0; }" SIGTERM

while true
do
  tail -f /dev/null & wait ${!}
done
