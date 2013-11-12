class AddQIdToPgSearchDocuments < ActiveRecord::Migration
  def change
    add_column :pg_search_documents, :q_id, :integer
  end
end
