// File: myreset.v
// Generated by MyHDL 0.11.43
// Date: Mon Jan 15 03:04:39 2024


`timescale 1ns/10ps

module myreset (
    clk,
    reset_l,
    host_intf_rst_i
);


input clk;
input reset_l;
output host_intf_rst_i;
reg host_intf_rst_i;




always @(posedge clk) begin: MYRESET_TESTSIG
    if ((reset_l == 0)) begin
        host_intf_rst_i <= 1;
    end
    else begin
        host_intf_rst_i <= 0;
    end
end

endmodule