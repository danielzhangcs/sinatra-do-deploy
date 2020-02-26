## Sinatra-API
### Author: Daniel Zhang

In this Project, I created create a multi-server architecture for making a simple app for creating and retrieving a list of users from the database!

## Architecture

- Sinatra Frontend (1 Droplet)
  - Responsible for asking the Service API for the list of users, and render a html page for it.
- Sinatra Service API (1 Droplet)
  - Responsible for talking to Postgres and retrieving Users' information.
- Postgres DB (1 Database)

FrontEnd public ipv4: http://167.71.104.147 
