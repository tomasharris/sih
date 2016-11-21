module.exports = (grunt) ->

  DEV = process.env.NODE_ENV is 'development'

  grunt.initConfig

    ##
    ## Building
    ##
    browserify:   require('./grunt/grunt-browserify')(DEV)
    copy:         require('./grunt/grunt-copy')()

    coffeelint: require('./grunt/grunt-coffeelint')()
    connect:    require('./grunt/grunt-connect')() # Dev :3000 Dist :3001

  require('./grunt/grunt-watch')(grunt)

  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  buildTasks = [
    'copy:index'
    'copy:css'
  ]

  # Build
  grunt.registerTask 'build', buildTasks

  # Run
  grunt.registerTask 'dev', ['connect:server', 'coffeelint', 'build', 'browserify:dev', 'watch:dev']
  grunt.registerTask 'dist', ['build', 'browserify:dist', 'connect:dist']
