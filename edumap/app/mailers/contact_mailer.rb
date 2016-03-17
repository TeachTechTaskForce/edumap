class ContactMailer < ActionMailer::Base
  include SendGrid
  #sendgrid_category :use_subject_lines
  #sendgrid_enable   :ganalytics, :opentrack
  #sendgrid_unique_args :key1 => "value1", :key2 => "value2"

  def contact_message(contact)
    sendgrid_category "Contact"
    #sendgrid_unique_args :key2 => "newvalue2", :key3 => "value3"
    mail(:to => "jsante@gmail.com", :subject => contact.subject, :body => contact.body + "\n\nUrl: " + contact.url, :from => contact.from).deliver
  end

end