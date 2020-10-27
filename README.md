# DT


#GW主機
--------------

* 產生 SSH 公私鑰

`ssh-keygen -t rsa -P `

* 複製公鑰至各台電腦

`ssh-copy-id Name@Hosts`

`ssh-copy-id bigred@192.168.10.10`

* 下載githun資料

`git clone 'https://github.com/Oscar-Young/DT-alpine'`

* 將此檔加入環境變數，請設定自己資料夾的路徑，以下參考

`nano .bashrc`
```
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

dt sysinfo

dt sysprep

dt build

starthdfs

stophdfs

startyarn

--------------

![composition](https://github.com/Oscar-Young/DT-alpine/blob/master/doc/picture/composition.png)
