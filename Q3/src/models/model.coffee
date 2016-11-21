{EventEmitter} = require 'events'

module.exports = class Model extends EventEmitter
  constructor: (args = {}) ->

    @properties ?= args # shortcut for loading data: new Model { name: 'Fry' }

    for key, value of @properties then do (key, value) =>
      Object.defineProperty this, key,
        enumerable: yes
        get: => @properties[key]
        set: (value) =>
          return if value is @properties[key]
          @properties[key] = value
          @emit 'change', key, value
          @emit 'change:' + key, value  # backbone style
