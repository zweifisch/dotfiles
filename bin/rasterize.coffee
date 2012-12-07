page = require('webpage').create()
system = require 'system'

if 2 <= phantom.args.length <= 3

	[address,output] = phantom.args

	page.viewportSize =
		width: 600
		height: 600

	if system.args.length is 3 and system.args[1].substr(-4) is ".pdf"
		size = system.args[2].split '*'
		if size.length is 2
			page.paperSize = 
				width: size[0]
				height: size[1]
				border: '0px'
		else
			page.paperSize = 
				format: system.args[2]
				orientation: 'portrait'
				border: '1cm'

	page.open address, (status)->
		if status isnt 'success'
			console.log 'Unable to load the address!'
			phantom.exit()
		else
			window.setTimeout (-> page.render output; phantom.exit()), 200

else
	console.log 'Usage: rasterize.coffee URL filename [paperwidth*paperheight|paperformat]'
	console.log '  paper (pdf output) examples: "5in*7.5in", "10cm*20cm", "A4", "Letter"'
	phantom.exit 1
