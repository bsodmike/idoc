class CreateModeratorLists < ActiveRecord::Migration
  def self.up
    add_column :users, :moderator, :boolean, :default => false
  end

  def self.down
    remove_column :users, :moderator
  end
end
