# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

delay = (ms, func) -> setTimeout func, ms
delay 15 * 60 * 60 * 1000, -> window.location.reload(false)
