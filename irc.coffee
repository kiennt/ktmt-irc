irc = require('irc')

module.exports = (app) ->
  options =
    nick:     process.env.IRC_NICK
    realName: process.env.IRC_REALNAME
    rooms:    process.env.IRC_ROOMS.split(",")
    server:   process.env.IRC_SERVER

  client_options =
    userName: options.nick
    realName: options.nick

  client_options['channels'] = options.rooms

  bot = new irc.Client options.server, options.nick, client_options

  bot.addListener 'message', (from, to, message) ->
    if options.nick.toLowerCase() == to.toLowerCase()
      # this is a private message, let the 'pm' listener handle it
      return

    console.log "From #{from} to #{to}: #{message}"
    app.io.sockets.emit 'message',
      name: from, content: message, createdAt: new Date()

  bot.addListener 'error', (message) ->
    console.error('ERROR: %s: %s', message.command, message.args.join(' '))

  bot.addListener 'pm', (nick, message) ->
    console.log('Got private message from %s: %s', nick, message)

  bot.addListener 'join', (channel, who) ->
    console.log('%s has joined %s', who, channel)

  bot.addListener 'part', (channel, who, reason) ->
    console.log('%s has left %s: %s', who, channel, reason)

  bot.addListener 'kick', (channel, who, _by, reason) ->
    console.log('%s was kicked from %s by %s: %s', who, channel, _by, reason)

  bot.addListener 'invite', (channel, from) ->
    console.log('%s invite you to join %s', from, channel)
