#!/bin/sh
if [ -e /var/www/rails/yukiblog ]; then
  cd /var/www/rails/yukiblog
  sudo rm -rf *
else
  sudo mkdir /var/www/rails/yukiblog
fi


#latest=`sudo ls -1t * | tail -2` 
