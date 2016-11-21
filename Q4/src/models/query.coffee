Model = require './model'

module.exports = class Query extends Model

  constructor: ->
    @properties =
      search: null
      loading: false

    super
