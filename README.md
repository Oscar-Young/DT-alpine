# DT

![composition](https://github.com/Oscar-Young/DT-alpine/blob/master/doc/picture/composition.png)


## 環境安裝及系統部署
----------------------------------------------------------------------

* 產生 SSH 公私鑰

`ssh-keygen -t rsa -P `

* 複製公鑰至各台電腦

`ssh-copy-id Name@Hosts`

`ssh-copy-id bigred@192.168.10.10`

* 下載githu資料

`git clone 'https://github.com/Oscar-Young/DT-alpine'`

* 將此檔加入環境變數，請設定自己資料夾的路徑，以下參考

`nano .bashrc`
```bash
export PATH=/home/username/DT-alpine/bin:$PATH
export DT_HOME=~/DT-alpine
```

* 修改hosts，請設定好自己的IP，以下參考

`nano DT-alpine/web/config/hosts`
```
127.0.0.1 localhost
192.168.10.254 gw
192.168.10.10 mas01
192.168.10.20 wka01
192.168.10.21 wka02
192.168.10.22 wka03
192.168.10.23 wka04
192.168.10.30 ds01
```

* 修改dt環境變數，請設定好自己的IP還有資料夾路徑，以下參考

`nano DT-alpine/conf/dt-env.sh`
```bash
#!/bin/bash
export DT_HOME="/home/username/DT-alpine"
export WEB_HOST="192.168.10.254"
export WEB_PORT="8888"
export WEB_URL=$WEB_HOST:$WEB_PORT
```

## *使用dt程式部署haoop

`dt sysinfo`

`執行結果`

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

`dt sysprep`

`執行結果`

```
Loading DT environment... OK
Web Server is already start : 192.168.XXX.XXX:XXXX
[wka01]
Add apk repositories... OK
Update apk repositories... OK
Install openjdk-1.8-jdk... OK
Setting SSH environment... OK
```

`dt build`

`執行結果`

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

* 開啟hadoop

`formatdfs`

`Are you sure ? (YES/NO) YES`

```
wka01 clean
wka02 clean
wka03 clean
wka04 clean
formathdfs ok
```

`stophdfs && stopyarn`

`starthdfs && startyarn`

----------------------------------------------------------------------

