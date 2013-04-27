class AddQmailIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :qmail_id, :integer
  end
end
