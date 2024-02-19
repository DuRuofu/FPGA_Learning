`timescale 1ns / 1ns

// 按照 I2C 协议对 EERPROM 存储芯片执行数据读写操作

module i2c_ctrl
#(
    parameter DEVICE_ADDR  = 7'b1010_111,          // 设备地址
    parameter SYS_CLK_FREQ = 'd50_000_000,  // 系统时钟频率
    parameter I2C_SCL_FREQ = 'd250_000     // SCL 时钟频率
)
(
    input       wire            sys_clk ,
    input       wire            sys_rst_n,
    input       wire            wr_en,       // 写使能
    input       wire    [15:0]  byte_addr,   // 字节地址
    input       wire    [7:0]   wr_data,     // 写入数据
    input       wire            rd_en,       // 读使能
    input       wire            addr_num,    // 地址位数(0:8bit, 1:16bit)
    input       wire            i2c_start,   // I2C 开始信号

    output      reg             i2c_scl,     // 时钟(250Khz)
    inout       wire            i2c_sda,     // 数据
    output      reg    [7:0]    rd_data,     // 读取的数据
    output      reg             i2c_end,     // I2C 结束信号
    output      reg             i2c_clk      // I2C 时钟信号(1Mhz)
);

parameter   CNT_CLK_MAX     = (SYS_CLK_FREQ / I2C_SCL_FREQ) >> 3;  // 时钟分频计数器最大值

// I2C 控制状态机状态
parameter   IDLE            = 4'd00, //初始状态 
            START_1         = 4'd01, //开始状态 1 
            SEND_D_ADDR     = 4'd02, //设备地址写入状态 + 控制写 
            ACK_1           = 4'd03, //应答状态 1 
            SEND_B_ADDR_H   = 4'd04, //字节地址高八位写入状态
            ACK_2           = 4'd05, //应答状态 2 
            SEND_B_ADDR_L   = 4'd06, //字节地址低八位写入状态 
            ACK_3           = 4'd07, //应答状态 3 
            WR_DATA         = 4'd08, //写数据状态 
            ACK_4           = 4'd09, //应答状态 4 
            START_2         = 4'd10, //开始状态 2 
            SEND_RD_ADDR    = 4'd11, //设备地址写入状态 + 控制读 
            ACK_5           = 4'd12, //应答状态 5 
            RD_DATA         = 4'd13, //读数据状态 
            N_ACK           = 4'd14, //非应答状态 
            STOP            = 4'd15; //结束状态

reg [7:0] cnt_clk;  // 时钟分频计数器
reg [3:0] state;    // 状态机状态(二机制码)
reg [1:0] cnt_i2c_clk;      // I2C 时钟计数器
reg       cnt_i2c_clk_en;   // I2C 时钟计数器使能
reg [3:0] cnt_bit;  // 位计数器
reg       sda_out;  // SDA 输出
wire       sda_en;   // SDA 输出使能
reg       ack;      // 应答信号
wire       sda_in;   // SDA 输入
reg [7:0] rd_data_reg;  // 读取的数据暂存 

//分频计数器(cnt_clk:0~24)
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(sys_rst_n == 1'b0) begin 
        cnt_clk <= 8'd00;
    end
    else  if(cnt_clk == CNT_CLK_MAX - 1) begin
        cnt_clk <= 8'd00;
    end
    else begin
        cnt_clk <= cnt_clk + 1'b1;
    end
end

// 分频生成 I2C 时钟信号 (i2c_clk:1MHz)
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(sys_rst_n == 1'b0) begin 
        i2c_clk <= 1'b1;
    end
    // 时钟产生条件
    else if(cnt_clk == CNT_CLK_MAX - 1) begin
        i2c_clk <= ~i2c_clk;
    end
end

// I2C 控制状态机
always @(posedge i2c_clk or negedge sys_rst_n) begin
    if(sys_rst_n == 1'b0) begin 
        state <= IDLE; // 空闲状态
    end
    else begin
        case(state)
            IDLE: begin  
                if (i2c_start == 1'b1) 
                    state <= START_1;
                else 
                    state <= state;  
            end
            START_1: begin
                if (cnt_i2c_clk == 2'd3) 
                    state <= SEND_D_ADDR;
                else 
                    state <= state;
            end
            SEND_D_ADDR: begin
                if ((cnt_i2c_clk == 2'd3) && (cnt_bit == 3'd7)) 
                    state <= ACK_1;
                else 
                    state <= state;
            end
            ACK_1: begin
                if ((cnt_i2c_clk == 2'd3) && (ack == 1'b0)) begin 
                    // 判断地址位数
                    if (addr_num == 1'b1) 
                        state <= SEND_B_ADDR_H;
                    else 
                        state <= SEND_B_ADDR_L;
                end
                else 
                    state <= state;
            end
            SEND_B_ADDR_H: begin
                if ((cnt_i2c_clk == 2'd3) && (cnt_bit == 3'd7)) 
                    state <= ACK_2;
                else 
                    state <= state;
            end
            ACK_2: begin
                if ((cnt_i2c_clk == 2'd3) && (ack == 1'b0))
                    state <= SEND_B_ADDR_L;
                else 
                    state <= state;
            end
            SEND_B_ADDR_L: begin
                if ((cnt_i2c_clk == 2'd3) && (cnt_bit == 3'd7)) 
                    state <= ACK_3;
                else 
                    state <= state;
            end
            ACK_3: begin
                if ((cnt_i2c_clk == 2'd3) && (ack == 1'b0)) begin
                    if (wr_en == 1'b1)
                        state <= WR_DATA;
                    else if (rd_en == 1'b1)
                        state <= START_2;
                    else
                        state <= state;
                end
                else 
                    state <= state;
            end
            WR_DATA: begin
                if ((cnt_i2c_clk == 2'd3) && (cnt_bit == 3'd7)) 
                    state <= ACK_4;
                else 
                    state <= state;
            end
            ACK_4: begin
                if ((cnt_i2c_clk == 2'd3) && (ack == 1'b0)) 
                    state <= STOP;
                else 
                    state <= state;
            end
            START_2: begin
                if (cnt_i2c_clk == 2'd3) 
                    state <= SEND_RD_ADDR;
                else 
                    state <= state;
            end
            SEND_RD_ADDR: begin
                if ((cnt_i2c_clk == 2'd3) && (cnt_bit == 3'd7)) 
                    state <= ACK_5;
                else 
                    state <= state;
            end
            ACK_5: begin
                if ((cnt_i2c_clk == 2'd3) && (ack == 1'b0)) 
                    state <= RD_DATA;
                else 
                    state <= state;
            end
            RD_DATA: begin
                if ((cnt_i2c_clk == 2'd3) && (cnt_bit == 3'd7)) 
                    state <= N_ACK;
                else 
                    state <= state;
            end
            N_ACK: begin
                if ((cnt_i2c_clk == 2'd3) && (ack == 1'b0)) 
                    state <= STOP;
                else 
                    state <= state;
            end
            STOP: begin
                if ((cnt_i2c_clk == 2'd3) && (cnt_bit == 3'd3)) 
                    state <= IDLE;
                else 
                    state <= state;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end


// I2C 时钟计数器
always @(posedge i2c_clk or negedge sys_rst_n) begin
    if(sys_rst_n == 1'b0) begin 
        cnt_i2c_clk <= 2'd0;
    end
    // 计数条件
    else if(cnt_i2c_clk_en == 1'b1) begin
        cnt_i2c_clk <= cnt_i2c_clk + 1'b1;
    end
end

// I2C 时钟计数器使能
always @(posedge i2c_clk or negedge sys_rst_n) begin
    if(sys_rst_n == 1'b0) begin 
        cnt_i2c_clk_en = 1'b0;
    end
    // 失能条件
    else if((cnt_i2c_clk == 2'd3) && (cnt_bit == 3'd3) && (state == STOP)) begin
        cnt_i2c_clk_en = 1'b0;
    end
    // 使能条件
    else if(i2c_start == 1'b1) begin
        cnt_i2c_clk_en = 1'b1;
    end
end

// 位计数器
always @(posedge i2c_clk or negedge sys_rst_n) begin
    if(sys_rst_n == 1'b0) begin 
        cnt_bit <= 3'd0;
    end
    // 不计数条件
    else if((state == IDLE) || (state == START_1) || (state == START_2)|| (state == ACK_1) || (state == ACK_2) || (state == ACK_3) || (state == ACK_4) || (state == ACK_5) || (state == N_ACK)) begin
        cnt_bit <= 3'd0;
    end
    // 清零条件
    else if((cnt_i2c_clk == 2'd3) && (cnt_bit == 3'd7)) begin
        cnt_bit <= 3'd0;
    end
    // 计数条件
    else if((cnt_i2c_clk == 2'd3) && (state != IDLE)) begin
        cnt_bit <= cnt_bit + 1'b1;
    end
end

// SDA 输出
always @(*) begin
    case(state)
        IDLE: begin
            sda_out <= 1'b1;
        end
        START_1: begin
            if(cnt_i2c_clk == 2'd0) 
                sda_out <= 1'b1;
            else 
                sda_out <= 1'b0;
        end
        SEND_D_ADDR: begin
            if(cnt_bit < 3'd6) 
                sda_out <= DEVICE_ADDR[6 - cnt_bit];
            else 
                sda_out <= 1'b0;
        end
        ACK_1: begin
            sda_out <= 1'b1;
        end
        SEND_B_ADDR_H: begin
            sda_out <= byte_addr[15 - cnt_bit];
        end
        ACK_2: begin
            sda_out <= 1'b1;
        end
        SEND_B_ADDR_L: begin
            sda_out <= byte_addr[7 - cnt_bit];
        end
        ACK_3: begin
            sda_out <= 1'b1;
        end
        WR_DATA: begin
            sda_out <= wr_data[7 - cnt_bit];
        end
        ACK_4: begin
            sda_out <= 1'b1;
        end
        START_2: begin
            if (cnt_i2c_clk <= 2'b1)
                sda_out <= 1'b1;
            else
                sda_out <= 1'b0;
        end
        SEND_RD_ADDR: begin
            if(cnt_bit < 3'd6) 
                sda_out <= DEVICE_ADDR[6 - cnt_bit];
            else 
                sda_out <= 1'b1;
        end
        ACK_5: begin
            sda_out <= 1'b1;
        end
        RD_DATA: begin
            sda_out <= 1'b1;
        end
        N_ACK: begin
            sda_out <= 1'b1;
        end
        STOP: begin
            if((cnt_bit == 3'd0) && (cnt_i2c_clk <= 2'd3)) 
                sda_out <= 1'b0;
            else 
                sda_out <= 1'b1;
        end
        default: sda_out <= 1'b1;

    endcase
end

// SDA 输出使能
assign sda_en = ((state == RD_DATA) || (state == ACK_1) || (state == ACK_2)|| (state == ACK_3) || (state == ACK_4)|| (state == ACK_5) )? 1'b0 : 1'b1;

// ACK 信号
always @(*) begin
    case(state)
    ACK_1, ACK_2, ACK_3, ACK_4, ACK_5: begin
        if(cnt_i2c_clk == 2'd0) 
            ack = sda_in;
        else 
            ack = ack;
    end
    default: ack = 1'b0;
    endcase
end

// SDA 输入
assign sda_in = i2c_sda;

always @(*) begin
    case(state)
        IDLE: begin
            rd_data_reg <= 8'b0;
        end
        RD_DATA: begin
            rd_data_reg[7- cnt_bit] <= sda_in;
        end
        default: rd_data_reg <= rd_data_reg;

    endcase
end

// I2C_SCL 输出
always @(*) begin
    case(state)
        IDLE: begin
            i2c_scl <= 1'b1;
        end
        START_1: begin
            if(cnt_i2c_clk == 2'd3) 
                i2c_scl <= 1'b0;
            else 
                i2c_scl <= 1'b1;
        end
        SEND_D_ADDR,ACK_1,SEND_B_ADDR_H,ACK_2,ACK_3,WR_DATA,ACK_4,
        START_2,SEND_RD_ADDR,ACK_5,RD_DATA,N_ACK:begin
            if((cnt_i2c_clk == 2'd1) || (cnt_i2c_clk == 2'd2))
                i2c_scl <= 1'b1;
            else 
                i2c_scl <= 1'b0;
        end
        STOP: begin
            if((cnt_bit == 3'd0) && (cnt_i2c_clk <= 2'd0)) 
                i2c_scl <= 1'b0;
            else 
                i2c_scl <= 1'b1;
        end
        default: i2c_scl <= 1'b1;
    endcase
end

// I2C_SDA 输出
assign i2c_sda = (sda_en)? sda_out : 1'b1;

// 结束信号
always @(posedge i2c_clk or negedge sys_rst_n) begin
    if(sys_rst_n == 1'b0) begin 
        i2c_end <= 1'b0;
    end
    else if((state == STOP) && (cnt_bit == 3'd3) && (cnt_i2c_clk == 2'd3)) begin
        i2c_end <= 1'b1;
    end
    else begin
        i2c_end <= 1'b0;
    end
end

// 数据输出
always @(posedge i2c_clk or negedge sys_rst_n) begin
    if(sys_rst_n == 1'b0) begin 
        rd_data <= 8'd0;
    end
    else if((state == RD_DATA) && (cnt_bit == 3'd7) && (cnt_i2c_clk == 2'd3)) begin
        rd_data <= rd_data_reg;
    end
    else begin
        rd_data <= rd_data;
    end
end
endmodule
