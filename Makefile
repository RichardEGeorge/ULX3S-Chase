clean:
	rm -rf blinky.json ulx3s_out.config ulx3s.bit

ulx3s.bit: ulx3s_out.config
	ecppack ulx3s_out.config ulx3s.bit

ulx3s_out.config: blinky.json
	nextpnr-ecp5 --85k --json blinky.json \
		--lpf ulx3s_v20.lpf \
		--textcfg ulx3s_out.config 

blinky.json: blinky.ys blinky.v
	yosys blinky.ys 

prog: ulx3s.bit
	fujprog ulx3s.bit
