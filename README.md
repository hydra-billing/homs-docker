# homs-docker
## Docker container for homs (Hydra Order Management System)

**The container can accept the following variables:**

`$ACTIVITI_HOST`: Activiti host address

`$ACTIVITI_USER`: Activiti user name

`$ACTIVITI_PASSWORD`: Activiti password

`$DB_HOST`: Database host address

`$FORCE_DB_SEED`: Forced re-run of 'bundle exec rake db:seed'

`$RACK_ENV`: Ruby runtime environment (available options: development, production, test)
