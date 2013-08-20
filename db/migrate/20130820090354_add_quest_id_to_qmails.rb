class AddQuestIdToQmails < ActiveRecord::Migration
  def change
    add_column :qmails, :quest_id, :integer
  end
end
