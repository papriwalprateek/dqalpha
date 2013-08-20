class Q < ActiveRecord::Base
  attr_accessible :title
  belongs_to :quest
  has_many :qmails, :dependent => :destroy
  def add_questid(id)
    sql = "UPDATE pg_search_documents SET quest_id=#{id} WHERE searchable_type='Q' AND searchable_id=#{self.id} " 
    ActiveRecord::Base.connection.execute(sql) 
  end
  include PgSearch
  multisearchable :against => [:title]
end
