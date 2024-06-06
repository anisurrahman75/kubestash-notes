FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install apt-utils -y --no-install-recommends apt-transport-https ca-certificates curl bzip2

RUN apt-get install sudo nano wget curl gnupg gnupg1 gnupg2 -y
RUN apt-get install software-properties-common systemd vim -y
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -


RUN https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg
RUN curl -fsSL https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list | sudo tee /etc/apt/sources.list.d/mssql-server-2022.list
RUN sudo apt-get update
RUN sudo apt-get install -y mssql-server

RUN curl -o sqlcmd.bz2 -fsSL https://github.com/microsoft/go-sqlcmd/releases/download/v1.6.0/sqlcmd-v1.6.0-linux-amd64.tar.bz2 \
    && tar -xf sqlcmd.bz2 \
    && chmod +x sqlcmd \
    && cp sqlcmd /bin/sqlcmd

EXPOSE 1433 5022

ENTRYPOINT /opt/mssql/bin/sqlservr
