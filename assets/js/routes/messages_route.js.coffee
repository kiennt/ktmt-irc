App = window.App

App.MessagesRoute = Ember.Route.extend
  setupController: (controller, model) ->
    controller.initMessages()
