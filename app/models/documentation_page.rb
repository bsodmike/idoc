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
      #if we have a parent_id then we always have a previous item
      return true
    else
      #otherwise, if we don't the lowest position of all root pages, then we have a previous element 
      return DocumentationPage.minimum(:position, :conditions => "parent_id IS NULL") != self.position
    end
  end

  def has_up?
    self.parent_id ? true : false
  end

  def previous
    if self.has_previous?
      page_options = {:order => "position DESC"}
      if self.parent_id
        page_options[:conditions] = ["parent_id = ? AND position < ?", self.parent_id, self.position]
        page_options[:no_result] = self.parent
      else
        page_options[:conditions] = ["parent_id IS NULL AND position < ?", self.position]
        page_options[:no_result] = nil
      end
      return find_pages(page_options) do |result|
        while !result.children.empty?
          result = result.children[-1]
        end
        result
      end
    end
  end

  def next(options = nil)
    options ||= {}
    if self.has_next?
      return self.children[0] if !options[:ignore_children] && !self.children.empty?
      page_options = {:order => "position ASC"}
      if self.parent_id
        page_options[:conditions] = ["parent_id = ? AND position > ?", self.parent_id, self.position]
        page_options[:no_result] = self.parent.next(:ignore_children => true)
      else
        page_options[:conditions] = ["parent_id IS NULL AND position > ?", self.position]
        page_options[:no_result] = nil
      end

      return find_pages(page_options)
    end
  end

  def up
    if self.has_up?
      return self.parent
    end
  end

  private

  def find_pages(options)
    result = DocumentationPage.find(:first, :conditions => options[:conditions], :order => options[:order])
    if !result
      return options[:no_result]
    end
    result = yield result if block_given?
    return result
  end
end
