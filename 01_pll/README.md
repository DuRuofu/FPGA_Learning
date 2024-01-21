# vivado 工程版本管理

### 说明：

1. 本文档由DuRuofu撰写，由DuRuofu负责解释及执行。
2. 本文档旨在记录尝试对vivado 工程进行git版本管理的思考和细节。

### 修订历史：

| 文档名称            | 版本   | 作者    | 时间       | 备注     |
| ------------------- | ------ | ------- | ---------- | -------- |
| vivado 工程版本管理 | v1.0.0 | DuRuofu | 2024-01-20 | 首次建立 |



## 一、起因

vivado一个工程的可能所需要占据的空间有几百兆甚至更大，但大部分都是编译过程中产生的临时文件，想着有没有什么好的办法来管理这些工程。

## 一、工程目录

``` sh
.
├── vivado # Vivado的工程全都放在Vivado目录下，包括bd以及它的相关文件；
├── src  # 放hdl的源文件以及IP Core的源文件
│   ├── hdl      # 放hdl的源文件
│   ├── ip_repo  # IP Core的源文件
│   ├── xdc      # 存放约束文件
│   ├── sim      # 存放仿真文件 
├── docs  # 放跟工程相关的文档
├── mcs  # 放工程生成的bit和mcs文件
├── scripts # 进行git管理的关键,里面放各种Tcl脚本
│   ├── build.tcl  # 恢复项目脚本
├── README.md  # 自述文件
├── .gitingore # git
```


## 二、保存工程




## 三、恢复工程




# 参考链接
1. https://blog.csdn.net/ai_ljh/article/details/108027066
2. https://www.fpgadeveloper.com/2014/08/version-control-for-vivado-projects.html/
3. https://blog.csdn.net/qq_41332806/article/details/110715083
4. https://zhuanlan.zhihu.com/p/93711367
5. https://zhuanlan.zhihu.com/p/161271929