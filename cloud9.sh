echo "Configuring PostgreSQL"
sudo service postgresql start
sudo sudo -u postgres psql -c "CREATE USER cloud9 SUPERUSER PASSWORD 'password';"


echo "Exporting Environment Variables"
echo "export USERNAME=cloud9" >> ~/.profile
echo "export PASSWORD=password" >> ~/.profile
source ~/.profile

echo "Updating template1 for database.yml"
sudo sudo -u postgres psql <<EOF
UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';
DROP DATABASE template1;
CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UNICODE';
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';
\c template1
VACUUM FREEZE;
EOF

echo "Create and Set Up Database"
cd edumap/
gem install bundler
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed

echo "Run the App"
rails server -p $PORT -b $IP

echo "Script Finished"