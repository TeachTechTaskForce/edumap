class ContactController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.create(contact_params)
    if @contact.errors.full_messages.length > 0
      flash[:alert] = @contact.errors.full_messages[0]
      redirect_to "/contact"
    else
      ActionMailer::Base.mail(:from => @contact.name + " <#{@contact.email}>", :to => "jsante@gmail.com", :subject => @contact.subject, :body => @contact.message + "\n\n" + (@contact.url ? "URL: #{@contact.url}" : "")).deliver_later
      flash[:notice] = "Mail sent!"
      redirect_to "/"
    end
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message, :url)
  end
end