class UserMailer < ActionMailer::Base
 include SendGrid
 default :from => "vinay@daqwest.com"
 def welcome_email(user, qmail)
    @user = user
    @url  = "http://www.daqwest.com/"
    @qmail = qmail
  mail(:to => "vinayrajchoudhary@gmail.com", :subject => "Registered")
  end
end
