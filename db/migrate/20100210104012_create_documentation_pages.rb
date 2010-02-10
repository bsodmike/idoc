class CreateDocumentationPages < ActiveRecord::Migration
  def self.up
    create_table :documentation_pages do |t|
      t.string :title, :null => false
      t.text :content, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :documentation_pages
  end
end
