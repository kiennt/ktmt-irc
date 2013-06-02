App = window.App

App.MessagesController = Ember.Controller.extend
  messages: App.Messages

  users: App.ChatUsers

  isLoading: true

  lastTime: ''

  loadMessagesWithEndDate: (endDate) ->
    self = this
    self.set('isLoading', true)
    $.getJSON '/messages', { end: endDate }, (data) ->
      if data.length > 0
        for msg in data
          self.get('messages').insertAt(0, Ember.Object.create(msg))
        self.messages.calculateName()
        self.set('lastTime', data[data.length - 1].createdAt)
      self.set('isLoading', false)

  loadHistory: ->
    @loadMessagesWithEndDate(@get('lastTime'))

  initMessages: ->
    @messages.set('content', [])
    @loadMessagesWithEndDate('')
