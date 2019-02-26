#!/bin/sh
if [ -e /var/www/rails/yukiblog ]; then
  sudo rm -f /var/www/rails/yukiblog/*
else
  sudo mkdir -p /var/www/rails/yukiblog
fi


#latest=`sudo ls -1t * | tail -2` 
