require './setup'

assert      = require 'assert'
PersonView  = require.main.require 'src/views/personView'
Person      = require.main.require 'src/models/person'

describe 'Person View', ->

  person = null
  personView = null

  beforeEach ->
    person = new Person(1, 'testName', 'testOrg', ['skill1', 'skill2'])
    personView = new PersonView(person)
    personView.render()

  it 'bound to person', ->
    assert.equal(personView.model, person)

  describe 'bindings', ->
    it 'name', ->
      assert.equal(personView.components.name.text(), 'testName')

    it 'skills', ->
      assert.equal(personView.components.skills.text(), 'skill1, skill2')

    it 'richest on change', ->
      person.richest = true
      assert(personView.dom.hasClass('richest'))

