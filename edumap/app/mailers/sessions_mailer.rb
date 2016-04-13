class SessionsMailer < ActionMailer::Base
  def lessons_email(email_address, lessons)
    @lessons = lessons
    mail(to: email_address, subject: "Edumap: Your Saved Lessons")
  end
end
