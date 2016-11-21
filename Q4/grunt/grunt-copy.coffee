module.exports = ->
  css:
    cwd: 'src/css'
    src: ['**/*']
    dest: 'dist'
    expand: true
    filter: 'isFile'
  index:
    cwd: 'src'
    src: ['index.html']
    dest: 'dist'
    expand: true
    filter: 'isFile'
