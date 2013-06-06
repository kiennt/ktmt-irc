urlify = (rawText) ->
  urlRegex = /(https?:\/\/[^\s]+)/g
  rawText.replace urlRegex, (url) ->
    if url.length > 30
      urlText = "#{url.substr(0, 27)}..."
    else
      urlText = url

    text = "<a target=\"_blank\" href=\"#{url}\">#{urlText}</a>"
    if url.isImage()
      text += "<br /><img src=\"#{url}\" width=200 />"
    text

Ember.Handlebars.registerBoundHelper "urlify", (rawText) ->
  new Handlebars.SafeString urlify(rawText)
