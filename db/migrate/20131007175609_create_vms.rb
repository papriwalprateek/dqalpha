class CreateVms < ActiveRecord::Migration
  def change
    create_table :vms do |t|
      t.string :name

      t.timestamps
    end
  end
end
