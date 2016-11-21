module.exports = (grunt) ->

  grunt.registerTask 'watch:dev', ->
    # Configuration for watch:test tasks.
    config =
      options:
        debounceDelay: 250
      css:
        files: ['src/css/**/*.css']
        tasks: ['copy:css']
      index:
        files: ['src/index.html']
        tasks: ['copy:index']
      livereload:
        options:
          livereload: true
        files: [
          'dist/*.*'
        ]

    grunt.config 'watch', config
    grunt.task.run 'watch'
