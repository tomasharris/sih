View = require './view'
UserView = require './userView'

module.exports = class UserListView extends View

  constructor: (userList) ->
    console.log userList
    @collection = userList
　
    @dom = $ '<table class="user-list"></table>'

    # ### Components - eg. DOM elements & views
    @components =
      th:          $ '<thead><tr><th>Avatar</th><th>Login</th><th>Type</th><th>Score</th></tr></thead>'

    @collection.each @addUser

    @collection.on 'add', @addUser

    super
    return @

  addUser: (user) =>
    row = new UserView(user)
    row.render()
    row.dom.appendTo @dom


