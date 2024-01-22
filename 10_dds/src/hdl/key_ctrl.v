module key_ctrl(
    input   wire            sys_clk,
    input   wire            sys_rst_n,
    input   wire  [3:0]     key,

    // 波形选择信号
    output  reg  [3:0]     wave_sel
);

wire key_3;
wire key_2;
wire key_1;
wire key_0;


always @(posedge sys_clk or negedge sys_rst_n) begin
    if(sys_rst_n == 1'b0)
        wave_sel <= 4'b0001;
    // 锯齿波
    else if(key_3 == 1'b1)
        wave_sel <= 4'b1000;
    // 三角波
    else if(key_2 == 1'b1)
        wave_sel <= 4'b0100;
    // 方波
    else if(key_1 == 1'b1)
        wave_sel <= 4'b0010;
    // 正弦波
    else if(key_0 == 1'b1)
        wave_sel <= 4'b0001;
    else
        wave_sel <= 4'b0001;
    end


key_filter
#(
    .CNT_MAX (20'd999_999) //计数器计数最大值
)
key_filter_3
(
    .sys_clk    (sys_clk) ,   //系统时钟50Mhz
    .sys_rst_n  (sys_rst_n) ,   //全局复位
    .key_in     (key[3]) ,   //按键输入信号
    .key_flag   (key_3)     //key_flag为1时表示消抖后检测到按键被按下
                          //key_flag为0时表示没有检测到按键被按下
);

key_filter
#(
    .CNT_MAX (20'd999_999) //计数器计数最大值
)
key_filter_2
(
    .sys_clk    (sys_clk) ,   //系统时钟50Mhz
    .sys_rst_n  (sys_rst_n) ,   //全局复位
    .key_in     (key[2]) ,   //按键输入信号
    .key_flag   (key_2)     //key_flag为1时表示消抖后检测到按键被按下
                          //key_flag为0时表示没有检测到按键被按下
);


key_filter
#(
    .CNT_MAX (20'd999_999) //计数器计数最大值
)
key_filter_1
(
    .sys_clk    (sys_clk) ,   //系统时钟50Mhz
    .sys_rst_n  (sys_rst_n) ,   //全局复位
    .key_in     (key[1]) ,   //按键输入信号
    .key_flag   (key_1)     //key_flag为1时表示消抖后检测到按键被按下
                          //key_flag为0时表示没有检测到按键被按下
);

key_filter
#(
    .CNT_MAX (20'd999_999) //计数器计数最大值
)
key_filter_0
(
    .sys_clk    (sys_clk) ,   //系统时钟50Mhz
    .sys_rst_n  (sys_rst_n) ,   //全局复位
    .key_in     (key[0]) ,   //按键输入信号
    .key_flag   (key_0)     //key_flag为1时表示消抖后检测到按键被按下
                          //key_flag为0时表示没有检测到按键被按下
);

endmodule
