module jar_sram_top 
# (
	parameter AW = 4, // address width
	parameter DW = 8, // data width
	parameter DEPTH = 16 // number of bytes
)
(
	input  [DW-1:0] io_in,
	output [DW-1:0] io_out
);
	// Shared address and data input.
	// When writing, low data bits first, then high bits, then address
	wire             clk    = io_in[0]; // Clock
	wire             we     = io_in[1]; // Write Enable
	wire             oe     = io_in[2]; // Output Enable
	wire             commit = io_in[3]; // Commit to memory
	wire [AW-1:0] addr_data = io_in[DW-1:DW-AW];

	reg [DW-1:0] data_tmp;
	reg [DW-1:0] mem [DEPTH];
	reg [AW-1:0] stream_index;

	wire stream = we & oe;
	wire reset = stream & commit;

	always @(posedge clk) begin
		if (reset) begin
			stream_index <= addr_data;
		end
		else if (stream) begin
			data_tmp <= mem[stream_index];
			stream_index <= stream_index + 1;
		end
		else if (we) begin
			data_tmp <= {addr_data, data_tmp[DW-1:AW]};
		end
		else if (oe) begin
			data_tmp <= mem[addr_data];
		end
		else if (commit) begin
			mem[addr_data] <= data_tmp;
		end
	end

	assign io_out = (oe) ? data_tmp : 8'b0000_0000;
endmodule
