class UserMailer < ActionMailer::Base
 include SendGrid
 default :from => "DaQwest <noreply@daqwest.com>"
  def welcome_email(user)
    @user = user
    @url  = "http://www.daqwest.com/"
    mail(:to => "vinayrajchoudhary@gmail.com", :subject => "Registered at Daqwest")
    
  end
 def new_qmail_notification(qmail)
    @url  = "http://www.daqwest.com/"
    @qmail = qmail
    mail(:to => "vinayrajchoudhary@gmail.com", :subject => "New Post added to thread "+@qmail.q.title+ " in the quest "+@qmail.q.quest.title)
  end
    def verification_instructions(user)

 
   @verification_url =  "http://www.daqwest.com/user_verifications/#{user.perishable_token}"
   mail(:to => user.email, :subject => "Activate your account on daqwest")
 
  end
  
end