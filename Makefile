
all: cl5a-v61.svf  oc-r01-25f.svf  oc-r02-85f.svf  ulx3s-12f.svf  ulx3s-45f.svf

clean:
	rm -f osc.json *.cfg *.svf

osc.json: osc.v
	yosys -p 'synth_ecp5 -top osc -json osc.json' osc.v

%.cfg: %.lpf osc.json
	nextpnr-ecp5 \
		--json osc.json \
		--pre-place osc.py \
		--ignore-loops \
		--textcfg $@ \
		--lpf $< \
		$(shell cat $< | head -n 1 | cut -c3-)

%.svf: %.cfg
	ecppack --compress --svf $@ $<

.PHONY: all clean
