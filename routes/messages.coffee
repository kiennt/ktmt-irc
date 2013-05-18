models = require('../models')

exports.index = (req, res) ->
  end = req.query.end || new Date()
  limit = req.query.limit || 200
  models.ChatLog.find()
      .where('createdAt').lt(end)
      .limit(limit)
      .sort('-createdAt')
      .exec (error, data) ->
    res.json(data)

