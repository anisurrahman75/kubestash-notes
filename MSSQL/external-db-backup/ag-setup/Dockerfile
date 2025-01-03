# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Install necessary tools and dependencies
RUN set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends apt-transport-https ca-certificates curl bzip2 git gpg nano fish \
  && apt-get install -y sudo wget gnupg software-properties-common systemd vim fish iputils-ping

# Add Microsoft's GPG key and repository
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - \
  && add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list)" \
  && apt-get update

# Install SQL Server
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true
RUN apt-get install -y mssql-server

# Install sqlcmd client tool
RUN curl -o sqlcmd.bz2 -fsSL https://github.com/microsoft/go-sqlcmd/releases/download/v1.6.0/sqlcmd-v1.6.0-linux-amd64.tar.bz2 \
  && tar -xf sqlcmd.bz2 \
  && chmod +x sqlcmd \
  && mv sqlcmd /usr/bin/sqlcmd

# Expose required ports for SQL Server and Availability Groups
# EXPOSE 1433 5022

# Copy the AG setup script into the container
COPY setup-ag.sh /setup-ag.sh
RUN chmod +x /setup-ag.sh

# Configure SQL Server settings (adjust as needed)
RUN echo "[sqlagent]\n\
enabled = true\n\
\n\
[licensing]\n\
azurebilling = false\n\
\n\
[EULA]\n\
accepteula = Y\n\
\n\
[hadr]\n\
hadrenabled = 1\n\
" > /var/opt/mssql/mssql.conf \
  && chown mssql:mssql /var/opt/mssql/mssql.conf \
  && chmod 600 /var/opt/mssql/mssql.conf

# Set the default entrypoint
# ENTRYPOINT ["/lib/systemd/systemd"]

EXPOSE 1433 5022
ENTRYPOINT /opt/mssql/bin/sqlservr
