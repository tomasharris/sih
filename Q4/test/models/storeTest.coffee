assert     = require 'assert'
Store      = require.main.require 'src/models/store'

describe 'Store', ->
  describe 'constructor', ->
    it 'userService member', ->
      store = new Store(userService = {getUsers: -> Promise.resolve()})
      assert.equal(store.userService, userService)

    it 'calls getUsers on query change', (done) ->
      store = new Store(userService = {getUsers: -> Promise.resolve(done())})
      store.query.search = 'asdf'

    it 'calls getUsers on query change adds users to @userList', (done) ->
      user = {id: 'id'}
      store = new Store(userService = {getUsers: -> Promise.resolve([user])})
      store.query.search = 'asdf'
      store.userList.on 'add', ->
        assert.equal(store.userList.get('id'), user)
        done()

