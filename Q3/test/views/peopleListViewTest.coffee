require './setup'

assert          = require 'assert'
PeopleListView  = require.main.require 'src/views/peopleListView'
Person          = require.main.require 'src/models/person'
PeopleList          = require.main.require 'src/models/collections/peopleList'

describe 'Person View', ->

  peopleList = null
  peopleListView = null

  beforeEach ->
    peopleList = new PeopleList()
    peopleListView = new PeopleListView(peopleList)
    peopleListView.render()

  it 'has table header', ->
    assert.equal(peopleListView.dom.children().length, 2)
    assert.equal(peopleListView.components.tb.children().length, 0)

  it 'renders each existing person', ->
    peopleList = new PeopleList()
    peopleList.add(new Person())
    peopleListView = new PeopleListView(peopleList)
    peopleListView.render()
    assert.equal(peopleListView.components.tb.children().length, 1)

  it 'binds add', ->
    peopleList.add(new Person())
    assert.equal(peopleListView.components.tb.children().length, 1)

  it 'binds remove', ->
    person = new Person()
    peopleList.add(person)
    assert.equal(peopleListView.components.tb.children().length, 1)
    peopleList.rem(person)
    assert.equal(peopleListView.components.tb.children().length, 0)





