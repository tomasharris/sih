View = require './view'

module.exports = class PersonView extends View
  constructor: (person) ->
    @model = person

    @dom = $ '<tr>'

    @components =
      name:       $ "<td>#{person.name}</td>"
      company:    $ "<td>#{person.org}</td>"
      skills:     $ '<td></td>'
      interests:  $ '<td></td>'

    @changes =
      richest: @markAsRichest
      skills: @updateSkills
      interests: @updateInterests

    @markAsRichest()
    @updateSkills()
    @updateInterests()

    super
    return this

  render: ->
    @appendComponents()

  markAsRichest: =>
    @dom.toggleClass 'richest', @model.richest

  updateSkills: =>
    @components.skills.html @model.skills.join(', ')

  updateInterests: =>
    @components.interests.html @model.interests.join(', ')

