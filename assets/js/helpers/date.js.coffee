zeroPad = (number) ->
  number = number + ''
  if number.length < 2 then '0' + number else number


Ember.Handlebars.registerBoundHelper "date", (dateString) ->
  console.log(dateString)
  months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
  currentDate = new Date()
  date = new Date(dateString)

  year = date.getYear()
  month = months[date.getMonth()]
  day = date.getDate()
  hour = zeroPad date.getHours()
  minute = zeroPad date.getMinutes()

  if year == currentDate.getYear() and month == currentDate.getMonth() and day == currentDate.getDate()
    "#{hour}:#{minute}"
  else
    "#{month}-#{zeroPad(day)} #{hour}:#{minute}"
