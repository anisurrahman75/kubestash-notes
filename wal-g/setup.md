## Install Wal-g

- wget https://github.com/wal-g/wal-g/releases/download/v3.0.0/wal-g-sqlserver-ubuntu-20.04-amd64.tar.gz
- tar -zxvf wal-g-sqlserver-ubuntu-20.04-amd64.tar.gz
- mv wal-g-sqlserver-ubuntu-20.04-amd64 /usr/local/bin/wal-g
- rm wal-g-sqlserver-ubuntu-20.04-amd64.tar.gz

## Install Sql-Server-2022
- curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
- sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2022.list)"
- sudo apt-get update
- sudo apt-get install -y mssql-server
- sudo /opt/mssql/bin/mssql-conf setup
- systemctl status mssql-server --no-pager


## Install go-sqlcmd 
- wget https://github.com/microsoft/go-sqlcmd/releases/download/v1.6.0/sqlcmd-v1.6.0-linux-amd64.tar.bz2
- tar -xf sqlcmd-v1.6.0-linux-amd64.tar.bz2
- chmod +x sqlcmd
- sudo mv sqlcmd /usr/local/bin/sqlcmd
- sqlcmd '-?'




