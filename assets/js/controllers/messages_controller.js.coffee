App = window.App

App.MessagesController = Ember.ArrayController.extend
  isLoading: true,

  setLastTime: (data) ->
    @set('lastTime', data[data.length - 1].createdAt)
    console.log(@get('lastTime'))

  loadHistory: ->
    self = this
    self.set('isLoading', true)
    $.getJSON '/messages', { end: @get('lastTime') }, (data) ->
      for msg in data
        self.insertAt(0, msg)
      self.setLastTime(data)
      self.set('isLoading', false)

  initMessages: ->
    self = this
    @set('content', [])
    $.getJSON '/messages', (data) ->
      self.setLastTime(data)
      data = data.reverse()
      for msg in data
        self.pushObject(msg)
      self.set('isLoading', false)
