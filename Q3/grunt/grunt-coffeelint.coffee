module.exports = () ->
  return tasks =
    options:
      configFile: 'coffeelint.json'
    app: [
      'src/fantasy-core/coffee/**/*.coffee'
      # copied from squares 4 space indentation
      '!src/fantasy-core/coffee/pubsub/AbstractMessageListener.coffee'
      '!src/fantasy-core/coffee/customer/Customer.coffee'
      '!src/fantasy-core/coffee/contest/contestList.coffee'
      '!src/fantasy-core/coffee/ServiceContainer.coffee'
      '!src/fantasy-core/coffee/authentication/AuthenticationError.coffee'
      '!src/fantasy-core/coffee/authentication/AuthenticationManager.coffee'
    ]
