#!/bin/bash
PATH=/bin:/usr/bin:/usr/sbin

getent passwd ${PAM_USER} > /dev/null 2&>1
if [ $? -eq 0 ]; then
  echo "user exists: ${PAM_USER}" >> /tmp/hi
  #exit 0
else
  echo "user not exists: ${PAM_USER}" >> /tmp/hi
  adduser --disabled-login --disabled-password --force-badname --firstuid 1000 --gecos "" --ingroup rstudio-users ${PAM_USER}
  exit 0
fi