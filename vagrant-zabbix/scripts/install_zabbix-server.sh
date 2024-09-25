!#/bin/bash

# Provisionar a VM com um script shell para instalar Zabbix e MySQL
##
# Atualizar pacotes
sudo apt-get update -y && sudo apt-get upgrade -y
  
# Instalar o MySQL Server
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password zabbix'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password zabbix'
sudo apt-get install -y mysql-server
  
# Criar banco de dados e usuário Zabbix
sudo mysql -uroot -pzabbix -e "CREATE DATABASE zabbix CHARACTER SET utf8 COLLATE utf8_bin;"
sudo mysql -uroot -pzabbix -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix';"
sudo mysql -uroot -pzabbix -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';"
sudo mysql -uroot -pzabbix -e "FLUSH PRIVILEGES;"
  
# Instalar dependências do Zabbix Server
sudo apt-get install -y wget lsb-release
  
# Baixar repositório do Zabbix
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-3%2Bubuntu20.04_all.deb
sudo dpkg -i zabbix-release_6.0-3+ubuntu20.04_all.deb
sudo apt-get update
  
# Instalar Zabbix Server com MySQL e frontend
sudo apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent
  
# Importar o esquema inicial do banco de dados para o Zabbix
sudo zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -pzabbix zabbix
  
# Configurar o Zabbix Server para usar o banco de dados MySQL
sudo sed -i "s/# DBPassword=/DBPassword=zabbix/" /etc/zabbix/zabbix_server.conf
  
# Reiniciar e habilitar os serviços do Zabbix e do Apache
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2