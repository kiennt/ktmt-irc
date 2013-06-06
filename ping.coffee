request = require('request')
request 'http://ktmt-irc.herokuapp.com/', (error, response, body) ->
  console.log(body)

request 'http://streamslide-staging.herokuapp.com/', (error, response, body) ->
  console.log(body)
