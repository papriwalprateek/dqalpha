class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :content
      t.boolean :has_read
      t.integer :sender_id
      t.string :url
      t.string :of_type

      t.timestamps
    end
  end
end
