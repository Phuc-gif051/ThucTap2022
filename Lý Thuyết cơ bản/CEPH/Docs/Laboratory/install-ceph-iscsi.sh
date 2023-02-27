#link tu ceph docs: https://docs.ceph.com/en/latest/rbd/iscsi-target-cli-manual-install/

#link youtube: https://www.youtube.com/watch?v=Qx6lxotzI0k

yum install -y libnl3 libkmod librbd1 pyparsing python3-kmod python3-pyudev python3-gobject python3-urwid python3-rados python3-rbd python3-netifaces python3-crypto python3-requests python3-flask pyOpenSSL
yum install python3-devel openssl-devel libffi-devel -y
pip3 install pyOpenSSL

# install groups Development Tools

yum groups mark install "Development Tools"
yum groups mark convert "Development Tools"
yum groupinstall "Development Tools"

# Nen chuyen sang python3 de cai dat cac buoc ben duoi

# TCMU-RUNNER
cd 
git clone https://github.com/open-iscsi/tcmu-runner
cd tcmu-runner
./extra/install_dep.sh
cmake -Dwith-glfs=false -Dwith-qcow=false -DSUPPORT_SYSTEMD=ON -DCMAKE_INSTALL_PREFIX=/usr
make install
systemctl daemon-reload
systemctl enable tcmu-runner
systemctl start tcmu-runner

# RTSLIB-FB

cd
git clone https://github.com/open-iscsi/rtslib-fb.git
cd rtslib-fb
python3 setup.py install

# CONFIGSHELL-FB

cd
git clone https://github.com/open-iscsi/configshell-fb.git
cd configshell-fb
python3 setup.py install

# TARGETCLI-FB

cd
git clone https://github.com/open-iscsi/targetcli-fb.git
cd targetcli-fb
python3 setup.py install
mkdir /etc/target
mkdir /var/target

# CEPH-ISCSI

cd
git clone https://github.com/ceph/ceph-iscsi.git
cd ceph-iscsi
python3 setup.py install --install-scripts=/usr/bin
cp usr/lib/systemd/system/rbd-target-gw.service /lib/systemd/system
cp usr/lib/systemd/system/rbd-target-api.service /lib/systemd/system
pip3 install -r requirements.txt

systemctl daemon-reload
systemctl enable rbd-target-gw
systemctl start rbd-target-gw
ceph dashboard set-iscsi-api-ssl-verification false
systemctl enable rbd-target-api
systemctl start rbd-target-api