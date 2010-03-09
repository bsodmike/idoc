class DocumentationPage < ActiveRecord::Base
  has_many :comments
  has_friendly_id :title, :use_slug => true
  acts_as_tree :order => 'position ASC'
  before_save :set_position

  validates_presence_of :title, :content

  def set_position
    if !self.position
      position = DocumentationPage.maximum(:position)
      self.position = position ? position + 1 : 1
    end
  end
end
