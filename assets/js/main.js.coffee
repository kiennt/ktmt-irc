#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./templates
#= require_tree ./routes
#= require_tree ./helpers
#= require ./routes

window.App = App = Ember.Application.create({LOG_TRANSITIONS: true})
