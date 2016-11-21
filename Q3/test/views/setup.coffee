jsdom = require('jsdom').jsdom
document = jsdom('<html></html>', {})
window = document.defaultView
global.jQuery = require('jquery')(window)
global.$ = jQuery
