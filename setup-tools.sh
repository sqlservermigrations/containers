#wait for the SQL Server to come up
sleep 30s

#run the setup script to create the DB and the schema in the DB
sqlfiles=( create-dba-database.sql tools-permission-snapshot.sql tools-ola-maintenancesolution.sql tools-sp-whoisactive.sql tools-additional-jobs.sql )

for file in "${sqlfiles[@]}"
do 
 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P YourStrongP@ssword -d master -i "${file}"
 sleep 1
done

