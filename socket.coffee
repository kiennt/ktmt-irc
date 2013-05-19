module.exports = (app, server) ->

  # Heroku won't actually allow us to use WebSockets
  # so we have to setup polling instead.
  # https://devcenter.heroku.com/articles/using-socket-io-with-node-js-on-heroku
  app.io.configure () ->
    app.io.set("transports", ["xhr-polling"])
    app.io.set("polling duration", 10)

  countUsers = 0
  app.io.sockets.on 'connection', (socket) ->

    # handle count user
    countUsers += 1
    app.io.sockets.emit('users', {total: countUsers})

    socket.on 'disconnect', ->
      countUsers -= 1
      app.io.sockets.emit('users', {total: countUsers})
