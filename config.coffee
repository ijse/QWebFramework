module.exports = {

	port: 3000
	cookieSecret: 'buckyball'

	views: __dirname + '/views'
	viewEngine: 'ejs'

	public: __dirname + '/public'

	routes: __dirname + '/routes'

	less: {
		src: __dirname + '/public'
		useTmpDir: false
		debug: true
		force: true
		optimization: 1
		compress: true
		dumpLineNumbers: "mediaquery"
	}
	coffee: {
		src: __dirname + '/public'
		useTmpDir: true
		debug: true
		force: true
		once: false
		prefix: ""
	}

	dal: __dirname + "/dal"
	database: {
		mysql: {}
		mongo: {}
	}

	log: {
		console: "colorConsole"
		level: "warn"
	}

}