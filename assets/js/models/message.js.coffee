App = window.App

App.Messages = Ember.ArrayController.create
  calculateName: ->
    oldMsg = {}
    messages = @get('content')
    for i in [0..messages.length - 1]
      @get('content')[i].set('isShowName', messages[i].name != oldMsg.name)
      oldMsg = messages[i]
