class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :body

      t.timestamps
    end
  end
end
