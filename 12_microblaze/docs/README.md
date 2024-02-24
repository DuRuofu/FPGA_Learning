#开发记录
### 说明：

1. 本文档由DuRuofu撰写，由DuRuofu负责解释及执行。
2. 本文档旨在记录尝试对vivado 工程进行git版本管理的思考和细节。

### 修订历史：

| 文档名称 | 版本 | 作者 | 时间 | 备注 |
| ---- | ---- | ---- | ---- | ---- |
| vivado 工程版本管理 | v1.0.0 | DuRuofu | 2024-01-20 | 首次建立 |

# vivado 工程版本管理

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
├── .gitignore # git
```

## 二、保存工程

> 前提：新建工程建立在vivado目录下，其余文件按照上述描述存放。

选择project：
![](attachments/Pasted%20image%2020240121105850.png)

选择write TCl：

![](attachments/Pasted%20image%2020240121110011.png)


选择scripts目录，命名为build.tcl,其他选项默认

![](attachments/Pasted%20image%2020240121110139.png)

.gitingore忽略文件里填写

```
vivado/
```

即可使用git对项目源码进行管理。
## 三、恢复工程

克隆项目，打开build.tcl脚本将下面一项做修改：

修改新工程的创建路径：
``` tcl

# Create project
create_project ${_xil_proj_name_} ./${_xil_proj_name_} -part xc7a100tfgg484-2

```

修改为：

``` tcl

# Create project
create_project $origin_dir/../vivado/${_xil_proj_name_} -part xc7a100tfgg484-2

```


在vivado里使用 tcl console，切换到克隆下面脚本目录

![](attachments/Pasted%20image%2020240121114900.png)

运行脚本：
![](attachments/Pasted%20image%2020240121115515.png)

vivado目录下项目顺利生成：

![](attachments/Pasted%20image%2020240121115342.png)

项目源文件也自动导入了：
![](attachments/Pasted%20image%2020240121115614.png)


# 参考链接
1. https://blog.csdn.net/ai_ljh/article/details/108027066
2. https://www.fpgadeveloper.com/2014/08/version-control-for-vivado-projects.html/
3. https://blog.csdn.net/qq_41332806/article/details/110715083
4. https://zhuanlan.zhihu.com/p/93711367
5. https://zhuanlan.zhihu.com/p/161271929