class Notification < ActiveRecord::Base
  attr_accessible :content, :has_read, :of_type, :sender_id, :url, :user_id
end
