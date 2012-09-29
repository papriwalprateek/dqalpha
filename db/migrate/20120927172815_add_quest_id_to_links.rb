class AddQuestIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :quest_id, :integer
  end
end
