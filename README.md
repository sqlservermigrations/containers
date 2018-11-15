# Introduction
The image created by this Dockerfile utilizes the Red Hat based Microsoft SQL Server 2019 CTP2.1 image.  The original source can be located at https://github.com/Microsoft/mssql-docker/blob/master/linux/preview/RHEL/Dockerfile.  The following modifications were made:

- Enabled support for Full Text Services
- Enable the SQL Server Agent
- Modified to use the latest CTP of SQL Server 2019
- Creates a database named "DBA".
- Deploys Ola Hallengren's maintenance solution to the DBA database (https://github.com/olahallengren/sql-server-maintenance-solution) and creates the associated jobs.
- Deploys the perms schema to the DBA database which can be used for snapshotting database permissions on the instance.

# Prerequisites for building a RHEL-based image
- You will need access to the [Red Hat Container Catalog](https://access.redhat.com/containers) via a Red Hat subscription.  A free developer subscription is available.
- You'll need a Red Hat Enterprise Linux VM (or physical machine) that has been registered to your subscription.  The [Red Hat Container Developer Kit](https://developers.redhat.com/products/cdk/overview/) can be utilized as well.
- If using a RHEL VM or physical machine, Docker must be installed.
- git is needed to clone this repository. 
- Prior to building the image, the password within the setup-tools.sh file, line 9, must be set to the same password used when building the image.

# Building the image using a RHEL VM
- ssh to the RHEL VM.
- Verify that docker is running `sudo systemctl status docker.service`
- Make a directory to clone the repository to and then clone
```{r, engine='bash', code_block_name}
mkdir ~/sqlservermigrations
cd ~/sqlservermigrations
git clone https://github.com/sqlservermigrations/containers
```
- Build the image using docker build
- Prior to building, set the password in setup-tools.sh.  For this example, it's set to YourStrongP@ssword.
```#!/bin/bash
cd ~/sqlservermigrations/containers
sudo docker build . -t sqlservermigrations/mssqlserver:2019_CTP2.1
```

# Starting a mssql-server instance
- Verify the image was built successfully.  `docker images` should display the image.
```bash
sudo docker images





