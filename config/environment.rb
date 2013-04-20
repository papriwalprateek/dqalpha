# Load the rails application
require File.expand_path('../application', __FILE__)
ActionMailer::Base.smtp_settings = {
  :address => "smtp.sendgrid.net",
  :port => 587,
  :domain => "www.daqwest.com",
  :authentication => :plain,
  :user_name => "vinayrajchoudhary",
  :password => "daqwest20",
  :enable_starttls_auto => true
}

# Initialize the rails application
Blog::Application.initialize!
