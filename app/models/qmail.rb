class Qmail < ActiveRecord::Base
validates :content, :presence => true
  attr_accessible :content, :user_id, :quest_id
  belongs_to :q
  belongs_to :user
  has_many :notifications, :dependent => :destroy
  def self.add_quest_id
    all.each do |qmail|
      qmail.quest_id = qmail.q.quest.id
      qmail.save
    end
  end
  def add_questid(id)
    self.quest_id = id
    self.save
    sql = "UPDATE pg_search_documents SET quest_id=#{self.quest_id} WHERE searchable_type='Qmail' AND searchable_id=#{self.id} " 
    ActiveRecord::Base.connection.execute(sql) 
  end
  include PgSearch
  multisearchable :against => [:content]
 
  def self.rebuild_pg_search_documents
    connection.execute <<-SQL
     INSERT INTO pg_search_documents (searchable_type, searchable_id, content, created_at, updated_at,quest_id)
       SELECT 'Qmail' AS searchable_type,
              qmails.id AS searchable_id,
              qmails.content AS content,
              now() AS created_at,
              now() AS updated_at,
              qmails.quest_id AS quest_id
       FROM qmails
       Union ALL
      SELECT 'Q' AS searchable_type,
              qs.id AS searchable_id,
              qs.title AS content,
              now() AS created_at,
              now() AS updated_at,
              qs.quest_id AS quest_id
       FROM qs
       
    SQL
  end
end