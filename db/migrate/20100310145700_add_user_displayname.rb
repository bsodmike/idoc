class AddUserDisplayname < ActiveRecord::Migration
  def self.up
    add_column :users, :displayname, :string, :null => false, :default => ""
  end

  def self.down
    remove_column :users, :displayname
  end
end
