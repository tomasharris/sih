fs = require 'fs'

module.exports = ->
  server:
    options:
      port: 3000
      useAvailablePort: true
      hostname: '*'
      base: 'dist'
      livereload: true
      middleware: (connect, options, middlewares) ->
        middlewares.unshift (req, res, next) ->
          res.setHeader 'Access-Control-Allow-Origin', '*'
          res.setHeader 'Access-Control-Allow-Methods', '*'
          return next()
        return middlewares

  dist:
    options:
      base: 'dist'
      port: 3001
      keepalive: true
