mongoose = require('mongoose')
mongoose.connect process.env.MONGODB_URL

ChatLogSchema = mongoose.Schema
  name: String,
  content: String,
  createdAt:
    type: Date,
    index: true,
    default: Date.now


exports.ChatLog = mongoose.model 'chatlog', ChatLogSchema
