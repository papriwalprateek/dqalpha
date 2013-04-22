class UserMailer < ActionMailer::Base
 include SendGrid
 default :from => "DaQwest <noreply@daqwest.com>"
  def welcome_email(user)
    @user = user
    @url  = "http://www.daqwest.com/"
    mail(:to => "vinayrajchoudhary@gmail.com", :subject => "Registered at Daqwest")
  end
 def new_qmail_notification(user, qmail)
    @user = user
    @url  = "http://www.daqwest.com/"
    @qmail = qmail
    mail(:to => "vinayrajchoudhary@gmail.com", :subject => "New Post added to thread "+@qmail.q.title+ " in the quest "+@qmail.q.quest.title)
  end
end