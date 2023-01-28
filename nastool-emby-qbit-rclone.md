# 安装基础服务
```
sudo apt update && upgrade
sudo apt install unzip gpg fuse curl nano
```
# rclone的安装与配置
首先rclone config部分，OneDrive请参考这个教程1-4点，谷歌盘请参考这个教程的1-2点，阿里云盘比较麻烦，而且我们买国外服务器也不是很适合这个，方法是通过alist挂载为webdav，请参考https://alist.nn.ci/zh/guide/的内容挂载alist，以及rclone挂载webdav的教程。
```
# 安装
curl https://rclone.org/install.sh | sudo bash

# 配置remote：运行一下命令根据提示完成配置；如果在其他服务器配置过也可以将配置文件直接复制过来用，配置文件在/root/.config/rclone/rclone.conf
rclone config

# 创建下载和挂载文件夹，下载文件夹是qbit现在下来未经处理过的文件，挂载文件夹是emby的媒体库文件夹
mkdir -p /root/downloads/origin /root/downloads/media

# 编写rclone挂载的开机启动服务脚本。本文将remote网盘命令为NASTOOL，并挂载remote的media文件夹到local的/root/downlads/media文件夹，可根据需要自己替换挂载文件夹的地址
cat > /etc/systemd/system/rclone.service <<EOF
[Unit]
Description=Rclone
After=network.target
[Service]
Type=simple
ExecStart=/usr/bin/rclone mount NASTOOL:/media /root/downloads/media --use-mmap --umask 000 --default-permissions --file-perms 0777 --dir-perms 0777 --no-check-certificate --allow-other --allow-non-empty --dir-cache-time 15m --cache-dir=/root/cache --vfs-cache-mode full --buffer-size 200M --vfs-read-ahead 512M --vfs-read-chunk-size 32M --vfs-read-chunk-size-limit 320M --vfs-cache-max-size 10G --low-level-retries 200 --config /root/.config/rclone/rclone.conf
[Install]
WantedBy=multi-user.target
EOF

# 设置开机启动
systemctl enable rclone

# 运行服务挂载网盘
systemctl start rclone

# 其他可能会用到的命令
fusermount -qzu /root/downloads/media	# 取消挂载
df -h	# 查看是否挂载成功
du -h --max-depth=1 /root/downloads/ # 查看一级目录的空间使用量
```


# docker的安装
以ubuntu举例，其他系统可查看[官网安装方式](https://docs.docker.com/engine/install/ubuntu/ "官网安装方式")
```
# 删除旧版本
sudo apt remove docker docker-engine docker.io containerd runc

# 安装新版本
sudo apt install ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose

# 设置开机启动
sudo systemctl enable docker
sudo systemctl start docker
```
# nastool、emby、qBittorrent的安装与配置
```
# 创建docker文件夹
mkdir -p /root/docker/emby /root/docker/nastools /root/docker/qBittorrent

cd /root/docker

# 在/root/docker文件夹内上传docker-compose.yml文件，文件内容如下
version: "3"
services:
  nastools:
    network_mode: host
    image: jxxghp/nas-tools:latest
    container_name: nastools
    hostname: nastools
    volumes:
      - /root/docker/nastools/config:/config   # 冒号左边请修改为你想保存配置的路径
      - /root/downloads:/downloads
      - /root/.config/rclone:/root/.config/rclone
    environment:
      - PUID=0
      - PGID=0
      - TZ=Asia/Shanghai
      - UMASK=022 # 掩码权限，默认000，可以考虑设置为022
     #- REPO_URL=https://ghproxy.com/https://github.com/jxxghp/nas-tools.git  # 访问github困难的用户，可以取消本行注释，用以加速访问github
    restart: always 
  
  emby:
    image: lovechen/embyserver:latest
    container_name: emby
    network_mode: host
    environment:
      - PUID=0
      - PGID=0
    volumes:
      - /root/docker/emby/config:/config
      - /root/downloads/media:/media
    restart: unless-stopped
 
 qBittorrent:
    network_mode: host
    image: linuxserver/qbittorrent:latest
    container_name: qbittorrent
    environment:
      - PUID=0
      - PGID=0
      - TZ=Asia/Shanghai
      - UMASK_SET=022
      - WEBUI_PORT=8080 
    volumes:
      - /root/docker/qBittorrent/config:/config # 左侧路径修改为自己本地的config文件夹
      - /root/downloads/origin:/downloads # 左侧路径请修改为自己的downloads文件夹
    restart: unless-stopped

# 启动/重启服务，命令必须在yml同目录内运行
docker-compose up -d

# 其他可能会用到的命令
docker-compose logs nastools	# 查看nastools container的日志
docker-compose ps	# 查看容器状态
docker container ls    # 查看容器状态
docker-compsoe stop	# 停止
docker-compsoe rm	# 删除

```

- emby：ip:8096，
创建API
媒体库：在/movie文件夹内，按需配置，建议使用tmdb的刮削，带中文。刮削教程可以参考这个视频
用户配置：重要！用VPS的朋友请在每个用户配置时关掉所有带有转码、转换字眼的设置项，服务器的配置并不足以进行软解，开了转码会使得看视频的时候cpu高占用而卡顿的。

- qBittorrent: ip:8080 admin adminadmin

- nastools: ip:3000 admin password
**设置-基础设置**：tmdb api申请与填写；关闭下载软件监控（下载软件监控与目录同步方式转移二选一，我们使用目录同步方式）
进入后配置下载器、媒体库、媒体服务器、基础设置-TMDB的API
**设置-媒体库**：配置 电影 dowloads/media/tv；电视剧  dowloads/media/tv；未识别 dowloads/media/unknown
**设置-索引器**：选自带的rarbg、动漫花园
**设置-下载器**：配置你的qbit，ip端口账号密码，测试是否可用
**设置-媒体服务器**：填写emby地址和api（api在emby设置里面有个选项，生成一个来用）
消息通知、豆瓣、字幕等请去nastool频道搜索或者问人，挺简单的。

然后如果你有pt站，请在站点管理-站点维护处添加。站点管理处也添加一下公开站点的rss，例如蜜柑的https://mikanani.me/RSS/Classic  。如果是公开站点，用途选订阅即可。

当有新的番剧更新，Nastool将会自动下载并转移到你的网盘对应目录并且提醒emby刷新媒体库，rclone会自动上传，这也就是我们的自动订阅全流程了~
