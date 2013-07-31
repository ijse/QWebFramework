express = require 'express'
path = require 'path'
os = require 'os'
lessMiddleware   = require('less-middleware')

module.exports = (app)->
	config = app.get('config').less
	if config.useTmpDir
		config.dest = path.join os.tmpDir(), "tmpCss_" + Date.now()
		app.use express["static"](config.dest)

	return lessMiddleware(config)