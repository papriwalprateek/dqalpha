class Question < ActiveRecord::Base
  attr_accessible :content, :poll_id, :options_attributes
  belongs_to :poll
  has_many :options, :dependent => :destroy
  accepts_nested_attributes_for :options

end
