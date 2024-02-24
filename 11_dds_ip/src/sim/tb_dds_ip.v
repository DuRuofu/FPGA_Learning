`timescale 1ns / 1ns

module tb_dds_ip();

// 定义信号
  wire [7:0]M_AXIS_DATA_0_tdata;
  reg M_AXIS_DATA_0_tready;
  wire M_AXIS_DATA_0_tvalid;
  wire [15:0]M_AXIS_PHASE_0_tdata;
  reg M_AXIS_PHASE_0_tready;
  wire M_AXIS_PHASE_0_tvalid;
  reg aclk_0;


initial begin
    aclk_0 = 0;
    M_AXIS_DATA_0_tready = 1'b1; // 使能数据通道
    M_AXIS_PHASE_0_tready = 1'b1;// 使能相位通道

    #5000;
    $stop;
end

// 时钟
always #5 aclk_0 = ~aclk_0; // 时钟周期为10ns 100MHz


// 例化DDS顶层模块
dds_wrapper dds_wrapper
   (
    .M_AXIS_DATA_0_tdata(M_AXIS_DATA_0_tdata),
    .M_AXIS_DATA_0_tready(M_AXIS_DATA_0_tready),
    .M_AXIS_DATA_0_tvalid(M_AXIS_DATA_0_tvalid),
    .M_AXIS_PHASE_0_tdata(M_AXIS_PHASE_0_tdata),
    .M_AXIS_PHASE_0_tready(M_AXIS_PHASE_0_tready),
    .M_AXIS_PHASE_0_tvalid(M_AXIS_PHASE_0_tvalid),
    .aclk_0(aclk_0)
    );

endmodule
