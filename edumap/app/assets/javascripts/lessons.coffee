# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready =>
  $("table.table").on("change",".lesson-checkbox", (event)->
    that = $(this)[0]
    event.preventDefault()
    lesson_id = $(this).attr('data-lesson-id')
    if this.checked
      $.post Routes.add_lesson_path(lesson_id)
      .fail(
        (response) ->
          alert "Your choice could not be saved."
          that.checked = false
          return)
    else
      $.post Routes.remove_lesson_path(lesson_id)
      .fail(
        (response) ->
          alert "Your choice could not be saved."
          that.checked = true
          return)
)