#!/bin/bash

if [[ -d /tmp/config ]]; then
	cp -rn /tmp/config/* /opt/homs/config/
	rm -rf /tmp/*
fi

while [[ -n $1 ]]; do
	case $1 in
		-a )	rm -f config/activiti.yml
			;;
		-d )	rm -f config/database.yml
			;;
		-s )	rm -f seed.lock
			;;
		* )	continue
			;;
	esac
	shift
done

if [[ ! -a config/activiti.yml ]]; then
	cp config/activiti.yml.sample config/activiti.yml
	sed -i -e "s/localhost/$ACTIVITI_HOST/" config/activiti.yml
	sed -i -e "s/user/$ACTIVITI_USER/" config/activiti.yml
	sed -i -e "s/changeme/$ACTIVITI_PASSWORD/" config/activiti.yml
fi

if [[ ! -a config/database.yml ]]; then
	cp config/database.yml.sample config/database.yml
	sed -i -e "s/localhost/$DB_HOST/" config/database.yml
fi

bundle exec rake db:migrate

if [[ ! -a seed.lock ]]; then 
	bundle exec rake db:seed
	touch seed.lock
fi

thin start --threaded -e $RACK_ENV
