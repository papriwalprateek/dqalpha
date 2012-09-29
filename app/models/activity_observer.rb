class ActivityObserver < ActiveRecord::Observer
observe :q, :qmail

   def after_create(model)
    
   end
end
