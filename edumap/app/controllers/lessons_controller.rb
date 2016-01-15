class LessonsController < ApplicationController

  def index
    @filterrific = initialize_filterrific(
      Lesson,
      params[:filterrific],
      :select_options => {
        sorted_by: Lesson.options_for_sorted_by,
        with_standard_id: Standard.options_for_select
      }
    ) or return
    @lessons = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end
end
