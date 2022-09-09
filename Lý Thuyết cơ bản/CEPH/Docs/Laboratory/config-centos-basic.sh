
# Cau hinh ve time zone cho he thong
yum install chrony -y 
systemctl start chronyd 
systemctl enable chronyd
chronyc sources -v 
timedatectl

hwclock --systohc

# cai dat epel-release
yum install epel-release -y

# cai dat cmd-log
curl -Lso- https://raw.githubusercontent.com/nhanhoadocs/scripts/master/Utilities/cmdlog.sh | bash

# tat Security linux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

# tat firewalld
sudo systemctl disable firewalld
sudo systemctl stop firewalld

# update he thong
yum update -y

# khoi dong lai
init 6
