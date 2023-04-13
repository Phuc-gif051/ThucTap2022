# cai dat OVS phien ban 2.17 tren CentOS 7

Cai dat python3

```sh
yum update -y
yum install python3 gcc-c++ python3-devel -y
```

Cai dat cac goi can thiet

```sh
yum -y install wget openssl-devel gcc make python-devel openssl-devel kernel-devel graphviz kernel-debug-devel autoconf automake rpm-build redhat-rpm-config libtool python-twisted-core python-zope-interface PyQt4 desktop-file-utils libcap-ng-devel groff checkpolicy selinux-policy-devel
```

_Buoc nay se hoi lau_

Tao 1 user moi de luu tru cac goi can thiet cua OVS

```sh
adduser ovs
su - ovs
```

_tao 1 thu muc -> tai goi openvswitch -> copy sang thu muc moi tao:_

```sh
mkdir -p ~/rpmbuild/SOURCES
wget https://www.openvswitch.org/releases/openvswitch-2.17.5.tar.gz
cp openvswitch-2.17.5.tar.gz ~/rpmbuild/SOURCES
```

_tien hanh giai nen -> roi build:_

```sh
tar xfz openvswitch-2.17.5.tar.gz
rpmbuild -bb --without check openvswitch-2.17.5/rhel/openvswitch-fedora.spec
```

Yeu cau cai dat them 3 goi bo sung. Thuong khi check neu thieu bat ky goi nao ta se nhan duoc thong bao va tien hanh cai dat bo sung theo yeu cau

```sh
[ovs@client ~]$ rpmbuild -bb --without check openvswitch-2.17.5/rhel/openvswitch-fedora.spec
error: Failed build dependencies:
        /usr/bin/sphinx-build-3 is needed by openvswitch-2.17.5-1.el7.x86_64
        unbound is needed by openvswitch-2.17.5-1.el7.x86_64
        unbound-devel is needed by openvswitch-2.17.5-1.el7.x86_64
[ovs@client ~]$
```

Cai dat bo sung

```sh
yum install -y unbound unbound-devel python3-sphinx
```

_Cai dat xong hay tien hanh build lai. Build cung hoi lau, build xong se duoc export ra 1 list cac phien co the cai dat, uu tien cai dat 2 phien dau tien. Hay luu lai duong dan cac phien de cai dat them khi can._

```sh
Checking for unpackaged file(s): /usr/lib/rpm/check-files /home/ovs/rpmbuild/BUILDROOT/openvswitch-2.17.5-1.el7.x86_64
Wrote: /home/ovs/rpmbuild/RPMS/x86_64/openvswitch-2.17.5-1.el7.x86_64.rpm
Wrote: /home/ovs/rpmbuild/RPMS/noarch/openvswitch-selinux-policy-2.17.5-1.el7.noarch.rpm
Wrote: /home/ovs/rpmbuild/RPMS/noarch/python3-openvswitch-2.17.5-1.el7.noarch.rpm
Wrote: /home/ovs/rpmbuild/RPMS/noarch/openvswitch-test-2.17.5-1.el7.noarch.rpm
Wrote: /home/ovs/rpmbuild/RPMS/x86_64/openvswitch-devel-2.17.5-1.el7.x86_64.rpm
Wrote: /home/ovs/rpmbuild/RPMS/x86_64/openvswitch-ipsec-2.17.5-1.el7.x86_64.rpm
Wrote: /home/ovs/rpmbuild/RPMS/x86_64/openvswitch-debuginfo-2.17.5-1.el7.x86_64.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.bxkCwx
+ umask 022
+ cd /home/ovs/rpmbuild/BUILD
+ cd openvswitch-2.17.5
+ rm -rf /home/ovs/rpmbuild/BUILDROOT/openvswitch-2.17.5-1.el7.x86_64
+ exit 0
```

Tien hanh cai dat, su dung tai khoan `root` hoac tai khoan co quyen `root`

```sh
exit
yum localinstall -y /home/ovs/rpmbuild/RPMS/x86_64/openvswitch-2.17.5-1.el7.x86_64.rpm
```

Kiem tra va khoi dong

```sh
systemctl start openvswitch.service
systemctl is-active openvswitch
systemctl enable openvswitch
ovs-vsctl -V
```

## Tai lieu tham khao

<https://gist.github.com/umardx/a31bf6a13600a55c0d07d4ca33133834>

<https://docs.openvswitch.org/en/latest/intro/install/fedora/>

<https://patchwork.ozlabs.org/project/openvswitch/patch/1570830554-9336-1-git-send-email-pkusunyifeng@gmail.com/>



