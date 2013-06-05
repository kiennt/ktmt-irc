#= require ./lib/jquery
#= require ./lib/handlebars
#= require ./lib/ember
#= require ./lib/ember-data
#= require ./lib/socket.io
#= require ./main.js.coffee


String.prototype.endsWith = (suffix) ->
  return this.indexOf(suffix, this.length - suffix.length) != -1


isImage = (url) ->
  url.endsWith('.jpg') or url.endsWith('.jpeg') or url.endsWith('.gif') or url.endsWith('.png')


Ember.Handlebars.registerBoundHelper "urlify", (rawText) ->
  urlRegex = /(https?:\/\/[^\s]+)/g
  text = rawText.replace urlRegex, (url) ->
    if url.length > 30
      urlText = "#{url.substr(0, 27)}..."
    else
      urlText = url

    text = "<a target=\"_blank\" href=\"#{url}\">#{urlText}</a>"
    if isImage(url)
      text += "<br /><img src=\"#{url}\" width=200 />"
    text

  new Handlebars.SafeString text
