# 資料科技平台 系統架構圖

![composition](https://github.com/Oscar-Young/DT-alpine/blob/master/doc/picture/1603965913790.jpg)

## 環境安裝及系統部署

### 以下程式皆在gw內使用

* 產生 SSH 公私鑰

`ssh-keygen -t rsa -P `

* 複製公鑰至各台電腦

`ssh-copy-id Name@Hosts`

`ssh-copy-id bigred@192.168.XXX.XXX`

* 下載github資料

`git clone 'https://github.com/Oscar-Young/DT-alpine'`

* 將此檔加入環境變數，請設定自己資料夾的路徑，以下參考

>`nano .bashrc `

```bash
export PATH=/home/username/DT-alpine/bin:$PATH
export DT_HOME=~/DT-alpine
```

* 修改hosts，請設定好自己的IP，以下參考

>`nano DT-alpine/web/config/hosts`

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

* 修改dt環境變數，請設定好自己的IP還有資料夾路徑，以下參考

>`nano DT-alpine/conf/dt-env.sh`

```bash
#!/bin/bash
export DT_HOME="/home/username/DT-alpine"
export WEB_HOST="192.168.XXX.XXX"
export WEB_PORT="8888"
export WEB_URL=$WEB_HOST:$WEB_PORT
```

## 使用dt程式部署hadoop

*查看所有機器的硬體規格、IP、Gateway、Openjdk版本
>`dt sysinfo`

執行結果:

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
*更新套件、安裝Openjdk8、allows users to present environment options to the ssh daemon
>`dt sysprep`

執行結果:

```
Loading DT environment... OK
Web Server is already start : 192.168.XXX.XXX:XXXX
[wka01]
Add apk repositories... OK
Update apk repositories... OK
Install openjdk-1.8-jdk... OK
Setting SSH environment... OK
```

*安裝Hadoop、Pig、Hive、Tez，複製環境變數文件、Hadoop、Pig、Tez配置文件
>`dt build`

執行結果:

```
Loading DT environment... OK
Web Server is already start : 192.168.XXX.XXX:XXXX
[wka01]
Install Hadoop... OK
Install Pig... OK
Install Hive... OK
Install Tez... OK
environment copied
hosts copied
core-site.xml copied
hdfs-site.xml copied
mapred-site.xml copied
yarn-site.xml copied
pig.properties copied
log4j.properties copied
tez-site.xml copied
```

## 開啟hadoop
*初始化hdfs
>`formatdfs`

執行結果:

`Are you sure ? (YES/NO) YES`

```
wka01 clean
wka02 clean
wka03 clean
wka04 clean
formathdfs ok
```
*停止namenode、secondarynamenode、datanode
>`stophdfs`

執行結果:

```
wka01 stop datanode...OK
wka02 stop datanode...OK
wka03 stop datanode...OK
wka04 stop datanode...OK
mas01 stop secondarynamenode...OK
mas01 stop namenode...OK
```
*停止resourcemanager、nodemanager、historyserver
>`stopyarn`

執行結果:

```
wka01 stop nodemanager...OK
wka02 stop nodemanager...OK
wka03 stop nodemanager...OK
wka04 stop nodemanager...OK
mas01 stop resourcemanager...OK
mas01 stop historyserver...OK
```
*啟動namenode、secondarynamenode、datanode
>`starthdfs`

執行結果:

```
mas01 start namenode...OK
mas01 start secondarynamenode...OK
wka01 start datanode...OK
wka02 start datanode...OK
wka03 start datanode...OK
wka04 start datanode...OK
```
*啟動resourcemanager、nodemanager、historyserver
>`startyarn`

執行結果:

```
mas01 start resourcemanager...OK
mas01 start historyserver...OK
wka01 start nodemanager...OK
wka02 start nodemanager...OK
wka03 start nodemanager...OK
wka04 start nodemanager...OK
```
*將tez檔案複製到hdfs
>`buildtez`

執行結果:

```
delete /apps/tez OK
create /apps/tez OK
put apache-tez-0.9.2-bin  OK
```
