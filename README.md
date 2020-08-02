# horizon-db
Database schemas and objects for horizon services. Requires db-migrate node app.
### Usage:
1. db-migrate up # Applies commons and deployer
2. db-migrate up:auth # Auth Schema def
3. db-migrate up:esi # Esi depdends on auth
4. bin/dev-evesde-all # Download and restore eve sde data from fuzzwork
5.  db-migrate up:api
