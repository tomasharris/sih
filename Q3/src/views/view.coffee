{EventEmitter} = require('events')

module.exports = class View extends EventEmitter

  constructor: ->
    @source = source = @collection or @model

    unless source
      throw new Error('View does not have a source.')

    # If you want the view to execute a function on an event emitted from
    # the source, create a @listeners object on the view and give it properties
    # in the form of
    # `@listeners =
    #   eventName: (whatYouWant) -> ...`
    @listeners ?= {}
    for eventName, fn of @listeners
      source.on eventName, fn

    # If the source has a property that emits a `change` event when it is set
    # then you can simply add a property to the view in the form of
    # `key: (key, value, source, view) -> ...`
    #
    # As a style guide, and to help separate what should and shouldn't be done
    # based on source changes; changes should only affect the display of
    # component elements.
    @changes ?= {}
    for k, changeFn of @changes then do (k, changeFn) ->
      source.on "change:#{k}", changeFn

    source.on 'destroy', @destroy

  appendComponents: =>
    for name, el of @components
      if el.render?
        # view
        @dom.append el.render()
      else if el instanceof jQuery
        # regular jQuery component
        @dom.append el
      else
        # just a string
        @dom.append el
    return @dom

  # default render. overwrite as required
  render: =>
    @dom.empty()
    @appendComponents()
    @visible = true
    return @dom

  destroy: =>
    @emit 'destroy'
    @dom.remove()
    for name, el of @components
      @destroyComponent el
    for eventName, fn of @listeners
      @source.removeListener eventName, fn
    for k, changeFn of @changes then do (k, changeFn) =>
      @source.removeListener "change:#{k}", changeFn

  # default show/hide/toggle dom. overwrite as required
  show: =>
    @visible = true
    @dom.show()

  hide: =>
    @visible = false
    @dom.hide()

  toggle: =>
    @dom.toggle arguments...
    @visible = @dom.is(':visible')

  addClass: (className) =>
    @dom.addClass className

  destroyComponent: (component) ->
    component.destroy?()
    if typeof component is 'object' and not component instanceof jQuery
      for k, c of component
        @destroyComponent c
