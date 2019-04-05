#安装在kangle默认安装的目录：/vhs/kangle
#---------------------------------begin install-----------------------------------------
#!/bin/bash

cur_dir=$(pwd)
wget http://file.kangle.odata.cc/file/completed/kangle-ent-3.5.13.13-6-x64.tar.gz
tar zxvf kangle-ent-3.5.13.13-6-x64.tar.gz
cd kangle
./install.sh /vhs/kangle
cd ../

cd $cur_dir
rm -rf kangle

#导入license，否则程序无法启动。
cat>>/vhs/kangle/license.txt<2
H4sIAAAAAAAAA5Pv5mAAA2bGdoaK//Jw
Lu+hg1yHDHgYLlTbuc1alnutmV304sXT
Jfe6r4W4L3wl0/x376d5VzyPfbeoYd1T
GuZq4nFGinMhz1fGFZVL/wmITGireLB4
dsnsMtVt859fOlutf/eR/1/vm0rGM3KO
ckbtTN504maK75GUSTt31uQK/FrltCPn
cOXlNfU+V5nf1gFtX1iQa9IOpAGFLYQh
ngAAAA==
EOF

#修改path环境，可以直接使用kangle来执行
echo 'export PATH=$PATH:/vhs/kangle/bin/' >>/etc/profile
source /etc/profile

#设置firewalld防火墙，打开80及kangle管理端口
systemctl start firewalld.service
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --permanent --zone=public --add-port=3311/tcp
firewall-cmd --reload

#把kangle加入自启动
echo '/vhs/kangle/bin/kangle' >>/etc/rc.local
chmod +x /etc/rc.local
/vhs/kangle/bin/kangle
#--------------------------------------------------end---------------------------------------------------
