#= require ./lib/jquery
#= require ./lib/handlebars
#= require ./lib/ember
#= require ./lib/ember-data
#= require ./lib/socket.io
#= require ./main.js.coffee


Handlebars.registerHelper "urlify", () ->
  urlRegex = /(https?:\/\/[^\s]+)/g
  text = this.content.replace urlRegex, (url) ->
    if url.length > 30
      urlText = url.substr(0, 27) + '...'
    '<a target="_blank" href="' + url + '">' + urlText + '</a>'
  new Handlebars.SafeString text
