
module.exports = (app)->

	app.get /^\/(index\.html)?$/, (req, res)->

		__dals.user.regist {
			name: "dog",
			sex: "1"
		}, (err, user)->
			#res.end "" + JSON.stringify(user)
			__log "hello, ", arguments

		res.render('index')
		# res.render('layout/main.ejs', {})
