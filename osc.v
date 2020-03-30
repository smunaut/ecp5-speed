module osc (
	output wire clk_out
);

	localparam integer LEN = 20;

	wire [LEN:0] ring_top;
	wire [LEN:0] ring_bot;
	wire ring_out;

	// Generating ring
	genvar i;
	generate
		for (i=0; i<LEN; i=i+1)
		begin
			(* BEL_X=i+2 *)
			(* BEL_Y=3 *)
			(* dont_touch *)
			(* noglobal *)
			TRELLIS_SLICE #(
				.LUT0_INITVAL(16'h0001)
			) ring_top_I (
				.A0(ring_top[i]),
				.B0(1'b0),
				.C0(1'b0),
				.D0(1'b0),
				.F0(ring_top[i+1])
			);

			(* BEL_X=i+2 *)
			(* BEL_Y=2 *)
			(* dont_touch *)
			(* noglobal *)
			TRELLIS_SLICE #(
				.LUT0_INITVAL(16'h0001)
			) ring_bot_I (
				.A0(ring_bot[i+1]),
				.B0(1'b0),
				.C0(1'b0),
				.D0(1'b0),
				.F0(ring_bot[i])
			);
		end
	endgenerate

	assign ring_top[0]   = ring_bot[0];
	assign ring_bot[LEN] = ring_top[LEN-1];
	assign ring_out = ring_top[LEN];

	// Clock output IO
	ODDRX1F out_ff_I (
		.D0(1'b1),
		.D1(1'b0),
		.RST(1'b0),
		.SCLK(ring_out),
		.Q(clk_out)
	);

endmodule
