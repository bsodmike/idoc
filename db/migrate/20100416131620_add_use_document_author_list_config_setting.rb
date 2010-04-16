class AddUseDocumentAuthorListConfigSetting < ActiveRecord::Migration
  def self.up
    add_column :site_configs, :use_document_author_list, :boolean, :default => false
  end

  def self.down
    remove_column :site_configs, :use_document_author_list
  end
end
