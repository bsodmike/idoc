class DocumentationPage < ActiveRecord::Base
  has_many :comments
  acts_as_tree :order => 'position ASC'

  validates_presence_of :title, :content
end
