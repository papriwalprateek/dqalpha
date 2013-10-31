class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :organization, :string, :default => "---edit---"
    add_column :users, :location, :string, :default => "---edit---"
    add_column :users, :education, :string, :default => "---edit---"
    add_column :users, :description, :string, :default => "---edit---"
  end
end
