class AddDocumentAuthorToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :document_author, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :users, :document_author
  end
end
