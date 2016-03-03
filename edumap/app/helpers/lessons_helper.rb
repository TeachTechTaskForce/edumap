module LessonsHelper
  def in_session?(id)
    session[:lessons].include? id
  end
end
