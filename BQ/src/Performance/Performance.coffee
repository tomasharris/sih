assert = require 'assert'

module.exports = class Performance

  @fromPojo: (performancePojo) ->
    assert(performancePojo, 'Performance Data is required')
    return new @(performancePojo.band, performancePojo.start, performancePojo.finish, performancePojo.priority)
  #
  # @param    band         String     The band name
  # @param    start        Date       Start time of the bands set
  # @param    finish       Date       Finish  time of the bands set
  # @param    priority     Number     The priority of the performance
  #
  constructor: (@band, @start, @finish, @priority) ->
    assert(@band, 'Performance band name is required')
    assert(@start, 'Performance start time is required')
    assert(@finish, 'Performance finish time is required')
    assert(@priority > -1, 'Performance priority is required. Must be 0 or greater')

  isOn: (dateTime) ->
    return dateTime >= @start and dateTime <= @finish

