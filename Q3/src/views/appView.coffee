View = require './view'
PeopleListView = require './peopleListView'

module.exports = class AppView extends View
  constructor: (store) ->
    @model = store

    @dom = $ 'body'

    @components =
      peopleList: new PeopleListView(@model.peopleList)

    super
    return @

