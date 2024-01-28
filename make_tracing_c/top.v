// DESCRIPTION: Verilator: Verilog example module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2003 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0
// ======================================================================

// This is intended to be a complex example of several features, please also
// see the simpler examples/make_hello_c.
`timescale 1ns/10ps
module top
  (
   // Declare some signals so we can see how I/O works
   input              clk,
   input              reset_l,

   output wire [1:0]  out_small,
   output wire [39:0] out_quad,
   output wire [69:0] out_wide,
   input [1:0]        in_small,
   input [39:0]       in_quad,
   input [69:0]       in_wide,
	input [15:0] l_s,
	input [15:0] r_s,
	input [15:0] s_s,
	input ex,
	input lohipass,
	input fwd_inv
   );
/* verilator lint_off UNUSEDSIGNAL */   
wire [3:0] q;
/* verilator lint_off UNUSEDSIGNAL */
counter counter (.clk(clk), .q(q));

reg host_intf_rst_i;
/* verilator lint_off UNDRIVEN */
wire host_intf_rd_i;
wire host_intf_wr_i;
wire [23:0] host_intf_addr_i;
wire [15:0] host_intf_data_i;
wire [15:0] host_intf_data_o;
wire host_intf_done_o;
wire host_intf_rdPending_o;
wire sd_intf_cke;
wire sd_intf_cs;
wire sd_intf_cas;
wire sd_intf_ras;
wire sd_intf_we;
wire [1:0] sd_intf_bs;
wire [12:0] sd_intf_addr;
wire sd_intf_dqml;
wire sd_intf_dqmh;
wire [15:0] sd_intf_dq;
/* verilator lint_off UNDRIVEN */
sdram_cntl sdrami(
    clk,
    host_intf_rst_i,
    host_intf_rd_i,
    host_intf_wr_i,
    host_intf_addr_i,
    host_intf_data_i,
    host_intf_data_o,
    host_intf_done_o,
    host_intf_rdPending_o,
    sd_intf_cke,
    sd_intf_cs,
    sd_intf_cas,
    sd_intf_ras,
    sd_intf_we,
    sd_intf_bs,
    sd_intf_addr,
    sd_intf_dqml,
    sd_intf_dqmh,
    sd_intf_dq
);

wire [15:0] res_s;

jpeg jpeg0 (
    clk,
    l_s,
    r_s,
    s_s,
    res_s,
    lohipass,
    fwd_inv,
    ex
);
myreset myreseti(
    clk,
    reset_l,
    host_intf_rst_i
);
   // Connect up the outputs, using some trivial logic
   assign out_small = ~reset_l ? '0 : (in_small + 2'b1);
   assign out_quad  = ~reset_l ? '0 : (in_quad + 40'b1);
   assign out_wide  = ~reset_l ? '0 : (in_wide + 70'b1);


   // And an example sub module. The submodule will print stuff.
   sub sub (/*AUTOINST*/
            // Inputs
            .clk                        (clk),
            .reset_l                    (reset_l));

   // Print some stuff as an example
   initial begin
      if ($test$plusargs("trace") != 0) begin
         $display("[%0t] Tracing to logs/vlt_dump.vcd...\n", $time);
         $dumpfile("logs/vlt_dump.vcd");
         $dumpvars();
      end
      $display("[%0t] Model running...\n", $time);
   end

endmodule
