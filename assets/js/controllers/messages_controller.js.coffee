App = window.App

App.MessagesController = Ember.ArrayController.extend
  isLoading: true,
  lastTime: '',

  calculateShowName: ->
    oldMsg = {}
    for i in [0..@get('content').length - 1]
      @get('content')[i].set('isShowName', @get('content')[i].name != oldMsg.name)
      oldMsg = @get('content')[i]

  loadMessagesWithEndDate: (endDate) ->
    self = this
    self.set('isLoading', true)
    $.getJSON '/messages', { end: endDate }, (data) ->
      for msg in data
        self.insertAt(0, Ember.Object.create(msg))
      self.calculateShowName()
      self.set('lastTime', data[data.length - 1].createdAt)
      self.set('isLoading', false)

  loadHistory: ->
    @loadMessagesWithEndDate(@get('lastTime'))

  initMessages: ->
    @set('content', [])
    @loadMessagesWithEndDate('')
