Model = require './model'
Person = require './person'
PeopleList = require './collections/peopleList'

module.exports = class Store extends Model

  constructor: (@peopleService) ->
    @initPeopleList()

    super
    return @

  initPeopleList: ->
    @peopleList = peopleList = new PeopleList()
    @peopleService.getPeople()
    .then (peopleArr) ->
      for person in peopleArr
        peopleList.add px = Person.fromPojo(person)
