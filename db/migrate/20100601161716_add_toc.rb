class AddToc < ActiveRecord::Migration
  def self.up
    add_column :documentation_pages, :toc, :text
  end

  def self.down
    remove_column :documentation_pages, :toc
  end
end
