assert   = require 'assert'
User     = require.main.require 'src/models/user'


describe 'User', ->

  describe 'constructor', ->
    it 'defaults properties', ->
      user = new User('id', 'url', 'login', 'type', 'score')
      assert.equal(user.id, 'id')
      assert.equal(user.avatarUrl, 'url')
      assert.equal(user.login, 'login')
      assert.equal(user.type, 'type')
      assert.equal(user.score, 'score')

    it 'uses params', ->
      user = new User('id', 'url', 'login', 'type', 'score')
      assert.equal(user.id, 'id')
      assert.equal(user.avatarUrl, 'url')
      assert.equal(user.login, 'login')
      assert.equal(user.type, 'type')
      assert.equal(user.score, 'score')

  describe 'fromPojo', ->
    it 'constructs User', ->
      pojo = {id: 'id', avatar_url: 'url', login: 'login', type: 'type', score: 'score'}
      user = User.fromPojo(pojo)
      assert(user instanceof User)
      assert.equal(user.id, 'id')
      assert.equal(user.avatarUrl, 'url')
      assert.equal(user.login, 'login')
      assert.equal(user.type, 'type')
      assert.equal(user.score, 'score')
