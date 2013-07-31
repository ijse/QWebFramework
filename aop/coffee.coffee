path = require 'path'
express = require 'express'
os = require 'os'
coffeeMiddleware   = require('coffee-middleware')

module.exports = (app)->
	config = app.get('config').coffee
	if config.useTmpDir
		config.dest = path.join os.tmpDir(), "tmpJs_" + Date.now()
		app.use express["static"](config.dest)

	return coffeeMiddleware(config)