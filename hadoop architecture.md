# 什麼是Hadoop

* Hadoop簡介

Hadoop雲端技術平台，提供儲存與處理大量資料的能力，應用在架設叢集環境，藉由平行分散檔案的處理，得到快速的回應。尤當，某節點發生錯誤時，系統自動取得備份資料及佈署運算資源。重要的是此平台，係免費資源。

* Hadoop架構

Hadoop 第一代平臺兩大核心 MapReduce 和 HDFS；此平台處理與分析的方法或工具，都非常仰賴 MapReduce。而現在 Hadoop 第二代架構的兩大核心是 YARN 和 HDFS，有了全新的架構 YARN，不但改善第一代 MapReduce 框架的不足，還可以讓各種處理與分析的方法或工具可以與MapReduce 平等運作，並能讀取與寫入 HDFS。第二代 Hadoop 架構和 YARN。

![Alt text](https://raw.githubusercontent.com/WL107/data/main/hadoop%E6%9E%B6%E6%A7%8B.JPG)

# YARN運作方式

YARN的運作流程，敘述如下；
1.	Client端 (可以是一台電腦或是Pig、Hive、R、Excel，甚至是Java的程式 ) 把任務提交給ResourceManager。
2.	NodeManager 跟 ResourceManager 回報資料。
3.	ApplicationMaster接到任務後，發現某台Container跑不動，向ResourceManager 要求更多的資源。
4.	ResourceManager 開始了解任務的需求。
5.	ResourceManager 瞭解任務的需求後，再決定要分配幾台Container給ApplicationMaster。


![Alt text](https://raw.githubusercontent.com/WL107/data/main/YARN%E6%9E%B6%E6%A7%8B.jpg)


# HDFS運作方式

HDFS的架構，由兩種角色組成，NameNode及DataNodes；前者，負責檔案系統中各個檔案屬性權限等資訊 ( Metadata, Namespace ) 的管理及儲存；後者，通常由數以百計的節點擔任，每個檔案被分割成許多區塊( Block )與異地備份，每個區塊的大小通常為128 MB，系統會將每個區塊複製許多複本( replica ) ，並分散儲存於不同的資料節點 ( DataNode ) 。如此，若其中一個節點損壞時，檔案系統中的資料還能保存。因此NameNode還需要紀錄每一份檔案存放的位置，當有存取檔案的需求時，協調DataNode負責回應；除此之外，HDFS中很重要的概念；「移動運算到資料端，通常比移動資料到運算端，具備更低的成本」。這是因為資料的位置資訊會被考慮在內，因此運算作業可以移至資料所在位置。處理資料的檔案複本，預設是每個檔案儲存3份，此設定可由開發人員自訂。 HDFS採用的是一般等級伺服器，因此透過複製資料的方式，因應硬體的故障，當偵測到錯誤時，即可從複製的備份資料執行資料回復。

![Alt text](https://raw.githubusercontent.com/WL107/data/main/hdfs%E6%9E%B6%E6%A7%8B.png)

當Client端欲從HDFS取出檔案，會再次詢問Namenode並要求檔案的block所在的位置 ( Datanode ) ，Namenode會回傳每個block被存放的Datanode的清單。

![Alt text](https://raw.githubusercontent.com/WL107/data/main/hdfs%E6%9E%B6%E6%A7%8B2.png)


# Hadoop雲端技術平台比較分析

|屬性\服務|Amazon|Google App Engine|Microsoft Azure|<font color="#dd0000">Apache Hadoop</font><br />|
|----|----|----|----|----|
|架構|Iass/Pass|Pass|Pass|Software|
|服務型態|Compute/Storage|Web application|Web and non-web|Software|
|管理技術|OS on Xen hypervisop|Application container|OS through Fabric controller|Map / Reduce Architecture|
|使用者介面|EC2 Command-line tools|Web-based Administration console|Windows Azure portal|Command line and web|
|APIs|yes|yes|yes|yes|
|收費|yes|maybe|yes|no|
|程式語言|AMI(Amazon Machine Image)|Python|.NET framework|JAVA|


# 研究大綱

我們使用1台Raspberry Pi 4(gw)與6台研揚 UP-Board(UB)來佈署Hadoop雲端平台，Pi4 為gw、其餘6台UB 為 mas01、ds01、wka01~04 。延伸第二代Hadoop架構為基礎雲端平台相關專案，並將Pi4、UB、switch、power、風扇等這些硬體設備整合到一個小型的壓克力機殼裡，完成「可攜帶式Hadoop 生態系統實驗平台」。同時，以「電腦叢集、分散式運算、可攜性」為個案探討，此平台命名為「雲原生高教機」。

![composition](https://github.com/Oscar-Young/DT-alpine/blob/master/doc/picture/1603965913790.jpg)

# 雲原生高教機網路環境架構
![Alt text](https://raw.githubusercontent.com/WL107/data/main/%E6%9E%B6%E6%A7%8B%E5%9C%96.PNG)
