class DropUniqueConstraint < ActiveRecord::Migration
  def self.up
    execute("ALTER TABLE documentation_pages DROP CONSTRAINT documentation_pages_parent_id_key")
  end

  def self.down
    execute("ALTER TABLE documentation_pages ADD UNIQUE(parent_id, position)")
  end
end
