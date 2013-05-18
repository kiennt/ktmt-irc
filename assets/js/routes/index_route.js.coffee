App = window.App

App.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo('messages')
