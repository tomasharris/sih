
module.exports = (DEV) ->
  dev:
    files: 'dist/bundle.js': ['src/entry.coffee']
    options:
      transform: [
        'coffeeify',
      ]
      watch: true
      browserifyOptions:
        extensions: ['.coffee']
        debug: true
  dist:
    files: 'dist/bundle.js': ['src/entry.coffee']
    options:
      transform: [
        'coffeeify'
      ]
      browserifyOptions:
        extensions: ['.coffee']
        fullPaths: false
