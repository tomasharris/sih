assert          = require 'assert'
PeopleService   = require.main.require 'src/services/peopleService'
PeopleData      = require '../mockData/peopleData'

people    = PeopleData.people()
interests = PeopleData.interests()
skills    = PeopleData.skills()
richest   = PeopleData.richest()

mockAgent = {
  get: (endPoint) ->
    query: ->
      switch endPoint
        when 'test/people' then Promise.resolve({body: people})
        when 'test/skills' then Promise.resolve({body: skills})
        when 'test/interests' then Promise.resolve({body: interests})
        when 'test/richest' then Promise.resolve({body: richest})
}

describe 'PeopleService', ->
  peopleService = null

  beforeEach ->
    peopleService = new PeopleService(mockAgent, endpoint = 'test')

  describe '_fetchPeople', ->
    it 'returns people', ->
      peopleService._fetchPeople()
      .then (retPeople) ->
        assert.equal(retPeople, people)

  describe '_fetchRichest', ->
    it 'sets richest in list', ->
      peopleService._fetchRichest([person = {id: '1'}])
      .then ->
        assert(person.richest)

  describe '_fetchSkills', ->
    it 'sets skills in list', ->
      peopleService._fetchSkills([person = {id: '1'}])
      .then ->
        assert.deepEqual(person.skills, ['C++', 'Basic', 'Monopoly'])

  describe '_fetchInterests', ->
    it 'sets interests in list', ->
      peopleService._fetchInterests([person = {id: '1'}])
      .then ->
        assert.deepEqual(person.interests, ['Skiing', 'Philanthropy'])

  it '_getPeople', ->
    peopleList = peopleService.getPeople()
    .then (peoplePojos) ->

      person = peoplePojos[0]
      assert.equal(person.name, 'Bill Gates')
      assert.equal(person.org, 'Microsoft')
      assert(person.richest)
      assert.deepEqual(person.skills, ['C++', 'Basic', 'Monopoly'])
      assert.deepEqual(person.interests, ['Skiing', 'Philanthropy'])
