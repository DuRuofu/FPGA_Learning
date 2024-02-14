#开发记录
### 说明：

1. 本文档由DuRuofu撰写，由DuRuofu负责解释及执行。
2. 本文记录使用FPGA实现简单UART串口通信-基于FIFO
### 修订历史：

| 文档名称 | 版本 | 作者 | 时间 | 备注 |
| ---- | ---- | ---- | ---- | ---- |
| UART串口通信-基于FIFO | v1.0.0 | DuRuofu | 2024-01-23 | 首次建立 |

# UART串口通信-基于FIFO

> 代码：https://github.com/DuRuofu/FPGA_Learning/tree/master/06_uart_fifo

## 目标



## 一、整体框图

顶层模块:


![](attachments/顶层框图.svg)


子模块模块:
![](attachments/子模块.svg)

整体框图:

![](attachments/整体框图.svg)

## 二、模块波形图

> 以9600波特率为例。

接收模块:
![](attachments/串口模块波形图(rx).svg)

发送模块：
![](attachments/串口模块波形图(tx).svg)
## 三、代码编写

### 3.1 串口接收模块

模块代码：

``` verilog
`timescale 1ns / 1ns

// 串口接收模块
module uart_rx
#(
    parameter UART_BSP = 'd9600,        // 波特率
    parameter CLK_FREQ = 'd50_000_000   // 时钟频率
)
(
    input wire  sys_clk,        // 系统时钟
    input wire  sys_rst_n,      // 系统复位信号
    input wire  rx,             // 串口接收数据

    output reg [7:0] po_data,  // 模块输出数据
    output reg       po_flag   // 串口接收数据完成标志
);

parameter BAUD_CNT__MAX = CLK_FREQ/UART_BSP; // 波特率计数器最大值

// 中间变量
reg rx_reg_1;       // 用于同步数据
reg rx_reg_2;       // 用于缓冲数据
reg rx_reg_3;       // 用于缓冲数据
reg start_flag;     // 用于判断起始位
reg work_en;        // 用于使能接收模块
reg [15:0] baud_cnt;// 用于计数波特率
reg bit_flag;       // 读取标志
reg [3:0] bit_cnt;  // 读取位数计数
reg [7:0] rx_data;  // 读取到的数据
reg rx_flag ;       // 读取完成标志

// 对输入信号进行同步
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       rx_reg_1 <= 1'b1;  // 初值为1
    end
   else begin
        rx_reg_1 <= rx;
    end
end

// 用于同步数据
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       rx_reg_2 <= 1'b1;  // 初值为1
    end
   else begin
        rx_reg_2 <= rx_reg_1;
    end
end

// 用于同步数据
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       rx_reg_3 <= 1'b1;  // 初值为1
    end
   else begin
        rx_reg_3 <= rx_reg_2;
    end
end

// 开始标志信号 start_flag
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       start_flag <= 1'b0;  // 初值为0
    end
    else if((rx_reg_3 == 1'b1) && (rx_reg_2== 1'b0) && (work_en == 1'b0)) begin
        start_flag <= 1'b1;
    end
    else begin
        start_flag <= 1'b0;
    end
end

// 使能信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       work_en <= 1'b0;  // 初值为0
    end
    // 开始接收拉高
    else if(start_flag == 1'b1) begin
        work_en <= 1'b1;
    end
    // 接收结束拉低(比特计数器为8，且读取标志为高)
    else if((bit_cnt == 4'd8) && (bit_flag == 1'b1)) begin
        work_en <= 1'b0;
    end
    else begin
        work_en <= work_en;
    end
end

// 波特计数器
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       baud_cnt <= 1'b0;  // 初值为0
    end
    // 归零条件
    else if((baud_cnt == BAUD_CNT__MAX - 1'b1) || (work_en == 1'b0) ) begin
        baud_cnt <= 16'b0;
    end
    // 波特计数器递增
    else if (work_en == 1'b1) begin
        baud_cnt <= baud_cnt + 1'b1;
    end
    else begin
        baud_cnt <= baud_cnt;
    end
end

// 比特标志信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       bit_flag <= 1'b0;  // 初值为0
    end
    // 波特计数器达到波特率的一半时，比特标志拉高
    else if(baud_cnt == BAUD_CNT__MAX/2 - 1'b1) begin
        bit_flag <= 1'b1;
    end
    else begin
        bit_flag <= 1'b0;
    end
end

// 比特计数器
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       bit_cnt <= 4'b0;  // 初值为0
    end
    // 归零条件
    else if((bit_cnt == 4'd8) && (bit_flag == 1'b1)) begin
        bit_cnt <= 4'b0;
    end
    // 比特计数器递增
    else if (bit_flag == 1'b1) begin
        bit_cnt <= bit_cnt + 1'b1;
    end
    else begin
        bit_cnt <= bit_cnt;
    end
end

// 数据拼接
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       rx_data <= 8'd0;  // 初值为0
        end
    // 数据拼接(串行转并行数据)
    else if((bit_cnt >= 4'd1) && (bit_cnt <= 4'd8) && (bit_flag == 1'b1)) begin
        rx_data <= {rx_reg_3, rx_data[7:1]};
    end
    else begin
        rx_data <= rx_data;
    end
end

// rx标志信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       rx_flag <= 1'b0;  // 初值为0
    end
    else if((bit_cnt == 4'd8) && (bit_flag == 1'b1)) begin
        rx_flag <= 1'b1;
    end   
    else begin
        rx_flag <= 1'b0;
    end
end

// 输出数据
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       po_data <= 8'd0;  // 初值为0
    end
    else if(rx_flag == 1'b1) begin
        po_data <= rx_data;
    end
    else begin
        po_data <= po_data;
    end
end

// 输出标志信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       po_flag <= 1'b0;  // 初值为0
    end
    else begin
        po_flag <= rx_flag;
    end
end
endmodule

```

模块测试：
``` verilog
`timescale 1ns / 1ns

module tb_uart_rx();
reg sys_clk;
reg sys_rst_n;
reg rx = 1'b1;

wire [7:0] po_data;
wire po_flag;

initial begin
    sys_clk = 1'b0;
    sys_rst_n = 1'b0;
    #20
    sys_rst_n = 1'b1;
end

// 时钟信号
always #10 sys_clk = ~sys_clk;

// 测试
initial begin
    #200
    rx_bit(8'd0);
    rx_bit(8'd1);
    rx_bit(8'd2);
    rx_bit(8'd3);
    rx_bit(8'd4);
    rx_bit(8'd5);
    rx_bit(8'd6);
    rx_bit(8'd7);
end

// 引出输出



// 模拟串口数据的任务
task rx_bit (
    input [7:0] data
);

integer i;
for( i= 0 ; i<10 ; i=i+1 ) begin
    case (i)
        0: rx <= 1'b0;
        1: rx <= data[0];
        2: rx <= data[1];
        3: rx <= data[2];
        4: rx <= data[3];
        5: rx <= data[4];
        6: rx <= data[5];
        7: rx <= data[6];
        8: rx <= data[7];
        9: rx <= 1'b1;
    endcase
    #(5208*20);
    end
endtask

uart_rx
#(
    .UART_BSP(9600),   // 波特率
    .CLK_FREQ(50_000_000)   // 时钟频率
)
uart_rx_inst
(
    .sys_clk            (sys_clk),        // 系统时钟
    .sys_rst_n          (sys_rst_n),      // 系统复位信号
    .rx                 (rx),             // 串口接收数据

    .po_data            (po_data),  // 模块输出数据
    .po_flag            (po_flag)   // 串口接收数据完成标志
);

endmodule

```

### 3.2 串口发送模块

模块代码：

```  verilog
`timescale 1ns / 1ns
module uart_tx
#(
    parameter UART_BSP = 'd9600,        // 波特率
    parameter CLK_FREQ = 'd50_000_000   // 时钟频率
)
(
    input wire          sys_clk,        // 系统时钟
    input wire          sys_rst_n,      // 系统复位信号
    input wire   [7:0]  pi_data,        // 模块输入数据
    input wire          pi_flag,        // 串口输入数据标志

    output reg  tx             // 数据输出
);

parameter BAUD_CNT__MAX = CLK_FREQ/UART_BSP; // 波特率计数器最大值

reg         work_en;  // 工作使能
reg [15:0]  baud_cnt; // 波特计数器
reg         bit_flag; // 数据标志
reg [3:0]   bit_cnt;  // 比特计数器

// 使能信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        work_en <= 1'b0;
    end
    else if(pi_flag == 1'b1) begin
        work_en <= 1'b1;
    end
    else if((bit_cnt == 4'd9) && (bit_flag == 1'b1)) begin
        work_en <= 1'b0;
    end
    else 
        work_en <= work_en;
end

// 波特计数器
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        baud_cnt <= 16'd0;
    end
    // 归零条件
    else if((work_en == 1'b0) || (baud_cnt == BAUD_CNT__MAX - 1'b1)) begin
        baud_cnt <= 16'd0;
    end
    // 计数条件
    else if(work_en == 1'b1) begin
        baud_cnt <= baud_cnt + 1'b1;
    end
    else 
        baud_cnt <= baud_cnt;
end

// 比特标志信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        bit_flag <= 1'b0;
    end
    else if(baud_cnt == 16'b1) begin
        bit_flag <= 1'b1;
    end
    else begin
        bit_flag <= 1'b0;
    end
end

// 比特计数器
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        bit_cnt <= 4'd0;
    end
    // 归零条件
    else if((bit_flag == 1'b1) && (bit_cnt == 4'd9)) begin
        bit_cnt <= 4'd0;
    end
    // 计数条件
    else if((bit_flag == 1'b1) && (work_en == 1'b1)) begin
        bit_cnt <= bit_cnt + 1'b1;
    end
    else begin
        bit_cnt <= bit_cnt;
    end

end

// 输出信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        tx <= 1'b1; //空闲为高
    end
    else if(bit_flag == 1'b1)begin
        case(bit_cnt)
            4'd0: tx <= 1'b0; //起始位为低
            4'd1: tx <= pi_data[0];
            4'd2: tx <= pi_data[1];
            4'd3: tx <= pi_data[2];
            4'd4: tx <= pi_data[3];
            4'd5: tx <= pi_data[4];
            4'd6: tx <= pi_data[5];
            4'd7: tx <= pi_data[6];
            4'd8: tx <= pi_data[7];
            4'd9: tx <= 1'b1; //停止位为高
            default: tx <= 1'b1;
        endcase
    end
end

endmodule


```

仿真代码

``` verilog
`timescale 1ns / 1ns

module tb_uart_tx();

reg sys_clk;
reg sys_rst_n;
reg [7:0] pi_data;
reg pi_flag;

wire tx;

// 系统时钟初始化
initial begin
    sys_clk = 1'b0;
    sys_rst_n = 1'b0;
    #20;
    sys_rst_n = 1'b1;
end

// 生成系统时钟
always #10 sys_clk = ~sys_clk;

// 测试序列
initial begin
    pi_data <= 8'd0;
    pi_flag <= 1'b0;
    #200;
    // 0
    pi_data <= 8'd0;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
    #(5208*10*20);
    // 1
    pi_data <= 8'd1;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
    #(5208*10*20);
    // 2
    pi_data <= 8'd2;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
    #(5208*10*20);
    // 3
    pi_data <= 8'd3;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
    #(5208*10*20);
    // 4
    pi_data <= 8'd4;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
    #(5208*10*20);
    // 5
    pi_data <= 8'd5;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
    #(5208*10*20);
    // 6
    pi_data <= 8'd6;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
    #(5208*10*20);
    // 7
    pi_data <= 8'd7;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
end

// 实例化UART发送模块
uart_tx
#(
    .UART_BSP(9600),   // 波特率
    .CLK_FREQ(50_000_000)   // 时钟频率
)
uart_tx_inst
(
    .sys_clk            (sys_clk),        
    .sys_rst_n          (sys_rst_n),      
    .pi_data            (pi_data),  
    .pi_flag            (pi_flag),

    .tx                 (tx)
);
endmodule

```

### 3.3 串口接收缓冲

``` verilog
`timescale 1ns / 1ns

// 串口输入 + 缓冲
module uart_fifo_rx
#(
    parameter UART_BSP = 'd9600,        // 波特率
    parameter CLK_FREQ = 'd50_000_000   // 时钟频率
)
(
    input wire sys_clk,
    input wire sys_rst_n,
    input wire rx,         // 串口接收数据
    input wire rd_en,      // 串口输入缓冲区读取数据使能

    output wire [7:0] data_out, // 串口输入缓冲区输出数据
    output wire empty      // 串口输入缓冲区空标志
    //output wire full        // 串口输入缓冲区满标志
);

wire [7:0] data_in;
wire data_in_flag;

// 实例化UART接收模块
uart_rx
#(
    .UART_BSP(UART_BSP),   // 波特率
    .CLK_FREQ(CLK_FREQ)   // 时钟频率
)
uart_rx
(
    .sys_clk            (sys_clk),        // 系统时钟
    .sys_rst_n          (sys_rst_n),      // 系统复位信号
    .rx                 (rx),             // 串口接收数据

    .po_data            (data_in),  // 模块输出数据
    .po_flag            (data_in_flag)   // 串口接收数据完成标志
);


// 实例化FIFO
dcfifo_uart_1024x8 dcfifo_uart_1024x8_rx (
  .rst(~sys_rst_n),        // input wire rst
  .wr_clk(sys_clk),  // input wire wr_clk
  .rd_clk(sys_clk),  // input wire rd_clk
  .din(data_in),        // input wire [7 : 0] din
  .wr_en(data_in_flag),    // input wire wr_en
  .rd_en(rd_en),    // input wire rd_en

  .dout(data_out),      // output wire [7 : 0] dout
  .full(),      // output wire full
  .empty(empty)    // output wire empty
);

endmodule


```

### 3.3 串口发送缓冲

```   verilog
`timescale 1ns / 1ns

// 串口输出 + 缓冲

module uart_fifo_tx
#(
    parameter UART_BSP = 'd9600,        // 波特率
    parameter CLK_FREQ = 'd50_000_000   // 时钟频率
)
(
    input wire sys_clk,
    input wire sys_rst_n,
    input wire [7:0] data_in, // 串口输出缓冲区输入数据
    input wire wr_en,          // 串口输出缓冲区输入数据标志(写入使能)

    //output wire empty,          // 串口输出缓冲区空标志
    //output wire full,            // 串口输出缓冲区满标志
    output wire tx              // 串口发送数据
);

wire [7:0] data_out;  // 串口输出数据
wire rd_en;
wire empty;

// 缓冲区非空就使能缓冲区数据读出,并且和串口发送模块的写入使能相连
assign rd_en =!empty;

// 实例化UART发送模块
uart_tx
#(
    .UART_BSP(UART_BSP),   // 波特率
    .CLK_FREQ(CLK_FREQ)   // 时钟频率
)
uart_tx
(
    .sys_clk            (sys_clk),        
    .sys_rst_n          (sys_rst_n),      
    .pi_data            (data_out),  
    .pi_flag            (wr_en),

    .tx                 (tx)
);

// 实例化UART发送缓冲
dcfifo_uart_1024x8 dcfifo_uart_1024x8_tx (
  .rst(~sys_rst_n),        // input wire rst
  .wr_clk(sys_clk),  // input wire wr_clk
  .rd_clk(sys_clk),  // input wire rd_clk
  .din(data_in),        // input wire [7 : 0] din
  .wr_en(wr_en),    // input wire wr_en
  .rd_en(rd_en),    // input wire rd_en

  .dout(data_out),      // output wire [7 : 0] dout
  .full(),      // output wire full
  .empty(empty)    // output wire empty
);

endmodule

```

### 3.3 串口顶层模块

模块代码：
``` verilog
`timescale 1ns / 1ns

module uart_fifo_demo(
    input wire sys_clk,
    input wire sys_rst_n,
    input wire rx,

    output wire tx
);

parameter UART_BSP = 115200 ; // 波特率
parameter SYS_CLK_FREQ = 50_000_000 ; // 系统时钟频率

wire [7:0] data;

wire rx_empty;
wire rx_rd_en;  
wire tx_wr_en;

// 接收缓冲区读取使能
assign rx_rd_en = !rx_empty;

// 发送缓冲区写入使能
assign tx_wr_en = !rx_empty;



// 实例化UART接收模块
uart_fifo_rx
#(
    .UART_BSP(UART_BSP),        // 波特率
    .CLK_FREQ(SYS_CLK_FREQ)   // 时钟频率
)
uart_fifo_rx
(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .rx(rx),         // 串口接收数据
    .rd_en(rx_rd_en),      // 串口输入缓冲区读取数据使能

    .data_out(data), // 串口输入缓冲区输出数据
    .empty(rx_empty)   // 串口输入缓冲区空标志
    //.full()        // 串口输入缓冲区满标志
);


// 实例化UART发送模块
uart_fifo_tx
#(
    .UART_BSP(UART_BSP),        // 波特率
    .CLK_FREQ(SYS_CLK_FREQ)   // 时钟频率
)
uart_fifo_tx
(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .data_in(data),         // 串口输出缓冲区输入数据
    .wr_en(tx_wr_en),           // 串口输出缓冲区输入数据标志(写入使能)

    //.empty(),           // 串口输出缓冲区空标志
    //.full(),            // 串口输出缓冲区满标志
    .tx(tx)               // 串口发送数据
);



endmodule

```
仿真代码：
``` verilog
`timescale 1ns / 1ns

// 串口模块测试，模拟串口数据发送，波特率9600

module tb_uart_fifo_demo();

reg sys_clk;
reg sys_rst_n;
reg rx;
wire tx;
// 系统时钟初始化
initial begin
    sys_clk = 1'b0;
    sys_rst_n = 1'b0;
    rx = 1'b1;
    #20;
    sys_rst_n = 1'b1;
end

// 生成系统时钟
always #10 sys_clk = ~sys_clk;

initial begin
    #200;
    rx_byte();
end


// 字节发送任务
task rx_byte();
integer j;
for(j =0;j<8;j=j+1) begin
    rx_bit(j);
end
endtask

// 模拟串口数据的任务
task rx_bit (
    input [7:0] data
);

integer i;
for( i= 0 ; i<10 ; i=i+1 ) begin
    case (i)
        0: rx <= 1'b0;
        1: rx <= data[0];
        2: rx <= data[1];
        3: rx <= data[2];
        4: rx <= data[3];
        5: rx <= data[4];
        6: rx <= data[5];
        7: rx <= data[6];
        8: rx <= data[7];
        9: rx <= 1'b1;
    endcase
    #(5208*20);
    end
endtask


// 实例化串口模块
uart_fifo_demo uart_fifo_demo(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .rx(rx),

    .tx(tx)
);

// 重定义参数,定义串口波特率为9600
defparam uart_fifo_demo.UART_BSP = 9600;

endmodule


```

仿真效果(顶层模块)：
![](attachments/Pasted%20image%2020240214221416.png)


### 四、实际测试效果

![](attachments/Pasted%20image%2020240214221429.png)

# 参考链接

1. https://search.bilibili.com/all?vt=76757802&keyword=%E6%AD%A3%E7%82%B9%E5%8E%9F%E5%AD%90fpga&from_source=webtop_search&spm_id_from=333.1007&search_source=5
2. https://www.bilibili.com/video/BV1y34y147s5/?spm_id_from=333.337.top_right_bar_window_history.content.click&vd_source=ef5a0ab0106372751602034cdd9ab98e
3. https://blog.csdn.net/wanerXR/article/details/125120315
4. https://www.cnblogs.com/lzbmeee/p/17624957.html