class LessonsController < ApplicationController

  def index
    @filterrific = initialize_filterrific(
      Lesson,
      params[:filterrific],
      :select_options => {
        sorted_by: Lesson.options_for_sorted_by,
        with_standard: Standard.options_for_select,
        with_grade: Level.options_for_select
      }
    ) or return
    @lessons = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def load_lessons
    session[:lessons] = params[:lessons]
    redirect_to :saved_lessons
  end

  def saved_lessons
    @filterrific = initialize_filterrific(
      Lesson.where(id: session[:lessons]),
      params[:filterrific],
      :select_options => {
        sorted_by: Lesson.options_for_sorted_by,
        with_standard: Standard.options_for_select,
        with_grade: Level.options_for_select
      }
    ) or return
    @lessons = @filterrific.find.page(params[:page])

    render :index
  end
end
