class CreateGists < ActiveRecord::Migration
  def change
    create_table :gists do |t|
      t.string :title
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
