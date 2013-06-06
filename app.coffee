if process.env.NODETIME_ACCOUNT_KEY
  require('nodetime').profile
    accountKey: process.env.NODETIME_ACCOUNT_KEY,
    appName: 'ktmt-irc'

express = require('express')
http = require('http') path = require('path')
mincer = require('mincer')
messages = require('./routes/messages')

app = express()
server = http.createServer(app)

environment = new mincer.Environment()
environment.appendPath('assets')
environment.appendPath('assets/js')
environment.appendPath('assets/css')
environment.appendPath('assets/vendor')
environment.appendPath('libs')

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.basicAuth (usr, pwd)->
    (usr == process.env.IRCWEB_USERNAME && pwd == process.env.IRCWEB_PASSWORD)

  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, 'public'))
  app.use '/assets', mincer.createServer(environment)


app.configure 'development', ->
  app.use express.errorHandler()

app.get '/messages', messages.index

app.io = require('socket.io').listen(server)
require('./socket')(app, server)

require('./irc')(app)
server.listen app.get('port'), ->
  console.log "Express server listening on port " + app.get('port')
