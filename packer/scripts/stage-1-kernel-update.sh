#!/bin/bash

cd ~

yum install -y http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm

yum update -y

yum install -y perl

# install Dev tools
yum groupinstall 'Development Tools' -y

# Required to install the kernel from source
yum install -y  openssl-devel elfutils-libelf-devel

# Install gcc 8.x for  install the kernel 5.x from source
yum install -y  centos-release-scl
yum install -y  devtoolset-8
source /opt/rh/devtoolset-8/enable

yum erase -y  kernel-devel* kernel-headers-3*  kernel-tools*

yum --enablerepo elrepo-kernel install -y  kernel-ml.x86_64 kernel-ml-devel.x86_64 kernel-ml-headers.x86_64 kernel-ml-tools.x86_64 kernel-ml-tools-libs.x86_64 kernel-ml-tools-libs-devel.x86_64

grub2-mkconfig -o /boot/grub2/grub.cfg && grub2-set-default 0

echo "Grub update done."
# Reboot VM
shutdown -r now
