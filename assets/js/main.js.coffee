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
