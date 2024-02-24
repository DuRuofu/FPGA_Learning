
### 说明：

1. 本文档由DuRuofu撰写，由DuRuofu负责解释及执行。

### 修订历史：

| 文档名称               | 版本     | 作者      | 时间         | 备注   |
| ------------------ | ------ | ------- | ---------- | ---- |
| FPGA使用microblaze软核 | v1.0.0 | DuRuofu | 2024-02-23 | 首次建立 |

<div STYLE="page-break-after: always;"></div>

# FPGA使用MicroBlaze软核

## 一、什么是MicroBlaze

MicroBlaze 是 Xilinx 公司提供的一款 32/64 位软核嵌入式处理器，是一款高度灵活可配置的易用型处理器， 它能够利用 FPGA 内部通用资源和相关 IP 核，实现可编程片上系统（SOPC）的设计。该处理器采用的是32 位 RISC（Reduced Insrtction System Computer）优化结构和 Harvard 总线结构，广泛适用于 Spartan、 Virtex 和 Artix 等系列的 FPGA。

MicroBlaze是基于Xilinx公司FPGA的微处理器IP核·和其它外设IP核一起·可以完成可编程系统芯片(SOPC)的设计。MicroBlaze处理器采用RISC架构和哈佛结构的32位指令和数据总线·可以全速执行存储在片上存储器和外部存储器中的程序,并访问其数据。MicroBlaze可以响应软件和硬件中断·进行异常处理·通过外加控制逻辑·可以扩展外部中断。利用微处理器调试模块(MDM)IP核·可通过]TAG接口来调试处理器系统。多个MicroBlaze处理器可以用1个MDM来完成多处理器调试。

FPGA是可编程的硬件逻辑电路·microblaze是一种处理器CPU电路·使用microblaze，相当于就是在FPGA内部做了一个CPU在里面，可以用C语言写程序·在这个CPU上跑C语言的软件程序，FPGA偏向逻辑·但是做控制比较麻烦，用CPU跑C程序控制比较方便。这就是嵌入式系统，包括嵌入式硬件系统部分以及运行在其硬件的嵌入式软件。因此嵌入式系统的开发流程需要分为嵌入式硬件与软件两个部分。在FPGA中通过FPGA内部逻辑资源搭建了嵌入式硬件系统，而在其中的CPU核上需要编写嵌入式程序。

## 二、使用FPGA进行嵌入式设计

在Vivado中通常使用Vivado IP核集成器环境来搭建嵌入式系统硬件平台使用Vivado SDK （或者Vitis）来编写、编译以及调试嵌入式系统的软件部分。

![](attachments/Pasted%20image%2020240223214141.png)

#### 2.1 嵌入式硬件平台搭建

嵌入式硬件平台搭建的流程与普通的FPGA设计并无太大区别·仍然是设计输入、设计综合、设计实现等主要步骤。在硬件平台设计实现并生成Bt文件后，需要执行硬件平台导出的操作，即将所搭建的硬件平台的信息导出至Vivado SDK中，以便在SDK中继续进行软件开发
#### 2.2 嵌入式系统软件设计

在Vivado将硬件平台设计导出至SDK（或者Vitis）中后，在SDK中可针对硬件平台进行创建对应的软件应用工程以及BSP板级支持包工程。SDK工具会根据具体的硬件平台信息将对应硬件模块得软件提取至BSP工程中·用户可方便地使用BSP中所提供的驱动函数来进行软件开发。SDK中可以进行软件的编写调试以及FPGA平台的硬件配置。

## 二、实际使用

### 2.1 整体步骤

![](attachments/Pasted%20image%2020240223212458.png)

### 2.2 设计框图

![](attachments/Pasted%20image%2020240223212637.png)


### 2.3 依赖介绍

1. AXI总线，可以参考这篇笔记：[AXI总线](../../通讯总线/AXI/AXI总线.md)
2. AXI GPIO IP核简介：PL部分核ARM通信，依靠的就是AXI总线，添加AXI GPIO IP核，利用PL的资源来扩充GPIO资源
3. AX-uartlite IP核简介：AXI-uartlite是Xilinx提供的驱动串口的IP核，用AXI-Lite总线接口和用户进行交互，速度根据不同的芯片调整，总的来说使用比较简单，收发数据也比自己写的串口驱动程序要稳定

### 2.4 实际设计

##### 2.4.1 新建block design设计

![](attachments/Pasted%20image%2020240223215023.png)

##### 2.4.2 调用microblaze IP核

![](attachments/Pasted%20image%2020240223215129.png)

![](attachments/Pasted%20image%2020240223215205.png)

##### 2.4.3 调用其他 IP核

![](attachments/Pasted%20image%2020240223215317.png)

###### 1. 配置GPIO IP核

修改名称：

![](attachments/Pasted%20image%2020240223215522.png)

位宽和输出配置:

![](attachments/Pasted%20image%2020240223215637.png)


###### 2. 配置串口 IP核

![](attachments/Pasted%20image%2020240223215835.png)


##### 2.4.4 自动布线

![](attachments/Pasted%20image%2020240223215959.png)

![](attachments/Pasted%20image%2020240223220022.png)

效果:

![](attachments/Pasted%20image%2020240223220123.png)


###### 1. 修改和调整:

差分时钟改为单端时钟:

![](attachments/Pasted%20image%2020240223220257.png)

去掉复位和锁信号

![](attachments/Pasted%20image%2020240223220421.png)


右键clk_in 引出引脚:

![](attachments/Pasted%20image%2020240223220530.png)

效果:

![](attachments/Pasted%20image%2020240223220543.png)


添加常量IP核 提供始终为一的复位信号(可省)
![](attachments/Pasted%20image%2020240223220815.png)


![](attachments/Pasted%20image%2020240223220915.png)


###### 2. 再次连线

![](attachments/Pasted%20image%2020240223221040.png)

选择所有:

![](attachments/Pasted%20image%2020240223221104.png)

结果:

![](attachments/Pasted%20image%2020240223221141.png)


可以重新布局:

![](attachments/Pasted%20image%2020240223221307.png)

效果:

![](attachments/Pasted%20image%2020240223221349.png)

##### 2.4.5 生成HDL_WAPPER

综合-生成IP的相关文件:

![](attachments/Pasted%20image%2020240223221656.png)

![](attachments/Pasted%20image%2020240223221805.png)


好了之后选择生成顶层文件:
![](attachments/Pasted%20image%2020240223222121.png)

![](attachments/Pasted%20image%2020240223222130.png)

生成成功:

![](attachments/Pasted%20image%2020240223222213.png)

![](attachments/Pasted%20image%2020240223222230.png)


##### 2.4.6 综合实现管脚约束

![](attachments/Pasted%20image%2020240223222412.png)


进行引脚约束:(硬件平台: 正点原子达芬奇PRO)

![](attachments/Pasted%20image%2020240223223022.png)

![](attachments/Pasted%20image%2020240223223417.png)

综合工程

![](attachments/Pasted%20image%2020240223223535.png)


继续布局布线生成网表:

![](attachments/Pasted%20image%2020240223223621.png)





##### 2.4.7 生成bit文件


![](attachments/Pasted%20image%2020240223230033.png)

![](attachments/Pasted%20image%2020240223230803.png)

![](attachments/Pasted%20image%2020240223230832.png)


##### 2.4.8 使用SDK

![](attachments/Pasted%20image%2020240223231235.png)

![](attachments/Pasted%20image%2020240223231250.png)


###### 1、新建SDK工程

![](attachments/Pasted%20image%2020240224094056.png)

![](attachments/Pasted%20image%2020240224094206.png)

###### 2、使用Hello World

![](attachments/Pasted%20image%2020240224094227.png)

如下：

![](attachments/Pasted%20image%2020240224094421.png)

编译代码：

![](attachments/Pasted%20image%2020240224094800.png)

编译成功如下：

![](attachments/Pasted%20image%2020240224094816.png)


下载文件到板卡：

![](attachments/Pasted%20image%2020240224095357.png)


![](attachments/Pasted%20image%2020240224095437.png)


下载完成：

![](attachments/Pasted%20image%2020240224095542.png)


运行代码：

![](attachments/Pasted%20image%2020240224095701.png)


# 参考链接

1. https://www.bilibili.com/video/BV1p54y1B7PY/?spm_id_from=333.880.my_history.page.click&vd_source=ef5a0ab0106372751602034cdd9ab98e
2. https://blog.csdn.net/weixin_39789553/article/details/118105365
3. https://www.bilibili.com/video/BV1aK4y147qp/?spm_id_from=333.788.recommend_more_video.-1&vd_source=ef5a0ab0106372751602034cdd9ab98e
4. https://www.bilibili.com/video/BV16K411p7Wr/?spm_id_from=333.788.recommend_more_video.-1&vd_source=ef5a0ab0106372751602034cdd9ab98e