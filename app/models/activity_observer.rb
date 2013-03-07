class ActivityObserver < ActiveRecord::Observer
observe :q, :qmail

   def after_create(a)
   if a.is_a?(Q) 
      @quest1 = a.quest
     integer = a.id
      @q = Q.find(integer)
      @quest1.users.each do |user|
         user.notifications.create(:content => ("New Thread "+@q.title+" is created in "+@quest1.title), :has_read=>false, :url=>"/users/"+user.id.to_s()+"/quests/"+@quest1.id.to_s())
      
      end
    else
      @q = a.q
     
       @quest1 = @q.quest
      integer = a.id
      qmail = Qmail.find(integer)
      @sender = qmail.user
      @quest1.users.each do |user|
         user.notifications.create(:content => ("New Post in thread "+@q.title+ " of "+@quest1.title), :has_read=>false, :url=>"/quests/"+@quest1.id.to_s()+"/qs/"+@q.id.to_s())
      end
   
    end
   end
end

