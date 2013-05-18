var mongoose = require('mongoose')
mongoose.connect(process.env.MONGODB_URL)

var ChatLogSchema = mongoose.Schema({
  name: String,
  content: String,
  createdAt: { type: Date, index: true, default: Date.now }
})

exports.ChatLog = mongoose.model('chatlog', ChatLogSchema)
