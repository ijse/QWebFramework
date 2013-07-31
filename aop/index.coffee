
lessMiddleware   = require('./less')
coffeeMiddleware = require('./coffee')
ecoInclude = require("./ecoInclude")

# user defined middlewares
module.exports = {
	beforeRouter: (app)->
		ecoInclude(app)
		require('./menus')(app)
		require('./viewHelper')(app)
		return


	afterRouter: (app)->
		app.use coffeeMiddleware(app)
		app.use lessMiddleware(app)
		return 
}

