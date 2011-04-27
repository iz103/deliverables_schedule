Install it with homebrew

    brew install postgres

Once postgres is installed, run:

    psql
    steve=# create user deliverables_schedule superuser;
    steve=# create database deliverables_schedule_development owner deliverables_schedule;
    steve=# create database deliverables_schedule_test owner deliverables_schedule;
