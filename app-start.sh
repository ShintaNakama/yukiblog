#!/bin/sh
cd /var/www/rails/yukiblog
# latest=`sudo ls -1t * | head -1`
bundle install --path vendor/bundle
bundle exec rake assets:precompile RAILS_ENV=production
# bundle exec rails db:migrate
# sudo cp ${latest} /var/www/rails/current
sudo ln -sf /var/www/rails/yukiblog /var/www/html/yukiblog
sudo service httpd graceful