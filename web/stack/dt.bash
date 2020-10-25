export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export HADOOP_HOME=/opt/hadoop-3.3.0
export HADOOP_LOG_DIR=/tmp
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop/
export LD_LIBRARY_PATH=$HADOOP_HOME/lib/native/
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
# export HADOOP_USER_CLASSPATH_FIRST=true
[ -z $HADOOP_USER_NAME ] && declare -r HADOOP_USER_NAME=$USER

# JobHistory log file path, 會自動產生目錄
# export HADOOP_MAPRED_LOG_DIR="/home/bigred/jhslog"

export YARN_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME
# export YARN_LOG_DIR=/tmp

# hadoop 3.2.1 及 3.1.3 這二個版本只要執行檔案傳送命令就會出現以下訊息
# hadoop fs -put -f /etc/passwd /tmp
# SASL encryption trust check: localHostTrusted = false, remoteHostTrusted = false
export HADOOP_ROOT_LOGGER="WARN,console"

export PIG_HOME=/opt/pig-0.17.0
export PIG_HEAPSIZE=512
export HIVE_HOME=/opt/apache-hive-2.3.7-bin

export PATH=/opt/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PIG_HOME/bin:$HIVE_HOME/bin

