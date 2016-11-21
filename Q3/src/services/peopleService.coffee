module.exports = class PeopleService

  constructor: (@superagent, @endpointStr) ->
    return @

  getPeople: ->
    @_fetchPeople()
    .then (peoplePojos) =>
      Promise.all [
        @_fetchSkills(peoplePojos)
        @_fetchInterests(peoplePojos)
        @_fetchRichest(peoplePojos)
      ]
      .then ->
        return peoplePojos

  _fetchPeople: ->
    @_fetch 'people'

  _fetchRichest: (peoplePojos) ->
    @_fetch 'richest'
    .then (richestObj) ->
      for person in peoplePojos
        if person.id is richestObj['richestPerson'].toString()
          person.richest = true


  _fetchSkills: (peoplePojos) ->
    ids = peoplePojos.map (p) -> p.id
    @_fetch 'skills', personIds: ids.join(',')
    .then (skillsArr) ->
      skillMap = {}
      for skill in skillsArr
        skillMap[skill.personId] ?= []
        skillMap[skill.personId].push skill.name
      for person in peoplePojos
        if pSkills = skillMap[person.id]
          person.skills = pSkills

  _fetchInterests: (peoplePojos) ->
    ids = peoplePojos.map (p) -> p.id
    @_fetch 'interests', personIds: ids.join(',')
    .then (interestsArr) ->
      interestMap = {}
      for interest in interestsArr
        interestMap[interest.personId] ?= []
        interestMap[interest.personId].push interest.name
      for person in peoplePojos
        if pInterests = interestMap[person.id]
          person.interests = pInterests

  _fetch: (path, query) ->
    @superagent
      .get(@endpointStr + '/' + path)
      .query(query)
      .then (res) ->
        return res.body
