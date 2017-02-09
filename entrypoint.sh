#!/bin/bash

cp -rn /tmp/config/* /opt/homs/config/

if [[ ! -a config/activiti.yml || ! -a activiti.lock ]]; then
	cp config/activiti.yml.sample config/activiti.yml
	[[ -n $ACTIVITI_HOST ]] && sed -i -e "s/localhost/$ACTIVITI_HOST/" config/activiti.yml
	[[ -n $ACTIVITI_USER ]] && sed -i -e "s/user/$ACTIVITI_USER/" config/activiti.yml
	[[ -n $ACTIVITI_PASS ]] && sed -i -e "s/changeme/$ACTIVITI_PASSWORD/" config/activiti.yml
	touch activiti.lock
fi

if [[ ! -a config/database.yml || ! -a db.lock ]]; then
	cp config/database.yml.sample config/database.yml
	[[ -n $DB_HOST ]] && sed -i -e "s/localhost/$DB_HOST/" config/database.yml
	touch db.lock
fi

bundle exec rake db:migrate

if [[ ! -a seed.lock ]]; then 
	bundle exec rake db:seed
	touch seed.lock
fi

thin start --threaded -e ${RACK_ENV:-development}
