class Question < ActiveRecord::Base
  attr_accessible :content, :poll_id
  belongs_to :poll
  has_many :options, :dependent => :destroy
   
end
