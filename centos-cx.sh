#!/bin/bash

sudo echo "http_proxy=\"http://172.16.1.5:8080\"" >> /etc/environment
sudo echo "https_proxy=\"http://172.16.1.5:8080\"" >> /etc/environment
sudo echo "no_proxy=\"localhost,127.0.0.1,*.lab\"" >> /etc/environment

sudo source /etc/environment
source /etc/environment

export http_proxy="http://172.16.1.5:8080"
export https_proxy="http://172.16.1.5:8080"

sudo yum upgrade ca-certificates -y
sudo yum install perl fuse-libs -y

sudo yum install -y epel-release
sudo yum -y install git wget ntp curl cloud-init dracut-modules-growroot cloud-utils-growpart open-vm-tools
sudo bash -c 'rpm -qa kernel | sed 's/^kernel-//'  | xargs -I {} dracut -f /boot/initramfs-{}.img {}'

sudo sed -i -e 's/quiet/quiet net.ifnames=0 biosdevname=0/' /etc/default/grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

sudo bash -c 'echo NM_CONTROLLED=\"no\" >> /etc/sysconfig/network-scripts/ifcfg-eth0'
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sudo setenforce 0
