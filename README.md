
        来源于tubaxiaosiji的脚本修改为适用于USB版本rtl8152（8156）的驱动,修改了驱动包及编译安装命令   



基于debian的发行版本可以尝试运行一下，因为不同发行版本的软件源仓库可能不太一样，不一定有匹配的内核image和内核Headers，这个得靠各位去尝试了。
如果你的系统是PVE系统的话，直接无脑下一步就行了。                                   


	注意[Notice]:           
Get superuser permission 【最好请使用root用户编译】  

Add no subcript source 【添加非订阅用户源】

NOT recommended for production use 【不建议生产环境中使用】   

PVE pve-no-subscription repository provided by proxmox.com 【非订阅用户软件仓库由proxmox.com提供】

Support Proxmox VE 5.0-6.0 (include 6.2.x) 【支持PVE 5.0-6.0 系统，包括6.2.x 】  

r8152.53.56-2.14.0.bz2 provided by Realtek.com 【r8152.53.56-2.14.0.bz2由Realtek官网提供】

Support Linux kernel version 2.4 to 5.6   【支持的Linux内核版本，从2.4到5.6】
    
	root@hostname# 这个是命令提示符， "#" 井号后面的才是SHELL命令
                		
1.食用方法如下 [Usage] :  
		

2.安装git和它的依赖组件  [Install git and dependent packages] 

	root@hostname# apt-get update     
	root@hostname# apt-get -y install git

3.克隆我的仓库  [Clone my .git]

	root@hostname# git clone https://github.com/virtrue/RTL8152-8156--Driver-for-Proxmox-VE5-6-and-debian.git  

4.切换到目录	  [Change dir]   

	root@hostname# cd ./RTL8152-8156--Driver-for-Proxmox-VE5-6-and-debian  

5.赋予运行权限   [Chmod]   

	root@hostname# chmod a+x rtl8152_install.sh  

6.运行脚本    [Run script in shell]   

	root@hostname# bash rtl8152_install.sh  

7.等待一会   [Wait for a minutes]...  



8.检查模块是否已安装加载   [Check kernel module is exist it]   

	root@hostname# lsmod | grep 'r8152'   	
	出现 r8152字样即安装成功   [If show 'r8152' that is OK!]
	
	
9.如果出现  modprobe: ERROR: could not insert r8152: Invalid argument，请重启系统再运行一遍脚本即可。
		
[If show modprobe: ERROR: could not insert r8152: Invalid argument appears, please restart the system and run the script again.]        		
	
