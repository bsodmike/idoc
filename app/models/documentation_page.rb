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

  def has_next?(include_children = true)
    if include_children && !self.children.empty?
      return true
    elsif self.parent_id
      return self.parent.has_next?(false) ? true :  !DocumentationPage.find(:first, :conditions => ["parent_id = ? AND position > ?", self.parent_id, self.position]).nil?
    else
      return !DocumentationPage.find(:first, :conditions => ["parent_id IS NULL AND position > ?", self.position]).nil?
    end
  end

  def has_previous?
    if self.parent_id
      return !DocumentationPage.find(:first, :conditions => ["parent_id = ? AND position < ?", self.parent_id, self.position]).nil?
    else
      return !DocumentationPage.find(:first, :conditions => ["parent_id IS NULL AND position < ?", self.position]).nil?
    end
  end

  def previous
    if self.has_previous?
      if self.parent_id
        return DocumentationPage.find(:first, :conditions => ["parent_id = ? AND position < ?", self.parent_id, self.position], :order => "position DESC")
      else
        return DocumentationPage.find(:first, :conditions => ["parent_id IS NULL AND position < ?", self.position], :order => "position DESC")
      end
    end
  end

  def next(include_children = true)
    if self.has_next?
      return self.children[0] if include_children && !self.children.empty?
      if self.parent_id
        result = DocumentationPage.find(:first, :conditions => ["parent_id = ? AND position > ?", self.parent_id, self.position], :order => "position ASC")
        return result ? result : self.parent.next(false)
      else
        return DocumentationPage.find(:first, :conditions => ["parent_id IS NULL AND position > ?", self.position], :order => "position ASC")
      end
    else
      return nil
    end
  end
end
