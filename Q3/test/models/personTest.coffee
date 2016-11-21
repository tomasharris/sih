assert     = require 'assert'
Person     = require.main.require 'src/models/person'

describe 'Person', ->

  describe 'constructor', ->
    it 'defaults properties', ->
      person = new Person('id', 'name', 'org')
      assert.equal(person.id, 'id')
      assert.equal(person.name, 'name')
      assert.equal(person.org, 'org')
      assert.deepEqual(person.skills, [])
      assert.deepEqual(person.interests, [])
      assert.equal(person.richest, false)

    it 'uses params', ->
      person = new Person('id', 'name', 'org', skills = [], interests = [], true)
      assert.equal(person.id, 'id')
      assert.equal(person.name, 'name')
      assert.equal(person.org, 'org')
      assert.deepEqual(person.skills, skills)
      assert.deepEqual(person.interests, interests)
      assert.equal(person.richest, true)

  describe 'fromPojo', ->
    it 'constructs Person', ->
      pojo = {id: 'id', name:'name', org: 'org', skills: [], interests: [], richest: true}
      person = Person.fromPojo(pojo)
      assert.equal(person.id, 'id')
      assert.equal(person.name, 'name')
      assert.equal(person.org, 'org')
      assert.deepEqual(person.skills, pojo.skills)
      assert.deepEqual(person.interests, pojo.interests)
      assert.equal(person.richest, true)

  describe 'events', ->
    it 'change skills', (done) ->
      person = new Person('id', 'name', 'org')
      person.on 'change:skills', ->
        done()
      person.skills = []

    it 'change richest', (done) ->
      person = new Person('id', 'name', 'org')
      person.on 'change:richest', ->
        done()
      person.richest = true
