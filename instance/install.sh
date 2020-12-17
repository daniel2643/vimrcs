#########################################################################
# File Name: install.sh
# Author: Daniel Gao
# mail: seraphdg@gmail.com
# Created Time: Thu Dec  3 18:31:52 2020
#########################################################################
#!/bin/bash

# before all: mkdir ~/.ssh/authorized_keys in host && paste public key from client to here

bash_profile=~/.bash_profile
if [ -e "$bash_profile" ]; then
  source ~/.bash_profile
fi

# packages
sudo yum update -y
sudo yum install -y perl vim python2 tree nodejs git wget

# sudoer
sudo rsync ~/sudoers /etc/sudoers

# shadowsocks VPN
sudo curl "http://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
sudo python2 get-pip.py
sudo pip2 install shadowsocks
sudo mkdir /etc/shadowsocks
sudo mv ~/config.json /etc/shadowsocks/
sudo touch /etc/systemd/system/ssserver.service
sudo rsync ~/ssserver.service /etc/systemd/system/ssserver.service
sudo sed -i 's/EVP_CIPHER_CTX_cleanup/EVP_CIPHER_CTX_reset/g' /usr/lib/python2.7/site-packages/shadowsocks/crypto/openssl.py
sudo systemctl daemon-reload
sudo systemctl enable ssserver
sudo systemctl start ssserver
sudo rm get-pip.py

# vimrc
mkdir -p ~/.vim/autoload
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "let g:coc_disable_startup_warning = 1" >> ~/.vimrc
mv ~/coc-settings.json ~/.vim/
# edit .bashrc .bash_profile to delete lines for macOS

# root
sudo cp ~/.vimrc /root/
sudo cp ~/.vim/coc-settings.json /root/
sudo cp ~/.bash_profile /root/
sudo cp ~/.bashrc /root/
sudo cp ~/.gitconfig /root/

# ssh
ssh-keygen -t rsa -b 4096

# tomcat
sudo yum install -y java-1.8.0-openjdk-devel
wget https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-9/v9.0.40/bin/apache-tomcat-9.0.40.tar.gz
tar -zxpvf apache-tomcat-9.0.40.tar.gz
sudo mv apache-tomcat-9.0.40 tomcat
sudo mv tomcat /opt/
sudo mv ~/apache-tomcat-9.0.40.tar.gz /opt/tomcat
cd /opt/
echo "export CATALINA_HOME='/opt/tomcat/'" >> ~/.bashrc
source ~/.bashrc
sudo sed -i 's/8080/80/g' /opt/tomcat/conf/server.xml

  # specify the Users for Manager GUI Page and Admin Page Access.
    #By default no user or account is allowed to access Manager GUI Page and Admin Page. So to grant access to the users add the following lines in the file “/opt/tomcat/conf/tomcat-users.xml” just above <tomcat-users> tag
  #<!-- User linuxtechi who can access only manager section -->
  #<role rolename="manager-gui" />
  #<user username="linuxtechi" password="<Enter-Secure-Password>" roles="manager-gui" />

  #<!-- User Admin Who can access manager and admin section both -->
  #<role rolename="admin-gui" />
  #<user username="admin" password="<Enter-Secure-Password>" roles="admin-gui" />

cd /opt/tomcat/bin/
sudo ./startup.sh

# Misc

