# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready =>
  $(document).on "click", ".foo", (e) =>
    $.post Routes.add_lesson_path(1),
      success: -> alert "successful!"
