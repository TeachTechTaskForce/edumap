### Introduction

Cloud9 is an open source, online IDE. Among other things, it supports Ruby, Ruby on Rails, 
GitHub, Heroku, and PostgreSQL. 

Follow the instructions below to set up your own Cloud9 workspace for the [EduMap application](https://edumap2.herokuapp.com). 

### Get the code in Cloud9

1. In GitHub, fork the [EduMap repository](https://github.com/andyras/edumap).

2. Open [Cloud9](https://c9.io) and click on the octocat icon in the top right corner of the home page. Log in using your GitHub credentials.  

3. Once logged in, click on "Create A New Workspace". 

4. Give your workspace a name. We suggest something like edumap-workspace. 

5. In the "Hosted Workspace" section, make sure you select public (as opposed to private).

6. Under "Clone from Git or Mercurial URL", paste the link to your GitHub fork of the EduMap repository.

7. For the "Choose a Template" section, select the Ruby icon. 

8. Click "Create Workspace"

This gives you a Cloud9 workspace with all the EduMap files and necessary software installed. 

### Configure PostgrSQL

Create a new username and password for postgresql on cloud9:

9. $ sudo service postgresql start

10. $ sudo sudo -u postgres psql

11. postgres=# CREATE USER username SUPERUSER PASSWORD 'password';
>> CREATE ROLE

12. postgres=# \q

Create ENV variable on Cloud9:

13. $ echo "export USERNAME=username" >> ~/.profile

14. $ echo "export PASSWORD=password" >> ~/.profile

15. $ source ~/.profile

Update database.yml: 

16. Open edumap/config/database.yml

17. The 'default' block begins on line 17. Make it look exactly like this:

default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see rails configuration guide
  # http://guides.rubyonrails.org/configuring.html#database-pooling
  pool: 5
  username: <%= ENV['USERNAME'] %>
  password: <%= ENV['PASSWORD'] %>
  host:     <%= ENV['IP'] %>

Update template1 postgresql for database.yml on cloud9:

18. $ sudo sudo -u postgres psql

19. postgres=# UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';
>> UPDATE 1

20. postgres=# DROP DATABASE template1;
>> DROP DATABASE

21. postgres=# CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UNICODE';
>> CREATE DATABASE

22. postgres=# UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';
>> UPDATE 1

23. postgres=# \c template1
>> You are now connected to database "template1" as user "postgres".

24. template1=# VACUUM FREEZE;
>> VACUUM

25. template1=# \q

Now configure the workspace:

26. cd to edumap/

27. gem install bundler

28. bundle install

29. bundle exec rake db:create

30. bundle exec rake db:migrate

31. bundle exec rake db:seed

You can now run the app in the Cloud9 environment with the follwoing command:

rails server -p $PORT -b $IP

The terminal output will have a link the home page. 



