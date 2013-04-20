class UserMailer < ActionMailer::Base
 include SendGrid
 default :from => "vinay@daqwest.com"
 def welcome_email(user)
    @user = user
    @url  = "http://www.daqwest.com/"
    
    mail(:to => "vinayrajchoudhary@gmail.com", :subject => "Welcome to Daqwest")
  end
end
