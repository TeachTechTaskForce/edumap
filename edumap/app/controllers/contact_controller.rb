class ContactController < ApplicationController
  def new
    @contact = Contact.new
  end
end
