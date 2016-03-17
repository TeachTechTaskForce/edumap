class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :init_filterrific


  def init_filterrific
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
  end

  def index
  end
  
end
