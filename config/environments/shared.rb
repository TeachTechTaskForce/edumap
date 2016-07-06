Rails.application.configure do
  if ENV["SENDGRID_USERNAME"] && ENV["SENDGRID_PASSWORD"] && ENV['CONTACT_TO']
    config.action_mailer.perform_deliveries = true

    config.action_mailer.smtp_settings = {
      :address   => "smtp.sendgrid.net",
      :port      => 587,
      :enable_starttls_auto => true,
      :user_name => ENV["SENDGRID_USERNAME"],
      :password  => ENV["SENDGRID_PASSWORD"],
      :authentication => 'login',
      :domain => 'edumap.com'
    }
  else # We have sendgrid creds, use it for sending emails
    config.action_mailer.perform_deliveries = false
    Rails.logger.warn "Warning: SENDGRID_USERNAME, SENDGRID_PASSWORD and CONTACT_TO environment variables must all be set for the contact form to work. Contact emails will appear in the logs but will not be sent."
  end
end