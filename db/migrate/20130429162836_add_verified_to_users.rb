class AddVerifiedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verified, :boolean
    add_column :users, :perishable_token, :string, :default => "", :null => false  
	add_index :users, :perishable_token  
  end
end
