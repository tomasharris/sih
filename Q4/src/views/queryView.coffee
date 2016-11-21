View = require './view'

module.exports = class QueryView extends View
  constructor: (query) ->
    @model = query

    @dom = $ '<div class="query">'

    @components =
      queryInput:   $ '<input type="text" placeholder="Seach gh..."/>'
      loader:       $ '''
        <span class="spinner">
          <div class="rect1"></div>
          <div class="rect2"></div>
          <div class="rect3"></div>
          <div class="rect4"></div>
          <div class="rect5"></div>
        </span>
      '''

    @changes =
      loading: @loading

    @components.queryInput.keyup @inputChange

    super
    return @

  render: ->
    @appendComponents()
    @components.queryInput.focus()
    @loading()
    return @dom

  inputChange: =>
    @model.search = @components.queryInput.val()

  loading: =>
    @components.loader.toggle(@model.loading)
