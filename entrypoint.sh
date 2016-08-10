#!/bin/bash

cd /opt/homs
find config -name "activiti.yml.sample" -exec sed -i -e "s/localhost/$ACTIVITI_HOST/" '{}' \; \
&& find config -name "database.yml.sample" -exec sed -i -e "s/localhost/$DB_HOST/" '{}' \; \
&& find config -name '*.sample' | xargs -I{} sh -c 'cp $1 ${1%.*}' -- {}
bundle exec rake db:migrate

if [[ ! -a seed.lock || "$FORCE_DB_SEED" = "yes" ]]; then 
	bundle exec rake db:seed
	touch seed.lock
fi

thin start --threaded
