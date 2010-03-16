require 'tree_positioning'
require 'tree_navigation'

class DocumentationPage < ActiveRecord::Base
  has_many :comments

  validates_presence_of :title, :content
  has_friendly_id :title, :use_slug => true
  acts_as_tree :order => 'position ASC'

  include TreePositioning
  include TreeNavigation

  def has_parent?
    self.parent_id?
  end
end
