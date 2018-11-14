# mssql-server-rhel
# Original Maintainers: Travis Wright (twright-msft on GitHub)
# GitRepo: https://github.com/sqlservermigrations/containers

# Base OS layer: latest RHEL 7 hello

FROM registry.access.redhat.com/rhel7

### Atomic/OpenShift Labels - https://github.com/projectatomic/ContainerApplicationGenericLabels
LABEL name="microsoft/mssql-server-linux" \
      vendor="Microsoft" \
      version="15.0" \
      release="1" \
      summary="MS SQL Server" \
      description="MS SQL Server is ....." \
### Required labels above - recommended below
      url="https://www.microsoft.com/en-us/sql-server/" \
      run='docker run --name ${NAME} \
        -e ACCEPT_EULA=Y -e SA_PASSWORD=yourStrong@Password \
        -p 1433:1433 \
        -d  ${IMAGE}' \
      io.k8s.description="MS SQL Server is ....." \
      io.k8s.display-name="MS SQL Server"

### add licenses to this directory
### COPY licenses /licenses

# Install latest mssql-server package
RUN REPOLIST=rhel-7-server-rpms,packages-microsoft-com-mssql-server-preview,packages-microsoft-com-prod && \
    curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-preview.repo && \
    curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/7/prod.repo && \
    ACCEPT_EULA=Y yum -y install --disablerepo "*" --enablerepo ${REPOLIST} --setopt=tsflags=nodocs \
      mssql-server mssql-server-fts mssql-tools unixODBC-devel && \
    yum clean all

COPY uid_entrypoint /opt/mssql-tools/bin/
ENV PATH=${PATH}:/opt/mssql/bin:/opt/mssql-tools/bin
RUN mkdir -p /var/opt/mssql/data && \
    chmod -R g=u /var/opt/mssql /etc/passwd

RUN chmod 755 /opt/mssql-tools/bin/uid_entrypoint
RUN /opt/mssql/bin/mssql-conf set sqlagent.enabled true

# Create script directory
RUN mkdir -p /usr/src/scripts
WORKDIR /usr/src/scripts

# copy scripts from source
COPY . /usr/src/scripts

# Grant permissions for the import-data script to be executable
RUN chmod +x /usr/src/scripts/setup-tools.sh

### Containers should not run as root as a good practice
USER 10001

# Default SQL Server TCP/Port
EXPOSE 1433

VOLUME /var/opt/mssql/data

### user name recognition at runtime w/ an arbitrary uid - for OpenShift deployments
ENTRYPOINT [ "/opt/mssql-tools/bin/uid_entrypoint" ]
# Run SQL Server process
CMD /bin/bash ./entrypoint.sh