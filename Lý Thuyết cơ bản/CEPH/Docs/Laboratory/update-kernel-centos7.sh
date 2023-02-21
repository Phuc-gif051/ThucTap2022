echo "Add repo for kernel"

rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh https://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm

echo "List off kernel wating 5s..."
yum list available --disablerepo='*' --enablerepo=elrepo-kernel
sleep 5s

yum --enablerepo=elrepo-kernel install kernel-lt
echo "Completed!!! Reboot after 5 seconds…"
reboot

