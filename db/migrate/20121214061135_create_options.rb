class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :question_id
      t.string :content
      t.integer :votes_count, :default => 0

      t.timestamps
    end
  end
end
