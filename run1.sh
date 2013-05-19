#!/usr/bin/env sh
export MONGODB_URL='mongodb://ktmt:github@ds051447.mongolab.com:51447/chatlog'
NODE_ENV=production coffee app.coffee
