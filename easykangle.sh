#��װ��kangleĬ�ϰ�װ��Ŀ¼��/vhs/kangle
#---------------------------------begin install-----------------------------------------
#!/bin/bash
echo ��ʼ��װ
#ִ��yumԴ��������
echo ��������Դ
wget http://mirrors.aliyun.com/repo/Centos-7.repo
mv Centos-7.repo CentOS-Base.repo
yum clean all 
yum makecache 
yum update 
echo �����ɹ�
#��װ���п�
echo ���ڰ�װ���п�
yum -y install wget tar make automake gcc gcc-c++ pcre pcre-devel zlib-devel sqlite-devel openssl-devel libxml2 libxml2-devel libtool libtool-libs quota perl gd
echo �ɹ�
echo ���ڰ�װkangle
#����kangle
wget https://download.kangleweb.com/src/kangle-3.4.8.tar.gz
#��ѹkangle
tar xzf kangle-3.4.8.tar.gz
cd kangle-3.4.8
./configure �Cprefix=/vhs/kangle �Cenable-disk-cache �Cenable-ipv6 �Cenable-ssl �Cenable-vh-limit
make && make check && make install
cd /usr/lib/systemd/system/
touch kangle.service
[Unit]
Description=Kangle Web Service
After=syslog.target network.target
[Service]
Type=forking
ExecStart=/vhs/kangle/bin/kangle
ExecStop=/vhs/kangle/bin/kangle -q
[Install]
WantedBy=multi-user.target
:wq
cd 
ln -s ��/usr/lib/systemd/system/kangle.service�� ��/etc/systemd/system/multi-user.target.wants/kangle.service��
systemctl start kangle.service
systemctl enable kangle.service
yum install mariadb-server mariadb
systemctl start mariadb.service
echo �ɹ�
yum install php php-cli php-mysql php-gd php-xml php-pdo php-mbsring
echo ��װphp�ɹ�
wget http://download.pureftpd.org/pub/pure-ftpd/releases/pure-ftpd-1.0.42.tar.gz
tar xzf pure-ftpd-1.0.42.tar.gz
./configure �Cprefix=/vhs/pure-ftpd with �Cwith-extauth �Cwith-throttling �Cwith-peruserlimits
make && make check && make install
cd /vhs/pure-ftpd/sbin
touch pureftpd.service
vi pureftpd.service
[Unit]
Description=Pure-FTPd FTP Server
After=syslog.target
[Service]
Type=forking
ExecStart=/usr/bin/sh /vhs/pure-ftpd/sbin/pureftpd.sh
[Install]
WantedBy=multi-user.target
:wq
ln -s ��/usr/lib/systemd/system/pureftpd.service�� ��/etc/systemd/system/multi-user.target.wants/pureftpd.service��
systemctl start pureftpd.service
cd ..
cd
echo Pure-FTPd FTP Server ��װ�ɹ�
wget http://github.itzmx.com/1265578519/kangle/master/kangle/easypanel/ep.sh -O ep.sh;sh ep.sh
systemctl start kangle.service
systemctl start pureftpd.service
echo ��ɣ�
-------------------end---------------------------------------------------