{EventEmitter} = require 'events'

module.exports = class Collection extends EventEmitter
  constructor: ->
    @members = {}
    return @

  add: (member) ->
    id = member.id
    unless @members[id]?
      @members[id] = member
      @emit 'add', member
      return member

  rem: (member) ->
    if @members[member.id]?
      @emit 'rem', member
      member.emit 'destroy'
      delete @members[member.id]

  empty: ->
    for k, member of @members
      @rem(member)
    @emit 'empty', @

  get: (id) ->
    return @members[id]

  count: ->
    Object.keys(@members).length

  keys: ->
    Object.keys(@members)

  each: (f) ->
    for id, member of @members
      f(member)
