# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready =>
  $(document).on("change",".lesson-checkbox", ->
    lesson_id = $(this).attr('data-lesson-id')
    if $(this).is(':checked')
      $.post Routes.add_lesson_path(lesson_id)
    else
      $.post Routes.remove_lesson_path(lesson_id)
)