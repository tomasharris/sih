assert     = require 'assert'
Store      = require.main.require 'src/models/store'

describe 'Store', ->
  describe 'constructor', ->
    it 'peopleService member', ->
      store = new Store(peopleService = {getPeople: -> Promise.resolve()})
      assert.equal(store.peopleService, peopleService)

    it 'calls initPeopleList', (done) ->
      store = new Store(peopleService = {getPeople: -> Promise.resolve(done())})


