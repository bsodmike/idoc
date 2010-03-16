module EmptyPositionCorrection
  def self.included(base)
    base.send(:before_save, :set_position)
  end

  def set_position
    if !self.position
      set_position_to_bottom
    end
  end

  def set_position_to_bottom
    self.position = max_position_or_0 + 1
  end

  def max_position_or_0
    self.class.maximum(:position, :conditions => {:parent_id => self.parent_id}) || 0
  end
end