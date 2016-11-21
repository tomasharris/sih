View = require './view'
PersonView = require './personView'

module.exports = class PeopleListView extends View

  constructor: (peopleList) ->
    @collection = peopleList
　
    @dom = $ '<table class="people-list"></table>'

    @components =
      th:          $ '<thead><tr><th>Name</th><th>Company</th><th>Skills</th><th>Interests</th></tr></thead>'
      tb:          $ '<tbody></tbody>'

    @collection.each @addPerson

    @listeners =
      'add': @addPerson

    super
    return this

  addPerson: (person) =>
    row = new PersonView(person)
    row.render()
    row.dom.appendTo @components.tb


