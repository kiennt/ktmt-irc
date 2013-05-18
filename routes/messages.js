var  models = require('../models');

exports.index = function(req, res) {
  var end = req.query.end || new Date();
  console.log(req.query.end);
  console.log(end);
  var limit = req.params.limit || 200;
  models.ChatLog.find()
      .where('createdAt').lt(end)
      .limit(limit)
      .sort('-createdAt')
      .exec(function(error, data) {
    res.json(data);
  });
}
