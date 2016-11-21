View = require './view'

module.exports = class UserView extends View
  constructor: (user) ->
    @model = user

    @dom = $ '<tr>'

    @components =
      avatar:   $ "<td><img class='avatar' src='#{user.avatarUrl}'/></td>"
      login:    $ "<td>#{user.login}</td>"
      type:     $ "<td>#{user.type}</td>"
      score:    $ "<td>#{user.score}</td>"

    super
    return this

  render: ->
    @appendComponents()
