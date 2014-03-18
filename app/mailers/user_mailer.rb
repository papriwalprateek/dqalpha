class UserMailer < ActionMailer::Base
 include SendGrid
 default :from => "DaQwest <noreply@daqwest.com>"
  def welcome_email(user)
    @user = user
    @url  = "http://www.daqwest.com/"
    mail(:to => "vinayrajchoudhary@gmail.com", :subject => "Registered at Daqwest")
    
  end
 def new_qmail_notification(mail_id,qmail, n_id)
    @url  = "http://www.daqwest.com/"
    @qmail = qmail
    @n_id = n_id
    mail(:to => mail_id, :subject => "New Post added to thread "+@qmail.q.title+ " in the quest "+@qmail.q.quest.title)
  end
    def verification_instructions(user) 
   @verification_url =  "http://www.daqwest.com/user_verifications/#{user.perishable_token}"
   mail(:to => user.email, :subject => "Activate your account on daqwest")
 
  end
  def invite_mail(quest_id, user_name, invite_mail_id)
  @quest = Quest.find(quest_id)
  @user_name = user_name
  mail(:to => invite_mail_id, :subject => "Invited to Daqwest")
  end
  
  def feedback_mail(a,b)
    @feedback_name = a
    @feedback_content = b
    mail(:to => "vinayrajchoudhary@gmail.com", :subject => "Feedback @DaQwest")
   
  end
  def track_repo(a)
    @track_email = a
    mail(:to => "vinayrajchoudhary@gmail.com", :subject => "Track #AlgoRepo @DaQwest")
   
  end
end