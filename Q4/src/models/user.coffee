Model = require './model'

module.exports = class User extends Model

  @fromPojo: (pojo) ->
    return new @(pojo.id, pojo.avatar_url, pojo.login, pojo.type, pojo.score)

  constructor: (id, avatarUrl, login, type, score) ->
    @properties =
      id: id
      avatarUrl: avatarUrl
      login: login
      type: type
      score: score

    super
