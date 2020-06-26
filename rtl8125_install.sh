# /bin/bash
# This script is automaticlly complie RTL8125 2.5G ethernet card driver for PVE
# date 2020/4/25 22:35 UTC +8:00

# Check rtl8125 kernel modules exist it 【检查驱动是否加载】
check=`lsmod | grep rtl8152`
if [ "$check" != "" ]; then
	echo 'RTL8125 driver has been Installed! [恭喜！当前网卡驱动已加载！]'
	exit 0
fi
# Get Proxmox VE kernel version 【获取PVE内核版本】

PVE_kernel_version=`uname -r`
uname -r > /tmp/PVE_kernel_version.log
check=`grep "pve" /tmp/PVE_kernel_version.log`

if [ "${check}" != "" ]; then
        echo "Check is OK!\n [检测通过........]\n"
        rm /tmp/PVE_kernel_version.log
else
        echo "Sorry, your system is not supported it, please run it on Proxmox VE 3.0-6.0. \n[抱歉，您的系统不被支持，请在 PVE 3.0-6.0 下使用。]\n"
        exit -1
fi


pve_kernel_headers_version=pve-headers-${PVE_kernel_version}

# Get PVE Full version 【获取当前PVE完整版本】
PVE_Full_version=`pveversion`
# Get PVE Main version 【获取当前PVE主版本，添加软件仓库源会用到】
${PVE_full_version:12:1}

# Add no subcript source 【添加非订阅用户源】
# NOT recommended for production use 【不建议生产环境中使用】
# PVE pve-no-subscription repository provided by proxmox.com 【非订阅用户软件仓库由proxmox.com提供】


if [ "$PVE_main_version" == "6" ]; then
	# add PVE 6.0 no subcript to apt source.list
	deb http://download.proxmox.com/debian/pve buster pve-no-subscription
elif [ "$PVE_main_version" == "5" ]; then
	# add PVE 5.0 no subcript to apt source.list
	deb http://download.proxmox.com/debian stretch pve-no-subscription
elif [ "$PVE_main_version" == "4" ]; then
	# add PVE 4.0 no subcript to apt source.list
	deb http://download.proxmox.com/debian jessie pve-no-subscription
elif [ "$PVE_main_version" == "3" ]; then
	# add PVE 3.0 no subcript to apt source.list
	deb http://download.proxmox.com/debian wheezy pve-no-subscription
else 
	echo 'Sorry, your system is not supported it. [对不起，这个脚本暂时不支持您的系统。]'
	exit 0
fi


apt-get update
# Install dependent packages 【安装依赖包】
apt-get install ${pve_kernel_headers_version} dkms build-essential 


tar -xvf $PWD/r8125-9.003.04.tar
cd r8125-9.003.04

chmod a+x autorun.sh
./autorun.sh

if [ lsmod | grep 'rtl8152' != "" ]; then
	echo 'RTL8125 driver has been Installed! [恭喜！网卡驱动已加载！]'
	exit 0
elif 
	echo 'Please confirm has installed RTL8125 2.5G PCIE　ethernet card on your mainboard.  [请确认安装好了Rlt 8125网卡在主板PCIE卡槽上。]'
	exit -1
fi
