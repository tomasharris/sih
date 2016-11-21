assert        = require 'assert'
Performance   = require.main.require 'src/Performance/Performance'

describe 'Performance', ->

  describe 'constructor', ->
    it 'asserts band', ->
      assert.throws(-> new Performance())

    it 'asserts start', ->
      assert.throws(-> new Performance('<band>'))

    it 'asserts finish', ->
      assert.throws(-> new Performance('<band>', new Date()))

    it 'asserts priority', ->
      assert.throws(-> new Performance('<band>', new Date(), new Date()))

    it 'sets members', ->
      name = '<band>'
      start = new Date(1)
      finish = new Date(2)
      priority = 5
      perf = new Performance(name, start, finish, priority)
      assert.equal(perf.band, name)
      assert.equal(perf.start, start)
      assert.equal(perf.finish, finish)
      assert.equal(perf.priority, priority)

  describe 'static methods', ->
    describe '@fromPojo', ->
      it 'asserts param', ->
        assert.throws(-> Performance.fromPojo())

      it 'asserts valid pojo', ->
        assert.throws(-> Performance.fromPojo({}))

      it 'returns instance of Performance', ->
        pojo = {band: '<name>', start: new Date(1), finish: new Date(1), priority: 0}
        perf = Performance.fromPojo(pojo)
        assert(perf instanceof Performance, 'Must pass instance of performance')
        assert.equal(perf.band, pojo.band)

  describe 'isOn', ->
    it 'start', ->
      current = new Performance('<band>', new Date(1), new Date(3), 0)
      assert(current.isOn(new Date(1)))
    it 'middle', ->
      current = new Performance('<band>', new Date(1), new Date(3), 0)
      assert(current.isOn(new Date(2)))
    it 'end', ->
      current = new Performance('<band>', new Date(1), new Date(3), 0)
      assert(current.isOn(new Date(3)))
