class MigrateDocumentationPagesToTree < ActiveRecord::Migration
  def self.up
    add_column :documentation_pages, :parent_id, :integer
    add_column :documentation_pages, :position, :integer
  end

  def self.down
    remove_column :documentation_pages, :parent_id
    remove_column :documentation_pages, :position

  end
end
