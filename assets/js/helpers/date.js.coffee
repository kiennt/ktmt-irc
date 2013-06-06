zeroPad = (number) ->
  number = number + ''
  if number.length < 2 then '0' + number else number


isSameDate = (date1, date2) ->
  return date1.getYear() == date2.getYear() and date1.getMonth() == date2.getMonth() and date1.getDate() == date2.getDate()


Ember.Handlebars.registerBoundHelper "date", (dateString) ->
  console.log(dateString)
  months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
  currentDate = new Date()
  date = new Date(dateString)

  month = date.getMonth()
  day = date.getDate()
  hour = zeroPad date.getHours()
  minute = zeroPad date.getMinutes()

  if isSameDate(date, currentDate)
    "#{hour}:#{minute}"
  else
    "#{months[month]}-#{zeroPad(day)} #{hour}:#{minute}"
