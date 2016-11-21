module.exports = class FizzBuzz

  @print: (start, finish, printCb) ->
    for number in [start..finish]
      printCb FizzBuzz.buzzer(number)

  @buzzer: (number) ->
    if number % 4 is 0 and number % 5 is 0
      return 'HelloWorld'
    else if number % 4 is 0
      return 'Hello'
    else if number % 5 is 0
      return 'World'
    else
      return number
