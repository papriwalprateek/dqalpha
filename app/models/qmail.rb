class Qmail < ActiveRecord::Base
validates :content, :presence => true
  attr_accessible :content, :user_id, :quest_id
  belongs_to :q
  belongs_to :user
  has_many :notifications, :dependent => :destroy
  def self.add_quest_id
    all.each do |qmail|
      begin 
        if !qmail.quest_id
          qmail.quest_id = qmail.q.quest.id
          qmail.save
        end        
      rescue
        qmail.quest_id = 2
        qmail.save
      end
    end
  end
  def add_questid(id)
    self.quest_id = id
    self.save
    sql = "UPDATE pg_search_documents SET quest_id=#{self.quest_id} WHERE searchable_type='Qmail' AND searchable_id=#{self.id} " 
    ActiveRecord::Base.connection.execute(sql) 
  end
  def add_qid(id)
    sql = "UPDATE pg_search_documents SET q_id=#{id} WHERE searchable_type='Qmail' AND searchable_id=#{self.id} " 
    ActiveRecord::Base.connection.execute(sql)   
  end
  include PgSearch
 
  multisearchable :against => [:content]
  PgSearch.multisearch_options = {
   :using => {
                     :tsearch => {
                                 :dictionary => "simple"
                                 }
                   }
   }
  def self.rebuild_pg_search_documents
    connection.execute <<-SQL
     INSERT INTO pg_search_documents (searchable_type, searchable_id, content, created_at, updated_at,quest_id,q_id)
       SELECT 'Qmail' AS searchable_type,
              qmails.id AS searchable_id,
              qmails.content AS content,
              now() AS created_at,
              now() AS updated_at,
              qmails.quest_id AS quest_id,
              qmails.q_id AS q_id
       FROM qmails
       Union ALL
      SELECT 'Q' AS searchable_type,
              qs.id AS searchable_id,
              qs.title AS content,
              now() AS created_at,
              now() AS updated_at,
              qs.quest_id AS quest_id,
              qs.id AS q_id
       FROM qs
       
    SQL
  end
end