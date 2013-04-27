class Qmail < ActiveRecord::Base
validates :content, :presence => true
  attr_accessible :content, :user_id
  belongs_to :q
  belongs_to :user
  has_many :notifications, :dependent => :destroy
  
end
