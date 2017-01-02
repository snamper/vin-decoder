#!/bin/bash

role=`id -u`
if test $role -ne 0
then
    echo "运行脚本需要root权限"
    exit 1
fi

cat <<'EOF' > /etc/yum.repos.d/mongodb-org-3.0.repo
[mongodb-org-3.0]
name=MongoDB Repository
baseurl=http://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.0/x86_64/
gpgcheck=0
enabled=1
EOF

yum install -y supervisor.noarch
yum install -y mongodb-org

rpm --import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
yum -y install rabbitmq-server-3.6.6-1.noarch.rpm

yum -y install python-setuptools.noarch
yum -y install python-tornado.noarch
yum -y install python-requests.noarch
yum -y install supervisor.noarch

command -v wget || yum -y install wget || exit 1
command -v curl || yum -y install curl || exit 1
command -v netstat || yum -y install net-tools || exit 1
command -v lsof || yum -y install lsof || exit 1

easy_install pip
pip install pymongo
pip install beautifulsoup4
pip install pika
pip install ipy
pip install ipaddress
pip install pylint
