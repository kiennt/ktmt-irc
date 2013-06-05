Array.prototype.any ?= (f) ->
  (return true if f x) for x in @
  return false


String.prototype.endsWith = (suffix) ->
  return this.indexOf(suffix, this.length - suffix.length) != -1


String.prototype.isImage = () ->
  for suffix in ['.jpg', '.jpeg', '.gif', '.png']
    if this.endsWith(suffix)
      return true
  false
