module LessonsHelper
  def in_session?(id)
    unless session[:lessons].blank?
      session[:lessons].include? id
    end
  end
end
