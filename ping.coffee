sites = process.env.PING_SITES

if sites
  request = require('request')
  console.log(sites)
  for site in sites.split(',')
    request.get site, (error, response, body) ->
      console.log(body)
