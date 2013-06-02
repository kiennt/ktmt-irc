App = window.App

App.User = Ember.Object.create
  totalUsers: 1

App.ChatUsers = Ember.ArrayController.create
  content: []

  findUser: (name) ->
    for user in @get('content')
      if user.name == name
        return user

  createUser: (name) ->
    user = @findUser(name)
    if user == undefined
      @pushObject Ember.Object.create(name: name)

  removeUser: (name) ->
    user = @findUser(name)
    if user != undefined
      @removeObject(user)
