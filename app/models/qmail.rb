class Qmail < ActiveRecord::Base
validates :content, :presence => true
  attr_accessible :content, :user_id
  belongs_to :q
  belongs_to :user
  has_many :notifications, :dependent => :destroy
   def self.search(search,id)
    if search
      where(:q_id => id).find(:all, :conditions =>  [ 'lower(content) LIKE  ?', "%#{search}%".downcase ])
    else
       where(:q_id => id)
    end
  end
end
