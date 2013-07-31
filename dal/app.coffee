
appCollection = __mongo.collection('app')

exports.add = (app, cb)->

	appCollection.findOne app, (err,result)->
		console.log(result + "++++++++++++++++++")
		if result
			cb(err, null)
		else
			appCollection.insert app, (err, app)->
				cb(err, app)

exports.list = (cb)->
	appCollection.find().toArray (err, apps)->
		cb(err, apps)