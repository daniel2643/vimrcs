#########################################################################
# File Name: scp.sh
# Author: Daniel Gao
# mail: seraphdg@gmail.com
# Created Time: Thu Dec  3 18:19:54 2020
#########################################################################
#!/bin/bash
#cat .ssh/id_rsa.pub | ssh ec2-user@18.163.103.66 'cat >> .ssh/authorized_keys'

#host="ec2-user@18.163.103.66"
#declare -a files=(".vimrc" ".bashrc" ".bash_profile" ".gitconfig")
#for file in ${arr[@]}
#do
  #scp -r file host
#done

scp -r ~/.vimrc ec2-user@18.163.103.66:~/
scp -r ~/.bashrc ec2-user@18.163.103.66:~/
scp -r ~/.bash_profile ec2-user@18.163.103.66:~/
scp -r ~/.gitconfig ec2-user@18.163.103.66:~/

scp -r install.sh ec2-user@18.163.103.66:~/
scp -r ssserver.service ec2-user@18.163.103.66:~/
scp -r config.json ec2-user@18.163.103.66:~/

