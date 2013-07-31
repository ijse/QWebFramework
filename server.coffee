
express = require 'express'
http    = require 'http'
coffee  = require 'coffee-script'
path    = require 'path'
mongo   = require 'mongoskin'
cons    = require 'consolidate'
tracer  = require 'tracer'

global.__utils  = require './utils'

# Load config file##########################
config = require './config.coffee'
if 'development' is process.env.NODE_ENV
	config = __utils.extend(config, require './config.debug.coffee')
############################################


# Global setting############################
global.__config = config
global.__mysql  = null
global.__mongo  = null
global.__logger = tracer[config.log.console](config.log)
global.__log    = __logger.log
global.__trace  = __logger.trace
global.__debug  = __logger.debug
global.__info   = __logger.info
global.__warn   = __logger.warn
global.__error  = __logger.error
global.__aops   = require './aop'
############################################


# Mongo setting#############################

# Connect to databases
# Mongo
global.__mongo = mongo.db(__config.database.mongo.url, __config.database.mongo.option)

# MySql
global.__mysql = null

dalMap = {}
__utils.directory.traverseFolderSync __config.dal, /^[._]/, (isErr, file)->
	throw "Load dal failed!" if isErr
	dalName = path.basename file, path.extname(file)
	dalMap[dalName] = require(file)

global.__dals = dalMap
############################################


# App setting###############################
app = express()
app.set 'config', config

# Set default view extension
app.engine "html", cons[config.viewEngine]
app.engine "eco", cons[config.viewEngine]
app.set 'views', config.views
app.set 'view engine', config.viewEngine

app.use express.favicon()
app.use express.logger('dev')

app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser(config.cookieSecret)
app.use express.session()

# TODO: auth middleware

__aops.beforeRouter(app)
app.use app.router
__aops.afterRouter(app)

app.use express.static(config.public)

# TODO: 
if 'development' == app.get('env')
	app.use express.errorHandler()

############################################


# 自动载入所有routes##########################
# TODO: file must be .js/.coffee type
__utils.directory.traverseFolderSync config.routes, /^[._]/, (isErr, file)->
	throw "Load routes failed!" if isErr
	require(file)(app)
############################################


server = http.createServer(app)
server.listen config.port, ->
	console.log('JetServer start up on port ' + config.port)



