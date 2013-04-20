# Load the rails application
require File.expand_path('../application', __FILE__)
ActionMailer::Base.smtp_settings = {
                            :address   => 'smtp.sendgrid.net',
                           :port      => 587,
                           :domain    => 'daqwest.com',
                            :user_name => "vinayrajchoudhary",
                            :password => "daqwest20",
                           :authentication => "plain",
                           :enable_starttls_auto => true
}

# Initialize the rails application
Blog::Application.initialize!
