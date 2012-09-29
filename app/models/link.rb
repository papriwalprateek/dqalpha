class Link < ActiveRecord::Base
  attr_accessible :body
  belongs_to :quest
end
