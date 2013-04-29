class UserSession < Authlogic::Session::Base

  validate :check_if_verified
   def to_key
     new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
  
  def persisted?
    false
  end
 private

  def check_if_verified

    errors.add(:base, "You have not yet verified your account") unless attempted_record && attempted_record.verified

  end

end