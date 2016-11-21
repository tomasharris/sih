Model = require './model'

module.exports = class Person extends Model

  @fromPojo: (pojo) ->
    return new @(pojo.id, pojo.name, pojo.org, pojo.skills, pojo.interests, pojo.richest)

  constructor: (id, name, org, skills = [], interests = [], richest = false) ->
    @properties =
      id: id
      name: name
      org: org
      skills: skills
      interests: interests
      richest: richest

    super
