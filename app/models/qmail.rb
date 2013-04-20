class Qmail < ActiveRecord::Base
     after_create :deliver_signup_notification

  def deliver_signup_notification
   UserMailer.welcome_email(User.find(5))
  end
  attr_accessible :content
  belongs_to :q
  belongs_to :user
end
