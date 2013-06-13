App = window.App

App.MessagesController = Ember.Controller.extend
  messages: App.Messages

  isRealtimeMessage: true

  users: App.ChatUsers

  cachedMessages: []

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

  toggleRealtime: ->
    @set('isRealtimeMessage', not @get('isRealtimeMessage'))
    if @get('isRealtimeMessage')
      for message in @cachedMessages
        App.Messages.pushObject Ember.Object.create(message)
        App.Messages.calculateName()
        $(window).scrollTop($(document).height() + 100)
      @cachedMessages = []

  initMessages: ->
    @messages.set('content', [])
    @loadMessagesWithEndDate('')

  init: ->
    self = this

    @socket = io.connect(window.location.hostname, {'sync disconnect on unload' : true})

    @socket.on 'users', (data) ->
      App.User.set('totalUsers', data.total)

    @socket.on 'message', (data) ->
      if self.get('isRealtimeMessage')
        App.Messages.pushObject Ember.Object.create(data)
        App.Messages.calculateName()
        $(window).scrollTop($(document).height() + 100)
      else
        self.cachedMessages.push(data)

    @socket.on 'chatusers', (data) ->
      if data.message == 'init'
        for name in data.names
          App.ChatUsers.createUser(name)
      else if data.message == 'join'
        App.ChatUsers.createUser(data.name)
      else if data.message == 'left'
        App.ChatUsers.removeUser(data.name)
