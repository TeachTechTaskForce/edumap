class SessionsController < ApplicationController
  def add_lesson
    lessons.push(lesson).uniq!
    render status: :ok, json: lessons.to_a
  end

  def remove_lesson
    lessons.delete(lesson)
    render status: :ok, json: lessons.to_a
  end

  def send_lessons
    SessionsMailer.lessons_email(params[:email], lessons).deliver_now
    if params[:clear_lessons]
      lessons = []
    end
  end

  protected

  def lessons
    session[:lessons] ||= []
  end

  def lesson
    params[:lesson]
  end
end
