class Q < ActiveRecord::Base
  attr_accessible :title
  belongs_to :quest
  has_many :qmails, :dependent => :destroy
 def self.search(search,id)
    if search
      where(:quest_id => id).find(:all, :conditions =>  [ 'lower(title) LIKE  ?', "%#{search}%".downcase ])
    else
       where(:quest_id => id)
    end
  end
end
