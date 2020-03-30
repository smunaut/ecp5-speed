#!/usr/bin/env python3

for n,c in ctx.cells:
	if 'BEL_X' in c.attrs:
		x = int(c.attrs['BEL_X'], 2)
		y = int(c.attrs['BEL_Y'], 2)

		c.setAttr('BEL', 'X%d/Y%d/SLICEA' % (x, y))

		c.unsetAttr('BEL_X')
		c.unsetAttr('BEL_Y')
