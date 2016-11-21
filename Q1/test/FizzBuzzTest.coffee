assert      = require 'assert'
FizzBuzz    = require.main.require 'src/FizzBuzz'

describe 'FizzBuzz', ->

  describe '@buzzer', ->
    it 'mod 4 and 5', ->
      assert.equal(FizzBuzz.buzzer(20), 'HelloWorld')
      assert.equal(FizzBuzz.buzzer(40), 'HelloWorld')
      assert.equal(FizzBuzz.buzzer(100), 'HelloWorld')

    it 'mod 4', ->
      assert.equal(FizzBuzz.buzzer(4), 'Hello')
      assert.equal(FizzBuzz.buzzer(16), 'Hello')
      assert.equal(FizzBuzz.buzzer(96), 'Hello')

    it 'mod 5', ->
      assert.equal(FizzBuzz.buzzer(5), 'World')
      assert.equal(FizzBuzz.buzzer(30), 'World')
      assert.equal(FizzBuzz.buzzer(90), 'World')

    it 'else', ->
      assert.equal(FizzBuzz.buzzer(1), 1)
      assert.equal(FizzBuzz.buzzer(7), 7)
      assert.equal(FizzBuzz.buzzer(99), 99)

  describe '@print', ->
    it 'calls print callback for all in range', ->
      calls = 0
      printCB = ->
        calls++
      FizzBuzz.print(1, 100, printCB)
      assert.equal(calls, 100)

    it 'calls print with correct output', ->
      output = null
      printCB = (arg) ->
        output = arg
      FizzBuzz.print(20, 20, printCB)
      assert.equal(output, 'HelloWorld')


