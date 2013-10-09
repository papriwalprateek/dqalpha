class CreateQuestsVms < ActiveRecord::Migration
  def up
  create_table :quests_vms do |t|
      t.belongs_to :quest
      t.belongs_to :vm
    end
  end

  def down
  end
end
