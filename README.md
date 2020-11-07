# 目錄

* * * 
~
*   [資料科技平台](#technology)
    *   [系統架構圖](#composition)

*   [部署](#deploy)
    *   [系統與環境安裝](#install)
    *   [使用 dt 程式部署 Hadoop](#dt)
    *   [開啟 Hadoop](#Hadoop)
    
    
* * * 

<h1 id="technology">資料科技平台</h1> 

<h2 id="composition">系統架構圖</h2>

![composition](https://github.com/Oscar-Young/DT-alpine/blob/master/doc/picture/1603965913790.jpg)

* * *

<h1 id="deploy">部署</h1> 

<h2 id="install">系統與環境安裝</h2>

### 以下程式皆在 gw 內使用

* 修改 /etc/hosts ，請設定好自己的 IP，以下參考

> sudo nano /etc/hosts

```
127.0.0.1 localhost
192.168.XXX.XXX gw
192.168.XXX.XXX mas01
192.168.XXX.XXX wka01
192.168.XXX.XXX wka02
192.168.XXX.XXX wka03
192.168.XXX.XXX wka04
192.168.XXX.XXX ds01
```

* * * 

* 產生 SSH 公私鑰

> ssh-keygen -t rsa -P '' 

* 複製公鑰至各台電腦

> ssh-copy-id Name@Hosts

>> ` ssh-copy-id bigred@192.168.XXX.XXX `

* * * 

* 下載 GitHub 資料

> git clone 'https://github.com/Oscar-Young/DT-alpine'

* 檢查是否有下載到本地

> ls -al

* 修改 DT-alpine/web/config/hosts，請設定好自己的 IP，以下參考

> nano DT-alpine/web/config/hosts

```
127.0.0.1 localhost
192.168.XXX.XXX gw
192.168.XXX.XXX mas01
192.168.XXX.XXX wka01
192.168.XXX.XXX wka02
192.168.XXX.XXX wka03
192.168.XXX.XXX wka04
192.168.XXX.XXX ds01
```

* * *

* 將此檔加入環境變數，請設定自己資料夾的路徑，以下參考

> nano .bashrc

```bash
export PATH=/home/username/DT-alpine/bin:$PATH
export DT_HOME=~/DT-alpine
```

* * *

> source .bashrc

* 修改 dt 環境變數，請設定好自己的 IP 還有資料夾路徑，以下參考

> nano DT-alpine/conf/dt-env.sh

```bash
#!/bin/bash
export DT_HOME="/home/username/DT-alpine"
export WEB_HOST="192.168.XXX.XXX"
export WEB_PORT="8888"
export WEB_URL=$WEB_HOST:$WEB_PORT
```

> source DT-alpine/conf/dt-env.sh

* * * 

<h2 id="dt"> 使用 dt 程式部署 Hadoop </h2>

* 將 dt 的執行權限打開

> sudo chmod +x DT-alpine/bin/dt

* * *

* 查看所有機器的硬體規格、IP、Gateway、Openjdk 版本

> dt sysinfo

```
[wka01]
--------------------------------------------------------
CPU :  Intel(R) Atom(TM) x5-Z8350 CPU @ 1.44GHz (core: 4)
Memory : 3.3G
IP Address : addr:192.168.XXX.XXX
Default Gateway : 192.168.XXX.XXX

openjdk version "1.8.0_252"
OpenJDK Runtime Environment (IcedTea 3.16.0) (Alpine 8.252.09-r0)
OpenJDK 64-Bit Server VM (build 25.252-b09, mixed mode)
```

* * * 

* 更新套件、安裝 Openjdk8、allows users to present environment options to the ssh daemon

> dt sysprep

```
Loading DT environment... OK
Web Server is already start : 192.168.XXX.XXX:XXXX
[wka01]
Add apk repositories... OK
Update apk repositories... OK
Install openjdk-1.8-jdk... OK
Setting SSH environment... OK
```

* * *

* 將 gdriverdown 的執行權限打開

> sudo chmod +x gdriverdown

* * * 

* 安裝 hadoop-2.10.1、pig-0.17.0、hive-2.3.7、tez-0.9.2，複製環境變數文件、hadoop、pig、tez 配置文件

> dt build

```
Loading DT environment...OK
Web Server is already start : 192.168.XXX.XXX:XXXX
download Aapche Hadoop-2.10.1...Please Wait
Hadoop-2.10.1 OK
download Aapche pig-0.17.0...Please Wait
pig-0.17.0 OK
download Aapche hive-2.3.7...Please Wait
hive-2.3.7 OK
download Aapche tez-0.9.2...Please Wait
tez-0.9.2 OK
[wka01]
Hadoop is already exists
Install Pig... OK
Hive is already exists
Tez is already exists
environment copied
hosts copied
core-site.xml copied
hdfs-site.xml copied
mapred-site.xml copied
yarn-site.xml copied
tez-site.xml copied
```

* * * 

<h2 id="Hadoop">開啟 Hadoop</h2> 

* 初始化 hdfs

> formatdfs

`Are you sure ? (YES/NO) YES`

```
wka01 clean
wka02 clean
wka03 clean
wka04 clean
formathdfs ok
```

* * *

* 停止 namenode、secondarynamenode、datanode

> stophdfs

```
wka01 stop datanode...OK
wka02 stop datanode...OK
wka03 stop datanode...OK
wka04 stop datanode...OK
mas01 stop secondarynamenode...OK
mas01 stop namenode...OK
```

* * * 

* 停止 resourcemanager、nodemanager、historyserver

> stopyarn

```
wka01 stop nodemanager...OK
wka02 stop nodemanager...OK
wka03 stop nodemanager...OK
wka04 stop nodemanager...OK
mas01 stop resourcemanager...OK
mas01 stop historyserver...OK
```

* * * 

* 啟動 namenode、secondarynamenode、datanode

> starthdfs

```
mas01 start namenode...OK
mas01 start secondarynamenode...OK
wka01 start datanode...OK
wka02 start datanode...OK
wka03 start datanode...OK
wka04 start datanode...OK
```

* * *

* 啟動 resourcemanager、nodemanager、historyserver

> startyarn

```
mas01 start resourcemanager...OK
mas01 start historyserver...OK
wka01 start nodemanager...OK
wka02 start nodemanager...OK
wka03 start nodemanager...OK
wka04 start nodemanager...OK
```

* * * 

* 將 tez 檔案複製到 hdfs

> buildtez

```
delete /apps/tez OK
create /apps/tez OK
put apache-tez-0.9.2-bin  OK
```

* * *

* 修改 userlist，設定之後要創建的 user 帳號，以下參考

> nano DT-alpine/conf/userlist

```bash
user01	user01
user02	user02
```

* * *

* 創建 user 帳號，Hive 初始化 schema，將 Hive 執行引擎配置文件下載至創建好的 user 中

> dt.adduser

```
Loading DT environment...OK
--- gw ---
user01 Create user01
user02 Create user02
---ds01---
user01 Create user01
user02 Create user01
---hdfs---
Create user01 HDFS home...OK
Create user02 HDFS home...OK
Init user01 derby...OK
Init user02 derby...OK
Add user01 .hiverc...OK
Add user02 .hiverc...OK
```

* * *

* 刪除 user 帳號

> dt.deluser

```
Loading DT environment...OK
--- gw ---
user01...del
user02...del
---ds01---
user01...del
user02...del
```

* * *
