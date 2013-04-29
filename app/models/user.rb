  class User < ActiveRecord::Base
  after_create :deliver_signup_notification
 
  def verify!
    self.verified = true
    self.save
  end

  def deliver_signup_notification
   UserMailer.welcome_email(self)
  end

	has_many :posts, :dependent => :destroy
  has_many :gists
  has_many :notifications, :dependent => :destroy
  has_many :qmails
  has_many :involvements
  has_many :quests, :through => :involvements, :uniq => true
  def self.search(search)
    if search
      find(:all, :conditions => [ 'lower(name) LIKE ? or lower(email) LIKE ?', "%#{search}%".downcase, "%#{search}%".downcase ])
    else
       all
    end
    
  end
  acts_as_authentic
    attr_accessible :name, :email, :password, :password_confirmation
end

