class Option < ActiveRecord::Base
  attr_accessible :content, :question_id, :votes_count
  belongs_to :question
end
