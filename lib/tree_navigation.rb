module TreeNavigation
  def has_next?(include_children = true)
    if include_children && !self.children.empty?
      return true
    elsif has_parent?
      return self.parent.has_next?(false) ? true :  !self.class.find(:first, :conditions => ["parent_id = ? AND position > ?", self.parent_id, self.position]).nil?
    else
      return !self.class.find(:first, :conditions => ["parent_id IS NULL AND position > ?", self.position]).nil?
    end
  end

  def has_previous?
    if has_parent?
      #if we have a parent_id then we always have a previous item
      return true
    else
      #otherwise, if we don't the lowest position of all root pages, then we have a previous element
      return self.class.minimum(:position, :conditions => "parent_id IS NULL") != self.position
    end
  end

  def has_up?
    has_parent?
  end

  def previous
    if has_previous?
      page_options = {:order => "position DESC"}
      if has_parent?
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
      if has_parent?
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
    result = self.class.find(:first, :conditions => options[:conditions], :order => options[:order])
    if !result
      return options[:no_result]
    end
    result = yield result if block_given?
    return result
  end
end