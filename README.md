# Introduction
The image created by this Dockerfile utilizes the Red Hat based Microsoft SQL Server 2019 CTP2.2 image.  The original source can be located at https://github.com/Microsoft/mssql-docker/blob/master/linux/preview/RHEL/Dockerfile.  The following modifications were made:

- Enabled support for Full Text Services
- Enable the SQL Server Agent
- Modified to use the latest CTP of SQL Server 2019
- Creates a database named "DBA".
- Deploys Ola Hallengren's maintenance solution to the DBA database (https://github.com/olahallengren/sql-server-maintenance-solution) and creates the associated jobs.
- Deploys the perms schema to the DBA database which can be used for snapshotting database permissions on the instance.

# File descriptions
- Dockerfile - Used by `docker build` to build the image.
- entrypoint.sh - Starts the setup-tools.sh script and starts the sqlservr service within the container.
- setup-tools.sh - Bash script which uses sqlcmd to run the referenced *.sql scripts.
- uid_entrypoint - Used for Openshift deployments.
- create-dba-database.sql - Script used to create the DBA database.  Data and log files are placed within the default /var/opt/mssql/data directories.
- tools-additional-jobs.sql - Creates two SQL Server agent jobs to cycle the error log each day and to snapshot all permissions.
- tools-ola-maintenancesolution.sql - Deploys Ola Hallengren's SQL Server maintenance solution to the DBA database and creates the associated jobs.
- tools-permission-snapshot.sql - Creates the perms schema and objects within the DBA database.
- tools-sp-whoisactive.sql - Deploys Adam Machanic's sp_whoisactive stored procedure to the master database.

# Prerequisites for building a RHEL-based image
- You will need access to the [Red Hat Container Catalog](https://access.redhat.com/containers) via a Red Hat subscription.  A free developer subscription is available.
- You'll need a Red Hat Enterprise Linux VM (or physical machine) that has been registered to your subscription.  The [Red Hat Container Developer Kit](https://developers.redhat.com/products/cdk/overview/) can be utilized as well.
- If using a RHEL VM or physical machine, Docker must be installed.
- git is needed to clone this repository. 
- Prior to building the image, the password within the setup-tools.sh file, line 9, must be set to the same password used when building the image.

# Building the image using a RHEL VM
- ssh to the RHEL VM.
- Verify that docker is running `sudo systemctl status docker`
- Make a directory to clone the repository to and then clone
```sh
mkdir ~/sqlservermigrations
cd ~/sqlservermigrations
git clone https://github.com/sqlservermigrations/containers
```
- Build the image using docker build
- Prior to building, set the password in setup-tools.sh.  For this example, it's set to YourStrongP@ssword.
```sh
cd ~/sqlservermigrations/containers
sudo docker build . -t sqlservermigrations/mssqlserver:2019_CTP2.2
```

# Starting a mssql-server instance
- Verify the image was built successfully.  `docker images` should display the image.
```sh
sudo docker images
```
- You should see the new image listed.
- Next use `docker run` to start a container using the image.
```sh
sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=YourStrongP@ssword' --name mssql2019 -p 1433:1433 -d sqlservermigrations/mssqlserver:2019_CTP2.2
```

# Connect to Microsoft SQL Server
This image includes the mssql-tools package.  sqlcmd can be used to provide a quick connection.  SQL Server Management Studio or Azure Data Tools could be used as well.

- Quick test using sqlcmd and `docker exec`.
```sh
sudo docker exec -it mssql2019 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P YourStrongP@ssword -Q "SELECT @@VERSION"
```
- Connect remotely using SQL Server Management Studio or Azure Data Studio using the RHEL VM host IP and the port.  In this case, since the default port of 1433 was used, there's no need to specify the report.  If you're unable to connect, verify the port is allowed through any firewalls that may be running on the host.






