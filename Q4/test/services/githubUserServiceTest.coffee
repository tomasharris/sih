assert              = require 'assert'
GithubUserService   = require.main.require 'src/services/githubUserService'
User                = require.main.require 'src/models/user'

users = [
  {id: 'id', avatar_url: 'url', login: 'login', type: 'type', score: 'score'}
]

mockAgent = {
  get: (endPoint) ->
    query: ->
      switch endPoint
        when 'test/search/users' then Promise.resolve({body: items: users})
}

describe 'Github User Service', ->
  githubUserService = null

  beforeEach ->
    githubUserService = new GithubUserService(mockAgent, endpoint = 'test')

  describe 'constructor', ->
    it 'inits cache', ->
      assert.deepEqual(githubUserService.cache, {})

    it 'sets params as members', ->
      assert.equal(githubUserService.superagent, mockAgent)
      assert.equal(githubUserService.endpointStr, 'test')

  describe '_fetchUsers', ->
    it 'returns users', ->
      githubUserService._fetchUsers()
      .then (retUsers) ->
        assert.equal(retUsers, users)

    it 'caches', ->
      githubUserService._fetchUsers('search1')
      .then (retUsers) ->
        assert.equal(githubUserService.cache['search1'], users)

    it 'returns from caches', ->
      githubUserService.cache['search2'] = search2Res = []
      githubUserService._fetchUsers('search2')
      .then (retUsers) ->
        assert.equal(retUsers, search2Res)

  it 'getUsers', ->
    userArr = githubUserService.getUsers()
    .then (userArray) ->
      user = userArray[0]
      assert(user instanceof User)
      assert.equal(user.id, 'id')
      assert.equal(user.avatarUrl, 'url')
      assert.equal(user.login, 'login')
      assert.equal(user.type, 'type')
      assert.equal(user.score, 'score')
