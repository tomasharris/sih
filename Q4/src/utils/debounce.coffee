# Blantantly stolen from https://davidwalsh.name/javascript-debounce-function
module.exports = debounce = (func, wait, immediate) ->
  timeout = null
  =>
    context = @
    args = arguments

    later = ->
      timeout = null
      if !immediate
        func.apply context, args
      return

    callNow = immediate and !timeout
    clearTimeout timeout
    timeout = setTimeout(later, wait)
    if callNow
      func.apply context, args
    return
