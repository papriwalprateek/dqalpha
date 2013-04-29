class ActivityObserver < ActiveRecord::Observer
observe :q, :qmail

   def after_create(a)
   #if a.is_a?(Q) 
  #    @quest1 = a.quest
  #   integer = a.id
  #    @q = Q.find(integer)
  #    @quest1.users.each do |user|
  #       user.notifications.create(:content => ("New Thread "+@q.title+" is created in "+@quest1.title), :has_read=>false, :url=>"/users/"+user.id.to_s()+"/quests/"+@quest1.id.to_s())
      
   #   end
    if a.is_a?(Qmail)
      @q = a.q
     
       @quest1 = @q.quest
      integer = a.id
      @qmail = Qmail.find(integer)
      @sender = @qmail.user_id
      @quest1.users.each do |user|
        if(user.id!=@sender)         
        @n =  user.notifications.create(:qmail_id=>integer,:content => (User.find(@sender).name+" Posted in thread "+@q.title+ " of "+@quest1.title),:sender_id => @sender, :has_read=>false, :url=>"/quests/"+@quest1.id.to_s()+"/qs/"+@q.id.to_s()+"/?qmail_id="+integer.to_s())
       UserMailer.new_qmail_notification(@qmail,@n.id).deliver
 
        end
        
      
      end
    end
   end
end

