class LessonsController < ApplicationController

  def index
    @filterrific = initialize_filterrific(
      Lesson,
      params[:filterrific],
      :select_options => {
        sorted_by: Lesson.options_for_sorted_by,
        with_standard: Standard.options_for_select,
        with_grade: Level.options_for_select,
        with_plugged: [["Yes", true], ["No", false]]
      }
    ) or return
    @lessons = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end
end
