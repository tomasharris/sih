assert        = require 'assert'
Performance   = require './Performance'

#
# PerformanceList   represents a list of performances and generates an optimal schedule
#
module.exports = class PerformanceList

  #
  # @param    performancesJson  Array<PerformancePojo>     Array of PerformancePojos
  #
  @fromPojoArray: (performancesJsonArray) ->
    perfList = new @()
    for performancePojo in performancesJsonArray
      perfList.add(Performance.fromPojo(performancePojo))
    return perfList

  constructor: ->
    @performanceList = []

  add: (performances...) ->
    for perf in performances
      assert(perf instanceof Performance, 'Must pass instance of performance')
      @performanceList.push perf

  _orderByPriority: (perfs) ->
    byPriority = perfs.slice()
    return byPriority.sort (perf1, perf2) ->
      perf2.priority > perf1.priority

  _getPlaying: (perfs, dateTime) ->
    return perfs.filter (perf) ->
      return perf.isOn(dateTime)

  _getStartTime: (perfs) ->
    byStartTime = perfs.slice()
    byStartTime.sort (perf1, perf2) ->
      perf1.start.getTime() - perf2.start.getTime()
    return byStartTime[0].start

  _getFinishTime: (perfs) ->
    btyFinishTime = perfs.slice()
    btyFinishTime.sort (perf1, perf2) ->
      perf2.finish.getTime() - perf1.finish.getTime()
    return btyFinishTime[0].finish

  getOptimalSchedule: ->
    startTime = @_getStartTime(@performanceList)
    finishTime = @_getFinishTime(@performanceList)
    byPriority = @_orderByPriority(@performanceList)
    schedule = []
    while startTime <= finishTime
      playing = @_getPlaying(byPriority, startTime)
      top = playing[0]
      # top maybe undefined because there is no event on at that time
      if top and schedule[schedule.length-1] isnt top
        schedule.push top
      # go to next minute
      startTime.setTime(startTime.getTime() + 1000 * 60)

    return schedule
