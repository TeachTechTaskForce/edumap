class ContactController < ApplicationController
  # GET /contact -> Show contact form
  def new
    @contact = Contact.new
  end

  # POST /contact -> Creates a 'contact' record and sends form params as an email
  # Requires: sendgrid.com account, configured in:
  # ENV['SENDGRID_USERNAME'] and ENV['SENDGRID_PASSWORD']
  # ENV['CONTACT_TO'] -- email address which recieves emails from the contact form
  def create
    @contact = Contact.create(contact_params)
    if @contact.errors.full_messages.length > 0
      flash[:alert] = @contact.errors.full_messages[0]
      redirect_to "/contact"
    else
      ActionMailer::Base.mail(:from => @contact.name + " <#{@contact.email}>", :to => ENV['CONTACT_TO'], :subject => @contact.subject, :body => @contact.message + "\n\n" + (@contact.url ? "URL: #{@contact.url}" : "")).deliver_later
      flash[:notice] = "Mail sent!"
      redirect_to "/"
    end
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message, :url)
  end
end