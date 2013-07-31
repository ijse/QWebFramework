

userCollection = __mongo.collection('user')

exports.regist = (user, cb)->

	user.registTime = Date.now()
	
	userCollection.insert user, cb