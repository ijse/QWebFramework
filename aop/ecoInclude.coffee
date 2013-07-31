
eco = require "eco"
fs = require "fs"
path = require "path"

module.exports = (app)->
	app.locals.include = (file, thisView)->

		thisView = @filename if not thisView

		# __log ">>>>>>", @
		# __log ">>>>>>>>>>>>", file
		
		if file[0] isnt "/"
			filePath = path.join path.dirname(thisView), file
		else
			filePath = path.join @settings.views, file

		html = eco.render(fs.readFileSync(filePath, "utf-8"), __utils.extend(@, {filename: filePath}) )

		return html
	return
