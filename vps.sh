#! /bin/bash
# By BlueSkyXN
#https://github.com/BlueSkyXN/SKY-BOX

#彩色
red() {
	echo -e "\033[31m\033[01m$1\033[0m"
}
green() {
	echo -e "\033[32m\033[01m$1\033[0m"
}
yellow() {
	echo -e "\033[33m\033[01m$1\033[0m"
}
blue() {
	echo -e "\033[34m\033[01m$1\033[0m"
}

#IPV.SH ipv4/6优先级调整一键脚本·下载
function ipvsh() {
	wget -O "/root/ipv.sh" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/ipv.sh" --no-check-certificate -T 30 -t 5 -d
	chmod +x "/root/ipv.sh"
	chmod 777 "/root/ipv.sh"
	blue "下载完成"
	blue "输入 bash /root/ipv.sh 来运行"
}

#IPT.SH iptable一键脚本·下载
function iptsh() {
	wget -O "/root/ipt.sh" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/ipt.sh" --no-check-certificate -T 30 -t 5 -d
	chmod +x "/root/ipt.sh"
	chmod 777 "/root/ipt.sh"
	blue "下载完成"
	blue "输入 bash /root/ipt.sh 来运行"
}

#Speedtest for Linux·下载
function speedtest-linux() {
	wget -O "/root/speedtest" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/speedtest" --no-check-certificate -T 30 -t 5 -d
	chmod +x "/root/speedtest"
	chmod 777 "/root/speedtest"
	blue "下载完成"
	blue "输入 /root/speedtest 来运行"
}

#获取本机IP
function getip() {
	echo
	curl ip.p3terx.com
	echo
}

#启动BBR FQ算法
function bbrfq() {
	remove_bbr_lotserver
	echo "net.core.default_qdisc=fq" >>/etc/sysctl.conf
	echo "net.ipv4.tcp_congestion_control=bbr" >>/etc/sysctl.conf
	sysctl -p
	lsmod | grep bbr
	echo -e "BBR+FQ修改成功，重启生效！"
}

#系统网络配置优化
function system-best() {
	sed -i '/net.ipv4.tcp_retries2/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_slow_start_after_idle/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_fastopen/d' /etc/sysctl.conf
	sed -i '/fs.file-max/d' /etc/sysctl.conf
	sed -i '/fs.inotify.max_user_instances/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_syncookies/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_fin_timeout/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_tw_reuse/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_syn_backlog/d' /etc/sysctl.conf
	sed -i '/net.ipv4.ip_local_port_range/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_tw_buckets/d' /etc/sysctl.conf
	sed -i '/net.ipv4.route.gc_timeout/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_synack_retries/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_syn_retries/d' /etc/sysctl.conf
	sed -i '/net.core.somaxconn/d' /etc/sysctl.conf
	sed -i '/net.core.netdev_max_backlog/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_timestamps/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_orphans/d' /etc/sysctl.conf
	sed -i '/net.ipv4.ip_forward/d' /etc/sysctl.conf

	echo "net.ipv4.tcp_retries2 = 8
net.ipv4.tcp_slow_start_after_idle = 0
fs.file-max = 1000000
fs.inotify.max_user_instances = 8192
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_tw_reuse = 1
net.ipv4.ip_local_port_range = 1024 65000
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_max_tw_buckets = 6000
net.ipv4.route.gc_timeout = 100
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_synack_retries = 1
net.core.somaxconn = 32768
net.core.netdev_max_backlog = 32768
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_max_orphans = 32768
# forward ipv4
#net.ipv4.ip_forward = 1" >>/etc/sysctl.conf
	sysctl -p
	echo "*               soft    nofile           1000000
*               hard    nofile          1000000" >/etc/security/limits.conf
	echo "ulimit -SHn 1000000" >>/etc/profile
	read -p "需要重启VPS后，才能生效系统优化配置，是否现在重启 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "${Info} VPS 重启中..."
		reboot
	fi
}

#Besttrace 路由追踪·下载
function gettrace() {
	wget -O "/root/besttrace" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/besttrace" --no-check-certificate -T 30 -t 5 -d
	chmod +x "/root/besttrace"
	chmod 777 "/root/besttrace"
	blue "下载完成"
	blue "输入 /root/besttrace 来运行"
}


#三网Speedtest测速
function 3speed() {
	bash <(curl -Lso- https://raw.githubusercontent.com/BlueSkyXN/SpeedTestCN/main/superspeed.sh)
}

#Superbench 综合测试
function superbench() {
	wget -O "/root/superbench.sh" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/superbench.sh" --no-check-certificate -T 30 -t 5 -d
	chmod +x "/root/superbench.sh"
	chmod 777 "/root/superbench.sh"
	blue "下载完成"
	bash "/root/superbench.sh"
}

#Aria2 最强安装与管理脚本
function aria() {
	wget -O "/root/aria2.sh" "https://raw.githubusercontent.com/P3TERX/aria2.sh/master/aria2.sh" --no-check-certificate -T 30 -t 5 -d
	chmod +x "/root/aria2.sh"
	chmod 777 "/root/aria2.sh"
	blue "你也可以输入 bash /root/aria2.sh 来手动运行"
	blue "下载完成"
	bash "/root/aria2.sh"
}

#Rclone官方安装&开机自启动
function rc() {
	sudo apt install fuse3
	curl https://rclone.org/install.sh | sudo bash
	mkdir -p /root/downloads/origin /root/downloads/media
	cat >/etc/systemd/system/rclone.service <<EOF
[Unit]
Description=Rclone
After=network-online.target
[Service]
Type=simple
ExecStart=/usr/bin/rclone mount odchunk:/media /root/downloads/media \
--umask 000 --no-check-certificate --allow-other --allow-non-empty \
--transfers 1 --buffer-size 32M --low-level-retries 200 \
--vfs-cache-mode full --vfs-cache-max-age 12h --vfs-cache-max-size 5G --vfs-read-chunk-size 128M --vfs-read-chunk-size-limit 1G --dir-cache-time 12h \
--cache-dir=/root/cache \
--config /root/.config/rclone/rclone.conf
ExecStop=fusermount -qzu /root/downloads/media
Restart=on-abort
[Install]
WantedBy=multi-user.target
EOF
	cat >~/.config/rclone/rclone.conf <<EOF
[onedrive]
type = webdav
url = https://cqueducn0-my.sharepoint.com/personal/20126826_cqu_edu_cn/Documents
vendor = sharepoint
user = 20126826@cqu.edu.cn
pass = password

[odchunk]
type = chunker
remote = onedrive:
chunk_size = 1.990Gi
EOF
	systemctl enable rclone
	systemctl start rclone
}

#SWAP一键安装/卸载脚本
function swapsh() {
	wget -O "/root/swap.sh" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/swap.sh" --no-check-certificate -T 30 -t 5 -d
	chmod +x "/root/swap.sh"
	chmod 777 "/root/swap.sh"
	blue "下载完成"
	blue "你也可以输入 bash /root/swap.sh 来手动运行"
	bash "/root/swap.sh"
}

#Route-trace 路由追踪测试
function rtsh() {
	wget -O "/root/rt.sh" "https://raw.githubusercontent.com/BlueSkyXN/Route-trace/main/rt.sh" --no-check-certificate -T 30 -t 5 -d
	chmod +x "/root/rt.sh"
	chmod 777 "/root/rt.sh"
	blue "下载完成"
	blue "你也可以输入 bash /root/rt.sh 来手动运行"
	bash "/root/rt.sh"
}

#Disk Test 硬盘&系统综合测试
function disktestsh() {
	wget -O "/root/disktest.sh" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/disktest.sh" --no-check-certificate -T 30 -t 5 -d
	chmod +x "/root/disktest.sh"
	chmod 777 "/root/disktest.sh"
	blue "下载完成"
	bash "/root/disktest.sh"
}

#TubeCheck Google/Youtube CDN分配节点测试
function tubecheck() {
	wget -O "/root/TubeCheck" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/TubeCheck" --no-check-certificate -T 30 -t 5 -d
	chmod +x "/root/TubeCheck"
	chmod 777 "/root/TubeCheck"
	blue "下载完成"
	red "识别成无信息/NULL/未知等代表为默认的美国本土地区或者不可识别/无服务的中国大陆地区"
	"/root/TubeCheck"
}

#RegionRestrictionCheck 流媒体解锁测试
function RegionRestrictionCheck() {
	bash <(curl -L -s https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)
}

# DD 安装纯净 Debian11 系统，支持debian -d 9，10，11系统；ubuntu -u 20.04
function dd() {
	bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') -d 11 -v 64 -p "wasd"
}

# ssh login
function sshd() {
	sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
	sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/g' /etc/ssh/sshd_config
	sed -i 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
	sed -i 's/^#\?ClientAliveInterval.*/ClientAliveInterval 1/g' /etc/ssh/sshd_config
	sed -i 's/^#\?ClientAliveCountMax.*/ClientAliveCountMax 30/g' /etc/ssh/sshd_config
	systemctl restart sshd
}

# install docker & docker compose
function docker() {
	wget -qO- get.docker.com | bash
	tag = $(wget -qO- "https://api.github.com/repos/docker/compose/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')
	sudo curl -L "https://github.com/docker/compose/releases/download/${tag}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	docker compose version
	cat > /etc/docker/daemon.json <<EOF
{
	"log-driver": "json-file",
	"log-opts": {
		"max-size": "20m",
		"max-file": "3"
	},
	"ipv6": true,
	"fixed-cidr-v6": "fd00:dead:beef:c0::/80",
	"experimental":true,
	"ip6tables":true
}
EOF
	systemctl enable docker
	systemctl start docker
}

# install warf
function warf() {
	wget -N https://raw.githubusercontent.com/fscarmen/warp/main/menu.sh && bash menu.sh
}

# 数据备份
function backup() {
	cat >~/backup.sh <<EOF
tar -zcf ~/backup.tar.gz ~/docker
rclone sync backup.tar.gz onedrive:backup
rm ~/backup.tar.gz
EOF
	chmod +x backup.sh
 	echo “0 2 0 0 0 ～/backup.sh” >>/etc/crontab
}

#主菜单
function start_menu() {
	clear
	red "wget -O box.sh https://raw.githubusercontent.com/BlueSkyXN/SKY-BOX/main/box.sh && chmod +x box.sh && clear && ./box.sh "
	yellow " =================================================="
	green " 1. DD安装纯净Debian 11系统"
	green " 2. ssh登录&30min不活跃连接"
	green " 3. 启动BBR FQ算法"
	green " 4. SWAP一键安装/卸载脚本"
	green " 5. IPV.SH ipv4/6优先级调整一键脚本·下载"
	green " 6. IPT.SH iptable一键脚本"
	green " 7. 系统网络配置优化"
	green " 8. 获取本机IP"
	green " 9. warf安装"
	yellow " --------------------------------------------------"
	green " 11. 安装docker和docker compose"
	green " 12. Rclone官方安装&开启启动"
	green " 13. Aria2 最强安装与管理脚本"
	green " 14. NEZHA.SH哪吒面板/探针"
 	green " 15. 数据备份"
	yellow " --------------------------------------------------"
	green " 21. Superbench 综合测试"
	green " 22. UNIXbench 综合测试"
	green " 23. SpeedTest-Linux 下载"
	green " 24. 三网Speedtest测速"
	green " 25. Besttrace 路由追踪·下载"
	green " 26. Route-trace 路由追踪测试"
	green " 27.TubeCheck Google/Youtube CDN分配节点测试"
	green " 28. Memorytest 内存压力测试"
	green " 29. Disk Test 硬盘&系统综合测试"
	green " 30.RegionRestrictionCheck 流媒体解锁测试"
	yellow " =================================================="
	green " 0. 退出脚本"
	echo
	read -p "请输入数字:" menuNumberInput
	case "$menuNumberInput" in
	1)
		dd
		;;
	2)
		sshd
		;;
	3)
		bbrfq
		;;
	4)
		swapsh
		;;
	5)
		ipvsh
		;;
	6)
		iptsh
		;;
	7)
		system-best
		;;
	8)
		getip
		;;
	9)
		warf
		;;
	11)
		docker
		;;
	12)
		rc
		;;
	13)
		aria
		;;
	14)
		nezha
		;;
	15)
		backup
		;;
	21)
		superbench
		;;
	22)
		UNIXbench
		;;
	23)
		speedtest-linux
		;;
	24)
		3speed
		;;
	25)
		gettrace
		;;
	26)
		rtsh
		;;
	27)
		tubecheck
		;;
	28)
		memorytest
		;;
	29)
		disktestsh
		;;
	30)
		RegionRestrictionCheck
		;;
	0)
		exit 1
		;;
	*)
		clear
		red "请输入正确数字 !"
		start_menu
		;;
	esac
}
start_menu "first"
