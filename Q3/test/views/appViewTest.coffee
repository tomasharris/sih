require './setup'

assert     = require 'assert'
AppView    = require.main.require 'src/views/appView'
Store      = require.main.require 'src/models/store'

describe 'App View', ->

  store = null
  appView = null

  beforeEach ->
    store = new Store({getPeople: -> Promise.resolve()})
    appView = new AppView(store)
    appView.render()

  it 'bound to store', ->
    assert.equal(appView.model, store)

  describe 'render', ->
    it 'Renders components', ->
      assert.equal(appView.dom.children().length, 1)
