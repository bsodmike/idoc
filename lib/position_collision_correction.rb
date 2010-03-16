module PositionCollisionCorrection
  def self.included(base)
    base.send(:before_save, :fix_position_collisions)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def fix_collision(collision)
      collision.position += 1
      collision.save!
    end
  end

  def fix_position_collisions
    if collision = find_position_collisions
      self.class.fix_collision(collision)
    end
  end

  private

  def find_position_collisions
    if new_record?
      collision_conditions = collision_conditions_with_new_record
    else
      collision_conditions = collision_conditions_with_updated_record
    end
    return self.class.find :first, :conditions => collision_conditions
  end

  def collision_conditions_with_new_record
    {:parent_id => self.parent_id, :position => self.position}
  end

  def collision_conditions_with_updated_record
    if has_parent?
      ["id <> ? AND parent_id = ?   AND position = ?", self.id, self.parent_id, self.position]
    else
      ["id <> ? AND parent_id IS NULL AND position = ?", self.id, self.position]
    end
  end
end