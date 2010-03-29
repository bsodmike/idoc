begin
  require 'rdiscount'
  class TransformMarkdownToHtml < ActiveRecord::Migration
    def self.up
      DocumentationPage.all.each do |page|
        page.content = RDiscount.new(page.content).to_html
        page.save!
      end
      Comment.all.each do |comment|
        comment.body = RDiscount.new(comment.body).to_html
        comment.save!
      end
    end

    def self.down
      # Can't undo, but working in markdown with non-markdown data doesn't matter
    end
  end
rescue LoadError
  #if rdiscount isn't installed, then can't process the migration and there wouldn't be any
  #markdown content anyway
end

