assert            = require 'assert'
Performance       = require.main.require 'src/Performance/Performance'
PerformanceList   = require.main.require 'src/Performance/PerformanceList'

MockData          = require './MockData'

describe 'Performance', ->
  perfList = null
  beforeEach ->
    perfList = new PerformanceList()

  describe 'constructor', ->
    it 'sets members', ->
      assert(Array.isArray(perfList.performanceList))
      assert.equal(perfList.performanceList.length, 0)

  describe 'static methods', ->
    describe '@fromPojoArray', ->
      it 'asserts invalid pojo', ->
        assert.throws(-> PerformanceList.fromPojoArray([{}]))

      it 'returns instance of PerformanceList with performances', ->
        pojo = {band: '<name>', start: new Date(1), finish: new Date(1), priority: 0}
        pojo2 = {band: '<name>2', start: new Date(1), finish: new Date(1), priority: 0}
        perfList = PerformanceList.fromPojoArray([pojo, pojo2])
        assert(perfList instanceof PerformanceList)
        assert(perfList.performanceList[0] instanceof Performance)
        assert.equal(perfList.performanceList[0].band, pojo.band)
        assert.equal(perfList.performanceList[1].band, pojo2.band)

  describe 'add', ->
    it 'asserts performance', ->
      assert.throws(-> perfList.add({}))

    it 'pushes performance to the list', ->
      perf = new Performance('<band>', new Date(2), new Date(3), 0)
      perfList.add(perf)
      assert.equal(perfList.performanceList[0], perf)
      perf2 = new Performance('<band>', new Date(2), new Date(3), 0)
      perfList.add(perf2)
      assert.equal(perfList.performanceList[1], perf2)

  describe '_getPlaying', ->
    perf1 = null
    perf2 = null
    perf3 = null
    perf4 = null
    perf5 = null
    beforeEach ->
      perf1 = new Performance('<band>1', new Date(1), new Date(12), 0)
      perf2 = new Performance('<band>2', new Date(2), new Date(3), 1)
      perf3 = new Performance('<band>3', new Date(2), new Date(3), 0)
      perf4 = new Performance('<band>4', new Date(3), new Date(4), 2)
      perf5 = new Performance('<band>5', new Date(5), new Date(7), 10)
      perfList.add(perf1, perf2, perf3, perf4, perf5)

    it '1', ->
      active = perfList._getPlaying(perfList.performanceList, new Date(3))
      assert.equal(active[0], perf1)
      assert.equal(active[1], perf2)
      assert.equal(active[2], perf3)
      assert.equal(active[3], perf4)
      assert.equal(active.length, 4)

    it '2', ->
      active = perfList._getPlaying(perfList.performanceList, new Date(4))
      assert.equal(active[0], perf1)
      assert.equal(active[1], perf4)
      assert.equal(active.length, 2)

    it '3', ->
      active = perfList._getPlaying(perfList.performanceList, new Date(5))
      assert.equal(active[0], perf1)
      assert.equal(active[1], perf5)
      assert.equal(active.length, 2)

    it '4', ->
      active = perfList._getPlaying(perfList.performanceList, new Date(8))
      assert.equal(active[0], perf1)
      assert.equal(active.length, 1)

    it '5', ->
      active = perfList._getPlaying(perfList.performanceList, new Date(13))
      assert.equal(active.length, 0)

  describe '_orderByPriority', ->
    perf1 = null
    perf2 = null
    perf3 = null
    perf4 = null
    perf5 = null
    beforeEach ->
      perf1 = new Performance('<band>1', new Date(1), new Date(12), 0)
      perf2 = new Performance('<band>2', new Date(2), new Date(3), 1)
      perf3 = new Performance('<band>3', new Date(2), new Date(3), 0)
      perf4 = new Performance('<band>4', new Date(3), new Date(4), 2)
      perf5 = new Performance('<band>5', new Date(5), new Date(7), 10)

    it '1', ->
      perfList.add(perf3, perf4, perf5, perf1, perf2)
      ordered = perfList._orderByPriority(perfList.performanceList)
      assert.equal(ordered[0], perf5)
      assert.equal(ordered[1], perf4)
      assert.equal(ordered[2], perf2)
      assert.equal(ordered[3], perf3)
      assert.equal(ordered[4], perf1)
      assert.equal(ordered.length, 5)

    it '2', ->
      perfList.add(perf5, perf1, perf2, perf3, perf4)
      ordered = perfList._orderByPriority(perfList.performanceList)
      assert.equal(ordered[0], perf5)
      assert.equal(ordered[1], perf4)
      assert.equal(ordered[2], perf2)
      assert.equal(ordered[3], perf1)
      assert.equal(ordered[4], perf3)
      assert.equal(ordered.length, 5)

    it '3', ->
      perfList.add(perf5, perf3, perf2)
      ordered = perfList._orderByPriority(perfList.performanceList)
      assert.equal(ordered[0], perf5)
      assert.equal(ordered[1], perf2)
      assert.equal(ordered[2], perf3)
      assert.equal(ordered.length, 3)


  describe '_getStartTime', ->
    it '1', ->
      perf1 = new Performance('<band>1', new Date(1), new Date(12), 0)
      perf2 = new Performance('<band>2', new Date(2), new Date(3), 1)
      perf3 = new Performance('<band>3', new Date(2), new Date(3), 0)
      perf4 = new Performance('<band>4', new Date(3), new Date(4), 2)
      perf5 = new Performance('<band>5', new Date(5), new Date(7), 10)
      perfList.add(perf3, perf4, perf5, perf1, perf2)
      startTime = perfList._getStartTime(perfList.performanceList)
      assert.equal(startTime.getTime(), new Date(1).getTime())

    it '2', ->
      perf4 = new Performance('<band>4', new Date(3), new Date(4), 2)
      perf5 = new Performance('<band>5', new Date(5), new Date(7), 10)
      perfList.add(perf4, perf5)
      startTime = perfList._getStartTime(perfList.performanceList)
      assert.equal(startTime.getTime(), new Date(3).getTime())

  describe '_getFinishTime', ->
    it '1', ->
      perf1 = new Performance('<band>1', new Date(1), new Date(12), 0)
      perf2 = new Performance('<band>2', new Date(2), new Date(3), 1)
      perf3 = new Performance('<band>3', new Date(2), new Date(3), 0)
      perf4 = new Performance('<band>4', new Date(3), new Date(4), 2)
      perf5 = new Performance('<band>5', new Date(5), new Date(7), 10)
      perfList.add(perf3, perf4, perf5, perf1, perf2)
      finishTime = perfList._getFinishTime(perfList.performanceList)
      assert.equal(finishTime.getTime(), new Date(12).getTime())

    it '2', ->
      perf4 = new Performance('<band>4', new Date(3), new Date(4), 2)
      perf5 = new Performance('<band>5', new Date(5), new Date(7), 10)
      perfList.add(perf4, perf5)
      finishTime = perfList._getFinishTime(perfList.performanceList)
      assert.equal(finishTime.getTime(), new Date(7).getTime())

  describe 'getOptimalSchedule', ->
    it 'no gaps, return to band1', ->
      perf1 = new Performance('<band>1', new Date(1 * 1000 * 60), new Date(12 * 1000 * 60), 0)
      perf2 = new Performance('<band>2', new Date(2 * 1000 * 60), new Date(3 * 1000 * 60), 1)
      perf3 = new Performance('<band>3', new Date(2 * 1000 * 60), new Date(3 * 1000 * 60), 0)
      perf4 = new Performance('<band>4', new Date(3 * 1000 * 60), new Date(4 * 1000 * 60), 2)
      perf5 = new Performance('<band>5', new Date(5 * 1000 * 60), new Date(7 * 1000 * 60), 10)
      perfList.add(perf3, perf4, perf5, perf1, perf2)
      schedule = perfList.getOptimalSchedule()
      assert.equal(schedule[0], perf1)
      assert.equal(schedule[1], perf2)
      assert.equal(schedule[2], perf4)
      assert.equal(schedule[3], perf5)
      assert.equal(schedule[4], perf1)
      assert.equal(schedule.length, 5)

    it 'gap, return to band 1 twice', ->
      perf1 = new Performance('<band>1', new Date(1 * 1000 * 60), new Date(12 * 1000 * 60), 0)
      perf2 = new Performance('<band>2', new Date(2 * 1000 * 60), new Date(3 * 1000 * 60), 1)
      perf3 = new Performance('<band>3', new Date(2 * 1000 * 60), new Date(3 * 1000 * 60), 0)
      perf4 = new Performance('<band>4', new Date(3 * 1000 * 60), new Date(4 * 1000 * 60), 2)
      perf5 = new Performance('<band>5', new Date(6 * 1000 * 60), new Date(7 * 1000 * 60), 10)
      perfList.add(perf3, perf4, perf5, perf1, perf2)
      schedule = perfList.getOptimalSchedule()
      assert.equal(schedule[0], perf1)
      assert.equal(schedule[1], perf2)
      assert.equal(schedule[2], perf4)
      assert.equal(schedule[3], perf1)
      assert.equal(schedule[4], perf5)
      assert.equal(schedule[5], perf1)
      assert.equal(schedule.length, 6)

    it 'gap', ->
      perf2 = new Performance('<band>2', new Date(2 * 1000 * 60), new Date(3 * 1000 * 60), 1)
      perf3 = new Performance('<band>3', new Date(2 * 1000 * 60), new Date(3 * 1000 * 60), 0)
      perf4 = new Performance('<band>4', new Date(3 * 1000 * 60), new Date(4 * 1000 * 60), 2)
      perf5 = new Performance('<band>5', new Date(6 * 1000 * 60), new Date(7 * 1000 * 60), 10)
      perfList.add(perf3, perf4, perf5, perf2)
      schedule = perfList.getOptimalSchedule()
      assert.equal(schedule[0], perf2)
      assert.equal(schedule[1], perf4)
      assert.equal(schedule[2], perf5)
      assert.equal(schedule.length, 3)

    it 'same time, same priority', ->
      perf2 = new Performance('<band>2', new Date(2 * 1000 * 60), new Date(3 * 1000 * 60), 0)
      perf3 = new Performance('<band>3', new Date(2 * 1000 * 60), new Date(3 * 1000 * 60), 0)
      perf4 = new Performance('<band>4', new Date(3 * 1000 * 60), new Date(4 * 1000 * 60), 2)
      perf5 = new Performance('<band>5', new Date(6 * 1000 * 60), new Date(7 * 1000 * 60), 10)
      perfList.add(perf3, perf4, perf5, perf2)
      schedule = perfList.getOptimalSchedule()
      assert.equal(schedule[0], perf3)
      assert.equal(schedule[1], perf4)
      assert.equal(schedule[2], perf5)
      assert.equal(schedule.length, 3)

    it 'all of the above', ->
      # return twice to perf1
      perf1 = new Performance('<band>1', new Date(1 * 1000 * 60), new Date(12 * 1000 * 60), 0)
      perf2 = new Performance('<band>2', new Date(2 * 1000 * 60), new Date(3 * 1000 * 60), 1)
      perf3 = new Performance('<band>3', new Date(2 * 1000 * 60), new Date(3 * 1000 * 60), 0)
      perf4 = new Performance('<band>4', new Date(3 * 1000 * 60), new Date(4 * 1000 * 60), 2)
      # gap
      perf5 = new Performance('<band>5', new Date(6 * 1000 * 60), new Date(7 * 1000 * 60), 10)
      # dupe of perf3
      perf6 = new Performance('<band>6', new Date(2 * 1000 * 60), new Date(3 * 1000 * 60), 0)

      perfList.add(perf3, perf4, perf5, perf1, perf2, perf6)
      schedule = perfList.getOptimalSchedule()
      assert.equal(schedule[0], perf1)
      assert.equal(schedule[1], perf2)
      assert.equal(schedule[2], perf4)
      assert.equal(schedule[3], perf1)
      assert.equal(schedule[4], perf5)
      assert.equal(schedule[5], perf1)
      assert.equal(schedule.length, 6)

    it 'from MockData', ->
      perfList = PerformanceList.fromPojoArray(MockData)
      console.log '###Schedule###'
      for perf, i in perfList.getOptimalSchedule()
        console.log "#{i+1}. #{perf.band}"





