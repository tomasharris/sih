View = require './view'
QueryView = require './queryView'
UserListView = require './userListView'


module.exports = class AppView extends View
  constructor: (store) ->
    @model = store

    @dom = $ 'body'

    @components =
      query:    new QueryView(@model.query)
      userList: new UserListView(@model.userList)

    super
    return @

