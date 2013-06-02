#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./templates
#= require_tree ./routes
#= require      ./routes

window.App = App = Ember.Application.create({LOG_TRANSITIONS: true})

window.socket = socket = io.connect(window.location.hostname, {'sync disconnect on unload' : true})

socket.on 'users', (data) ->
  App.User.set('totalUsers', data.total)

socket.on 'message', (data) ->
  App.Messages.pushObject Ember.Object.create(data)
  App.Messages.calculateName()
  $(window).scrollTop($(document).height() + 100)

socket.on 'chatusers', (data) ->
  console.log(data)
  if data.message == 'init'
    for name in data.names
      App.ChatUsers.createUser(name)
  else if data.message == 'join'
    App.ChatUsers.createUser(name)
  else if data.message == 'left'
    App.ChatUsers.removeUser(name)
