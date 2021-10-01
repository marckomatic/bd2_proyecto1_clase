sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo apt update
sudo apt install git

#docker
sudo docker pull dockerhelp/docker-oracle-ee-18c
sudo docker run -d -p  -it 1521:1521   dockerhelp/docker-oracle-ee-18c bash
sh post_install.sh
#sqlplus
#user: sys as sysdba
#pass: oracle
#alter session set "_ORACLE_SCRIPT"=true;
#create user BASES identified by bases2;
#grant dba to BASES;
