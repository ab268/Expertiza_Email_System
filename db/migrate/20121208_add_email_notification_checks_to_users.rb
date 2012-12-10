class AddEmailNotificationChecksToUsers < ActiveRecord::Migration
  # To change this template use File | Settings | File Templates.
  def self.up
    add_column :users, :email_on_feedback, :boolean
    add_column :users, :email_on_waitlist_clear, :boolean
    add_column :users, :email_on_teammate_review, :boolean
  end
  def self.down

  end
end