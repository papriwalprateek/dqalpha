class Notification < ActiveRecord::Base
  attr_accessible :content, :has_read, :of_type, :sender_id, :url, :user_id, :qmail_id
  belongs_to :qmail
  belongs_to :user
   def read
     if !has_read then
      update_attributes(:has_read => true);    
    end
  end

end
