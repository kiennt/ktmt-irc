express = require('express')
messages = require('./routes/messages')
http = require('http')
path = require('path')
mincer = require('mincer')

app = express()
server = http.createServer(app)
io = require('socket.io').listen(server)

environment = new mincer.Environment()
environment.appendPath('assets')
environment.appendPath('assets/js')
environment.appendPath('assets/css')

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
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

# Heroku won't actually allow us to use WebSockets
# so we have to setup polling instead.
# https://devcenter.heroku.com/articles/using-socket-io-with-node-js-on-heroku
io.configure () ->
  io.set("transports", ["xhr-polling"])
  io.set("polling duration", 10)

countUsers = 0
io.sockets.on 'connection', (socket) ->
  countUsers += 1
  io.sockets.emit('users', {total: countUsers})

  socket.on 'disconnect', ->
    countUsers -= 1
    io.sockets.emit('users', {total: countUsers})

server.listen app.get('port'), ->
  console.log "Express server listening on port " + app.get('port')
