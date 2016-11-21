User = require '../models/user'

module.exports = class GithubUserService

  constructor: (@superagent, @endpointStr) ->
    @cache = {}
    return @

  getUsers: (search) ->
    @_fetchUsers(search)
    .then (userPojos) ->
      return (User.fromPojo(user) for user in userPojos)

  _fetchUsers: (search) ->
    if cached = @cache[search]
      return Promise.resolve(cached)
    @_fetch 'users', q: search, per_page: 100
    .then (results) =>
      # bit of sneaky caching so we don't hit the limit
      @cache[search] = results
      return results

  _fetch: (path, query) ->
    @superagent
      .get(@endpointStr + '/search/' + path)
      .query(query)
      .then (res) ->
        return res.body.items
