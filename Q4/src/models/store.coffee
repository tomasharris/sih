debounce  = require '../utils/debounce'

Model     = require './model'
Query     = require './query'
UserList  = require './collections/userList'

module.exports = class Store extends Model

  constructor: (@userService) ->
    @initUserList()
    super

  initUserList: ->
    @query = query = new Query()
    @userList = userList = new UserList()
    dbFetch = debounce =>
      search = query.search
      @userService.getUsers(query.search)
      .then (users) ->
        unless search isnt query.search
          query.loading = false
          userList.empty()
          for user in users
            userList.add user
    , 1000 # debounce searches for 1 second

    query.on 'change:search', ->
      if query.search and query.search.length >= 3
        query.loading = true
        dbFetch()
      else
        userList.empty()





