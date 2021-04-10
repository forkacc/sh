#!/bin/bash

yum update && sudo yum -y upgrade

# SSH
mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
echo "ssh-rsa *** i@anonid.me" > ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

sshd_conf=/etc/ssh/sshd_config
cat>>$sshd_conf <<SSHD_CONF
Protocol 2
UseDNS no
RSAAuthentication yes
PubkeyAuthentication yes
PasswordAuthentication yes
PermitEmptyPasswords no
AuthenticationMethods publickey,password
Port 34567
SSHD_CONF

#systemctl restart sshd

# Firewall
yum -y install firewalld firewall-config
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --zone=public --add-port=34567/tcp --permanent
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --reload

#sudo yum -y install epel-release
#sudo yum -y install openssl openssl-devel
#sudo yum -y install pcre pcre-devel
#sudo yum -y install zlib zlib-devel
#sudo yum -y install bzip2 bzip2-devel
#sudo yum -y install libevent libffi-devel
#sudo yum -y install unzip
#sudo yum -y install git
#sudo yum -y install python python-devel python-setuptools python-pip
#sudo yum -y install golang

sudo yum clean all
