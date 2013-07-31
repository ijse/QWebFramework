
module.exports = (app)->
	app.get '/app/add.html', (req, res)->
		res.render('app/add', {app: ""})
		return

	app.post '/app/add.html', (req, res)->
		__dals.app.add {
				name: req.body
			}, (err, app)->
				__log(app + "____________________")
				if app is null
					res.render('app/add', {app: '应用已存在'})
				else
					res.render('app/add', {app: app[0].name})
		return

	app.get '/app/list.html', (req, res)->
		__dals.app.list (err, apps)->
			res.render('app/list', {apps: apps})
